using System;
using System.IO;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Globalization;
using GAV.DBF;

public partial class moper_ExportDbf : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        System.Threading.Thread.CurrentThread.CurrentCulture = System.Threading.Thread.CurrentThread.CurrentUICulture;
        if (!IsPostBack)
        {
            try
            {
                InitOraConnection();

                SetRole("basic_info");
                CultureInfo cinfo = new CultureInfo("en-GB", true);
                cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";

                Calendar.SelectedDates.Clear();
                string s_date = Convert.ToString(SQL_SELECT_scalar("select to_char(max(fdat),'dd/MM/yyyy')  from fdat where fdat<web_utl.get_bankdate and ( stat is null or stat = '9')"));
                
                DateTime bDate = DateTime.Parse(s_date, cinfo);
                tbDate.Date = bDate;
                Calendar.TodaysDate = bDate;
                Calendar.VisibleDate = bDate.AddDays(-bDate.Day + 1);

                SQL_Reader_Exec("SELECT to_char(fdat,'dd/MM/yyyy') FROM fdat WHERE NVL(stat, 0)=0 and fdat < bankdate_g");
                while (SQL_Reader_Read())
                {
                    DateTime fDate = Convert.ToDateTime(DateTime.Parse(SQL_Reader_GetValues()[0].ToString(), cinfo));
                    Calendar.SelectedDates.Add(fDate);
                }
                SQL_Reader_Close();

                SetRole("wr_moper");
                SetParameters("sab", DB_TYPE.Varchar2, Request.Params.Get("sab"), DIRECTION.Input);
                lbBank.Text = "\"" + Convert.ToString(SQL_SELECT_scalar("select nb from banks where sab=UPPER(:sab)")) + "\"";

                tbFileName.Text = Request.Params.Get("sab").ToUpper() + tbDate.Date.ToString("ddMM._yy");
                ddVid.Items.Add(new ListItem(Resources.moper.GlobalResource.Vipiska1, "Vipiska1.xml",true));
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }

    private void setCalendar()
    {
        try
        {
            InitOraConnection();
            SetRole("basic_info");
            CultureInfo cinfo = new CultureInfo("en-GB", true);
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            SQL_Reader_Exec("SELECT to_char(fdat,'dd/MM/yyyy') FROM fdat WHERE NVL(stat, 0)=0 and fdat < bankdate_g");
            while (SQL_Reader_Read())
            {
                DateTime fDate = Convert.ToDateTime(DateTime.Parse(SQL_Reader_GetValues()[0].ToString(), cinfo));
                Calendar.SelectedDates.Add(fDate);
            }
            SQL_Reader_Close();
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    protected void btGetData_Click(object sender, EventArgs e)
    {
        try
        {
            InitOraConnection();
            SetRole("wr_moper");

            SQL_NONQUERY("delete from tmp_sab");
            SetParameters("sab", DB_TYPE.Varchar2, Request.Params.Get("sab").ToUpper(), DIRECTION.Input);
            SQL_NONQUERY("insert into tmp_sab(sab) values(:sab)");

            ClearParameters();
            SetParameters("date", DB_TYPE.Date, tbDate.Date, DIRECTION.Input);
            SQL_NONQUERY("begin p_lick(user_id,:date); end;");

            ClearParameters();
            SetParameters("sab", DB_TYPE.Varchar2, Request.Params.Get("sab").ToUpper(), DIRECTION.Input);
            DataTable tbl = SQL_SELECT_dataset("select SAB,NLS,NAMS,nvl(NLSK,0) NLSK,NMK,MFO,ND,ISP,EL,NM,NP,VOB,DECODE(DK,1,0) DK,S,DAOPL,null ISS,null \"IS\",DAPP,NAZ,null NS,0 KLIP,POND,RNK,KOKK,null SK,TD,ISPZ,REF,POLU from tmp_lick where dk=1 and sab=:sab and id=user_id and nls in (select nls from saldo)").Tables[0];
            lbCountVal.Text = tbl.Rows.Count.ToString();             
            Session["ExportDbfTable"] = tbl;
            if (tbl.Rows.Count > 0)
            {
                btGenerateDbf.Enabled = true;
                btShowData.Enabled = true;
            }
            else
            {
                btGenerateDbf.Enabled = false;
                btShowData.Enabled = false;
                lbInfo.Text = Resources.moper.GlobalResource.Msg_NoData;
                divFrame.Visible = false;
                lbInfo.Visible = true;
            }
        }
        finally
        {
            DisposeOraConnection();
        }

    }
    protected void btGenerateDbf_Click(object sender, EventArgs e)
    {
        DataTable table = (DataTable)Session["ExportDbfTable"];
        table.Rows.InsertAt(table.NewRow(), 0);

        string filename = Request.Params.Get("sab").ToUpper() + tbDate.Date.ToString("ddMM._yy");
        try
        {
            File.Delete(Path.GetTempPath() + "\\" + filename);
        }
        catch { }
        FileStream fs = new FileStream(Path.GetTempPath() + "\\"+filename, FileMode.Create);
        try
        {
            DBFWriter dbfWriter = new DBFWriter();
            dbfWriter.Stream = fs;
            dbfWriter.CodePage = DBFWriter.FileCodePage.c_866;
            dbfWriter.RecordsInTable = table.Rows.Count;
            dbfWriter.AddFieldDescriptorsFromXml(Server.MapPath("/barsroot/moper/Xml") + "\\" + ddVid.SelectedValue);
            dbfWriter.WriteHeader();

            foreach (DataRow row in table.Rows)
                dbfWriter.WriteRecord(row);
        }
        finally
        {
            fs.Close();
        }

        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "utf-8";
        Response.ContentType = "application/octet-stream";
        Response.ContentEncoding = Encoding.UTF8;
        Response.AppendHeader("content-disposition", "attachment;filename=" + filename);
        Response.WriteFile(Path.GetTempPath() + "\\" + filename, true);
        Response.Flush();
        Response.Close();
        
        try
        {
            File.Delete(Path.GetTempPath() + "\\" + filename);
        }
        catch{}
    }
    protected void Calendar_SelectionChanged(object sender, EventArgs e)
    {
        tbDate.Date = Calendar.SelectedDate;
        Calendar.TodaysDate = Calendar.SelectedDate;
        setCalendar();
        btGenerateDbf.Enabled = false;
        btShowData.Enabled = false;
        lbCountVal.Text = "";

        divFrame.Visible = false;
        lbInfo.Visible = false;
        tbFileName.Text = Request.Params.Get("sab").ToUpper() + tbDate.Date.ToString("ddMM._yy");
    }
    protected void Calendar_DayRender(object sender, DayRenderEventArgs e)
    {
        if (Calendar.TodaysDate == e.Day.Date)
            e.Cell.BackColor = System.Drawing.Color.LightGreen;
        if (!e.Day.IsSelected)
            e.Day.IsSelectable = false;
    }
    protected void btShowData_Click(object sender, EventArgs e)
    {
        DataGrid.DataSource = (DataTable)Session["ExportDbfTable"];
        DataGrid.DataBind();
        lbInfo.Text = Resources.moper.GlobalResource.Msg_DataDbf;
        divFrame.Visible = true;
        lbInfo.Visible = true;
    }
}
