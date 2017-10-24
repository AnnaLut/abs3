using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;

public partial class clientregister_tab_linked_custs_seal_img : Bars.BarsPage
{
    private string TempDir
    {
        get
        {
            string sTempDir = Path.GetTempPath() + "PictureFiles\\";

            //-- если дериктории нету, то создаем ее
            DirectoryInfo TmpDitInf = new DirectoryInfo(sTempDir);
            if (!TmpDitInf.Exists) TmpDitInf.Create();

            return sTempDir;
        }
    }
    private string TempFileName
    {
        get
        {
            return "img.gif";
        }
    }
    private FileInfo fi 
    {
        get 
        {
            return new FileInfo(this.TempDir + this.TempFileName);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string sType = Request.Params.Get("mode");
            decimal nSealId = Convert.ToDecimal(Request.Params.Get("id"));

            switch (sType.ToUpper())
            {
                case "THROW":

                    # region "THROW"

                    //-----------------------------------------------------------------
                    //-- достаем рисунок
                    DataTable dt = new DataTable();
                    InitOraConnection(Context);
                    try
                    {
                        SetRole("WR_CUSTREG");

                        SetParameters("pId", DB_TYPE.Int32, nSealId, DIRECTION.Input);
                        dt = SQL_SELECT_dataset("SELECT BIN_DATA FROM CUSTOMER_BIN_DATA WHERE ID = :pId").Tables[0];
                    }
                    finally
                    {
                        DisposeOraConnection();
                    }

                    //-----------------------------------------------------------------
                    if (dt.Rows.Count > 0)
                    {
                        byte[] byteData = (byte[])dt.Rows[0].ItemArray[0];

                        FileStream fs = fi.OpenWrite();
                        fs.Write(byteData, 0, byteData.Length);
                        fs.Close();
                    }
                    else
                    {
                        //-----------------------------------------------------------------
                        //-- формируем файл
                        Bitmap bmp = new Bitmap(150, 150);
                        System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bmp);

                        StringFormat st = new StringFormat();
                        st.Alignment = StringAlignment.Center;

                        g.DrawLine(new Pen(Color.Black, 2), new Point(0, 0), new Point(150, 150));
                        g.DrawLine(new Pen(Color.Black, 2), new Point(0, 150), new Point(150, 0));

                        bmp.Save(TempDir + TempFileName);
                    }

                    //-----------------------------------------------------------------
                    //-- брасаем в поток
                    Response.Clear();
                    Response.ContentType = "application/octet-stream";
                    Response.AppendHeader("Cache-control", "private");
                    Response.AppendHeader("Content-Location", TempDir + TempFileName);
                    Response.AppendHeader("Location", TempDir + TempFileName);

                    Response.AddHeader("Content-Disposition", "attachment;filename=" + TempFileName);
                    Response.Flush();
                    Response.WriteFile(TempDir + TempFileName);
                    Response.End();

                    //-----------------------------------------------------------------
                    //-- удаляем файл
                    fi.Delete();

                    break;

                    # endregion

                case "SET":

                    # region SET

                    imdSeal.ImageUrl = "tab_linked_custs_seal_img.aspx?mode=throw&id=" + nSealId.ToString();
                    imdSeal.Attributes["srcid"] = nSealId.ToString();

                    # endregion

                    break;
            }
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        if (fuLoad.HasFile)
        {
            fuLoad.PostedFile.SaveAs(TempDir + TempFileName);

            //Читаем файл				
            FileStream fs = fi.OpenRead();
            byte[] text = new byte[fs.Length];

            int i = 0;
            do
            {
                i += fs.Read(text, i, (int)(fs.Length - i));
            }
            while (i < fs.Length);

            fs.Close();

            //Удаляем файл
            fi.Delete();

            //Пишем текст договора в БД
            InitOraConnection(Context);
            string ResId = "0";
            try
            {
                SetRole("WR_CUSTREG");

                ClearParameters();
                SetParameters("pId", DB_TYPE.Int32, null, DIRECTION.Output);
                SetParameters("pImg", DB_TYPE.Blob, text, DIRECTION.Input);

                SQL_NONQUERY(@"begin kl.setCustomerSeal(:pId, :pImg); commit; end;");

                ResId = Convert.ToString(GetParameter("pId"));
            }
            finally
            {
                DisposeOraConnection();
            }

            // Отображаем
            imdSeal.ImageUrl = "tab_linked_custs_seal_img.aspx?mode=throw&id=" + ResId;
            imdSeal.Attributes["srcid"] = ResId;
        }
    }
}
