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

public partial class LoadFile : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable dtData = new DataTable();

            InitOraConnection(Context);
            try
            {
                SetRole("WR_CUSTREG");
                dtData = SQL_SELECT_dataset("SELECT ID FROM CUSTOMER_BIN_DATA ORDER BY ID").Tables[0];
            }
            finally
            {
                DisposeOraConnection();
            }

            // добавляем данные в таблицу
            DataTable dtImages = new DataTable();
            dtImages.Columns.Add("NO0");
            dtImages.Columns.Add("IMG0");
            dtImages.Columns.Add("NO1");
            dtImages.Columns.Add("IMG1");
            dtImages.Columns.Add("NO2");
            dtImages.Columns.Add("IMG2");
            dtImages.Columns.Add("NO3");
            dtImages.Columns.Add("IMG3");

            for (int i = 0; i < dtData.Rows.Count / 4; i++)
            {
                DataRow row = dtImages.NewRow();

                object[] data = { dtData.Rows[i*4][0].ToString(), "pictureFile.aspx?id=" + dtData.Rows[i*4][0].ToString(),
                dtData.Rows[i*4 + 1][0].ToString(), "pictureFile.aspx?id=" + dtData.Rows[i*4 + 1][0].ToString(),
                dtData.Rows[i*4 + 2][0].ToString(), "pictureFile.aspx?id=" + dtData.Rows[i*4 + 2][0].ToString(),
                dtData.Rows[i*4 + 3][0].ToString(), "pictureFile.aspx?id=" + dtData.Rows[i*4 + 3][0].ToString() };

                row.ItemArray = data;
                dtImages.Rows.Add(row);
            }

            // заполняе последний ряд
            if (dtData.Rows.Count > dtImages.Rows.Count * 4)
            {
                DataRow rowLast = dtImages.NewRow();

                object[] dataLast = { (dtImages.Rows.Count*4 < dtData.Rows.Count)?(dtData.Rows[dtImages.Rows.Count*4][0].ToString()):(""), (dtImages.Rows.Count*4 < dtData.Rows.Count)?("pictureFile.aspx?id=" + dtData.Rows[dtImages.Rows.Count*4][0].ToString()):(""),
                (dtImages.Rows.Count*4 + 1 < dtData.Rows.Count)?(dtData.Rows[dtImages.Rows.Count*4 + 1][0].ToString()):(""), (dtImages.Rows.Count*4 + 1 < dtData.Rows.Count)?("pictureFile.aspx?id=" + dtData.Rows[dtImages.Rows.Count*4 + 1][0].ToString()):(""),
                (dtImages.Rows.Count*4 + 2 < dtData.Rows.Count)?(dtData.Rows[dtImages.Rows.Count*4 + 2][0].ToString()):(""), (dtImages.Rows.Count*4 + 2 < dtData.Rows.Count)?("pictureFile.aspx?id=" + dtData.Rows[dtImages.Rows.Count*4 + 2][0].ToString()):(""),
                (dtImages.Rows.Count*4 + 3 < dtData.Rows.Count)?(dtData.Rows[dtImages.Rows.Count*4 + 3][0].ToString()):(""), (dtImages.Rows.Count*4 + 3 < dtData.Rows.Count)?("pictureFile.aspx?id=" + dtData.Rows[dtImages.Rows.Count*4 + 3][0].ToString()):("") };

                rowLast.ItemArray = dataLast;
                dtImages.Rows.Add(rowLast);
            }

            gvMain.DataSource = dtImages;
            gvMain.DataBind();

            // добавляем обработчик события клика
            for (int i = 0; i < gvMain.Rows.Count; i++)
                for (int j = 0; j < gvMain.Columns.Count / 2; j++)
                {
                    gvMain.Rows[i].Cells[j*2].Attributes.Add("onclick", "CloseDialog('" + gvMain.Rows[i].Cells[j*2].Text + "')");
                    gvMain.Rows[i].Cells[j*2+1].Attributes.Add("onclick", "CloseDialog('" + gvMain.Rows[i].Cells[j*2].Text + "')");
                }
        }
    }
    protected void btApplyNew_Click(object sender, EventArgs e)
    {
        //-- темповая дериктория
        string TempDir = Path.GetTempPath() + "PictureFiles\\";
        DirectoryInfo TmpDitInf = new DirectoryInfo(TempDir);
        //-- если дериктории нету, то создаем ее
        if (!TmpDitInf.Exists) TmpDitInf.Create();

        if (fuNew.HasFile)
        {
            string posFileName = fuNew.PostedFile.FileName;
            string TempFile = posFileName.Substring(posFileName.LastIndexOf("\\") + 1);
            string TempPath = TempDir + TempFile;
            fuNew.PostedFile.SaveAs(TempPath);

            FileInfo fi = new FileInfo(TempPath);
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
            File.Delete(TempPath);

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
            //--закрываем диалог
            string Script = "<script language=javascript>CloseDialog('" + ResId + "')</script>";
            RegisterStartupScript("script1", Script);
        }
        else
        {
            string Script = "<script language=javascript>CloseDialog('0')</script>";
            RegisterStartupScript("script1", Script);
        }

    }
}
