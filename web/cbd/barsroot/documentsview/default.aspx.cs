using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Globalization;
using System.Threading;



namespace BarsWeb.DocumentsView
{
    /// <summary>
    /// Стартовая страница приложения просмотра документов
    /// </summary>
    public partial class _default : Bars.BarsPage
    {


        protected void Page_Load(object sender, System.EventArgs e)
        {

            string type = Request.Params.Get("type");
            //string strHeader = "";

            if (Request.Params.Get("recdocs") != null)
            {
                pnRecDocs.Visible = false;
            }

            switch (type)
            {
                case "0":
                    lb_headerUser.Style.Add("DISPLAY", "none");
                    lb_headerSaldo.Style.Add("DISPLAY", "none");
                    //strHeader = "Документы отделения";
                    break;
                case "1":
                    lb_headerBranch.Style.Add("DISPLAY", "none");
                    lb_headerSaldo.Style.Add("DISPLAY", "none");
                    //strHeader = "Документы пользователя";
                    break;
                case "2":
                    lb_headerUser.Style.Add("DISPLAY", "none");
                    lb_headerBranch.Style.Add("DISPLAY", "none");
                    //strHeader = "Документы по доступным счетам";
                    break;

                default: //-- Ошибка!!!
                    throw new Exception("Страница вызвана без необходимого параметра!");
            }

            DateTime SysDate = DateTime.Now;

            if (!IsPostBack)
                Calendar.Visible = false;

            if (Session["documents.dateBegin"] == null)
            {
                try
                {
                    InitOraConnection(Context);
                    SetRole("basic_info");
                    SysDate = (DateTime)SQL_SELECT_scalar("SELECT trunc(sysdate) FROM DUAL");
                    Session["documents.dateBegin"] = SysDate.AddDays(-7);
                    Session["documents.dateFinish"] = SysDate;
                    dateBegin.Date = Convert.ToDateTime(Session["documents.dateBegin"]);
                    dateFinish.Date = Convert.ToDateTime(Session["documents.dateFinish"]);
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
            else
            {
                dateBegin.Date = Convert.ToDateTime(Session["documents.dateBegin"]);
                dateFinish.Date = Convert.ToDateTime(Session["documents.dateFinish"]);
            }
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            cinfo.DateTimeFormat.DateSeparator = ".";
            lb_docdate.InnerText = SysDate.ToString("d", cinfo.DateTimeFormat);

            lnk_showAll.Attributes["onclick"] = "location.replace('/barsroot/documentsview/documents.aspx?type=" + type + "&par=" + "11')";
            lnk_showAllRes.Attributes["onclick"] = "location.replace('/barsroot/documentsview/documents.aspx?type=" + type + "&par=" + "12')";
            lnk_showAllalldat.HRef = "/barsroot/documentsview/documents.aspx?type=" + type + "&par=" + "21";
            lnk_showAllResalldat.HRef = "/barsroot/documentsview/documents.aspx?type=" + type + "&par=" + "22";
        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {

        }
        #endregion

        protected void Calendar_SelectionChanged(object sender, System.EventArgs e)
        {
            CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
            cinfo.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            cinfo.DateTimeFormat.DateSeparator = ".";
            if (Convert.ToByte(Session["DateType"]) == 0)
                dateBegin.Value = Convert.ToDateTime(Calendar.SelectedDate, cinfo);
            else
                dateFinish.Value = Convert.ToDateTime(Calendar.SelectedDate, cinfo);
            Session["documents.dateBegin"] = dateBegin.Value;
            Session["documents.dateFinish"] = dateFinish.Value;
        }

        protected void imgShowCalendar_Click(object sender, ImageClickEventArgs e)
        {
            Calendar.Visible = true;
            Session["DateType"] = 0;
        }
        protected void imgShowCalendar2_Click(object sender, ImageClickEventArgs e)
        {
            Calendar.Visible = true;
            Session["DateType"] = 1;
        }
    }
}
