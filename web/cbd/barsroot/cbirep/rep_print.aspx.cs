using System;
using System.Text;
using System.Web;
using System.Xml;
using Bars.Classes;
using Bars.Exception;
using Bars.ObjLayer.CbiRep;
using cbirep;
using FastReport;
using ibank.core;

public partial class cbirep_rep_print : Bars.BarsPage
{
    # region Константы
    public const String XMLVersion = "1.0";
    public const String XMLEncoding = "UTF-8";
    public const String DateFormat = "dd.MM.yyyy";
    public const String DateTimeFormat = "dd.MM.yyyy HH:mm:ss";
    public const String NumberFormat = "######################0.00##";
    public const String DecimalSeparator = ".";
    # endregion

    # region Приватные свойства
    private Decimal? _QUERY_ID = (Decimal?)null;
    public VCbirepRepresultsRecord _Results;
    private VCbirepReplistRecord _CbirepRep;
    private VCbirepRepparamsRecord _CbirepRepParams;
    private ParsedReport _Report;
    private Report frReport;
    # endregion

    # region Публичные свойства
    public Decimal QUERY_ID
    {
        get
        {
            if (!_QUERY_ID.HasValue)
            {
                // обязательный парамет
                if (Request.Params.Get("query_id") == null)
                    throw new BarsException("НЕ задано обов`язковий параметр repid");
                _QUERY_ID = Convert.ToDecimal(Request.Params.Get("query_id"));
            }

            return _QUERY_ID.Value;
        }
    }
    public VCbirepRepresultsRecord Results
    {
        get
        {
            if (_Results == null)
                _Results = (new VCbirepRepresults()).SelectCbirepRepresult(QUERY_ID);

            return _Results;
        }
    }
    public VCbirepReplistRecord CbirepRep
    {
        get
        {
            if (_CbirepRep == null)
                _CbirepRep = (new VCbirepReplist()).SelectCbirepRep(Results.REP_ID);

            return _CbirepRep;
        }
    }
    public VCbirepRepparamsRecord CbirepRepParams
    {
        get
        {
            if (_CbirepRepParams == null)
                _CbirepRepParams = (new VCbirepRepparams()).FindRepByRepID(Results.REP_ID);

            return _CbirepRepParams;
        }
    }
    public ParsedReport Report
    {
        get
        {
            if (_Report == null)
            {
                _Report = new ParsedReport(CbirepRepParams);

                XmlDocument doc = new XmlDocument();
                doc.LoadXml(Results.XML_PARAMS);

                _Report.FillValues(doc);
            }

            return _Report;
        }
    }
    public String GeneratedFilePath
    {
        get
        {
            return (ViewState["GENERATEDFILEPATH"] == null ? String.Empty : (String)ViewState["GENERATEDFILEPATH"]);
        }
        set
        {
            ViewState.Add("GENERATEDFILEPATH", value);
        }
    }
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Params.Get("type") != null /*&& Request.Params.Get("type").ToLower() == "file"*/)
        {
            GetFile(Request.Params.Get("type"));
            return;
        }
        /*if (Request.Params.Get("type") != null && Request.Params.Get("type").ToLower() == "iframe")
        {
            GetFile();
            return;
        }*/


        using (var report = new CreateReport(QUERY_ID, OraConnector.Handler.IOraConnection.GetUserConnectionString()))
        {
            //ReportSystemParams rsp = new ReportSystemParams(report.Results.REP_ID.Value, Results.SESSION_ID.ToString(),Report.FileTypeCode.ToString(), Report.FileNameFull);

            if (!IsPostBack)
            {
                btPrint.Attributes.Add("onclick",string.Format("printFile('{0}');return false;",HttpUtility.UrlEncode("/barsroot/cbirep/rep_print.aspx?query_id=" + QUERY_ID + "&type=file")));
                btBack.Attributes.Add("onclick",string.Format("document.location.href='{0}';return false;", Request.UrlReferrer));
                //ViewState["PrevUrl"] = Request.UrlReferrer.ToString();

                // заголовок страницы
                Title = String.Format(Title, CbirepRep.REP_ID, CbirepRep.REP_DESC);
                lbPageTitle.Text = String.Format(lbPageTitle.Text, CbirepRep.REP_ID, CbirepRep.REP_DESC);

                rParams.DataSource = report.Report.Params;
                rParams.DataBind();

                // проверяем наличие шаблона
                if (!report.CheckQrpAccess(report.CbirepRepParams.RPT_TEMPLATE))
                {
                    throw new BarsException(String.Format("НЕ знайдено шаблон {0}. Зверніться до адміністратора",CbirepRepParams.RPT_TEMPLATE));
                }

                // первичная настройка контролов
                InitSetupControls(report);
            }
            if (report.ReportData == null)
            {
                if (report.Results.STATUS_ID != "STARTCREATEDFILE" || report.Results.STATUS_ID == "DONE")
                {
                    report.SetStatus("STARTCREATEDFILE", "");
                    report.Prepared();
                    report.SaveToBase();
                }
                else
                {
                    throw new Exception("Зачекайте. Триває створення файла звіту.");
                }
            }
            // настройка контролов
            SetupControls(report);
        }
        //DisplayReport(rsp);
    }
   /* protected void btPrint_Click(object sender, EventArgs e)
    {
        switch (CbirepRepParams.FORM)
        {
            case "frm_UniReport":
                # region frm_UniReport
                switch (Report.FileTypeCode)
                {
                    case 3:
                        String js_ActiveX_print = @"
                                                    try
                                                    {
                                                        var ax = document.getElementById('BarsPrint');
                                                        ax.CallDPrint('" + GeneratedFilePath.Replace("\\", "\\\\") + @"', '');
                                                    }
                                                    catch(e)
                                                    {
                                                        alert('Не вдалося завантажити активний копонент BarsIE : ' + e.description);
                                                    }";

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "activex_print", js_ActiveX_print, true);
                        break;
                    case 6:
                    default:
                        // для остальных форматов нет печати, только выгрузка
                        break;

                }
                break;
                # endregion
            case "frm_FastReport":
                # region frm_FastReport
                // для FR нет печати, только выгрузка
                break;
                # endregion
        }

        // меняем стату на "напечатано"
        Rs rs = new Rs(new BbConnection());
        rs.SET_STATUS(QUERY_ID, "PRINTED");
    }*/
    protected void btSave_Click(object sender, EventArgs e)
    {
        GetFile("file");
    }

    public void GetFile(string contentType)
    {

        // меняем стату на "напечатано"
        Rs rs = new Rs(new BbConnection());
        rs.SET_STATUS(QUERY_ID, "PRINTED");
        using (var report = new CreateReport(QUERY_ID, OraConnector.Handler.IOraConnection.GetUserConnectionString()))
        {
            switch (report.CbirepRepParams.FORM)
            {
                case "frm_UniReport":

                    # region frm_UniReport

                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.Charset = "windows-1251";
                    if (contentType.ToLower() == "file")
                    {                    
                        Response.AppendHeader("content-disposition",String.Format("attachment;filename={0}",report.Report.FileNameFull));
                        Response.ContentType = "application/octet-stream";
                        Response.BinaryWrite(report.ReportData.ToArray());
                    }
                    else
                    {
                        Response.ContentEncoding = Encoding.GetEncoding(Response.Charset);
                        Response.AppendHeader("content-disposition", String.Format("inline;filename={0}", report.Report.FileNameFull));
                        Response.ContentType = "text/html";
                        Response.Write("<PRE>");
                        Response.BinaryWrite(report.ReportData.ToArray());
                        Response.Write("</PRE>");
                    }
                    Response.Flush();
                    Response.Close();
                    break;

                    # endregion

                case "frm_FastReport":

                    # region frm_FastReport

                    //FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(CbirepRepParams.RPT_TEMPLATE), GetParams(), this);
                    FrxDoc doc = new FrxDoc(report.ReportData, this);
                    switch (ddlFileTypes.SelectedValue)
                    {
                        case "DBF":
                            doc.Print(FrxExportTypes.Dbf);
                            break;
                        case "EXCEL":
                            doc.Print(FrxExportTypes.XmlExcel);
                            break;
                        case "TEXT":
                            doc.Print(FrxExportTypes.Text);
                            break;
                        default:
                            doc.Print(FrxExportTypes.Pdf);
                            break;
                    }
                    break;

                    # endregion
            }
        }
    }
    /*protected void btBack_Click(object sender, EventArgs e)
    {
        Object PrevUrl = ViewState["PrevUrl"];
        if (PrevUrl != null)
            Response.Redirect((String)PrevUrl);
    }*/
    # endregion

    # region Приватные методы
    private void InitSetupControls(CreateReport report)
    {
        // в зависимости от форми отчета frm_UniReport или frm_FastReport строим контролы
        switch (report.CbirepRepParams.FORM)
        {
            case "frm_UniReport":
                # region frm_UniReport
                ddlFileTypes.Visible = false;
                break;
                # endregion
            case "frm_FastReport":
                # region frm_FastReport
                ddlFileTypes.Visible = true;
                switch (report.Report.FileTypeCode)
                {
                    case 1:
                    case 2:
                    case 4:
                    case 5:
                    case 11:
                    case 12:// DBF
                        ddlFileTypes.SelectedIndex = 0;
                        break;
                    case 8:// EXCEL
                        ddlFileTypes.SelectedIndex = 1;
                        break;
                    case 9:// TEXT
                        ddlFileTypes.SelectedIndex = 2;
                        break;
                    default:// PDF
                        ddlFileTypes.SelectedIndex = 3;
                        break;
                }
                break;
                # endregion
        }
    }

    private void SetupControls(CreateReport report)
    {
        ifText.Visible = false;
        wr.Visible = false;
        btPrint.Visible = false;
        // в зависимости от форми отчета frm_UniReport или frm_FastReport строим контролы
        switch (report.CbirepRepParams.FORM)
        {
            case "frm_UniReport":

                # region frm_UniReport

                //ifText.Visible = true;
                textReportView.Visible = true;

                // настройки отображения
                switch (report.Report.FileTypeCode)
                {
                    case 3: // txt
                        btPrint.Visible = true;
                        //textReportView.InnerText = Encoding.Default.GetString(report.ReportData.ToArray());
                        textReportView.Visible = false;

                        var url = "/barsroot/cbirep/rep_print.aspx?query_id={0}&type=iframe";
                        ifText.Visible = true;
                        ifText.Attributes.Add("src", string.Format(url, QUERY_ID));
                        
                        ifText.Attributes.Add("height", "400px");
                        break;
                    default:// rtf
                        ifText.Attributes.Add("height", "0px");
                        break;
                }
                break;

                # endregion

            case "frm_FastReport":

                # region frm_FastReport

                wr.Visible = true;

                // соединение
                /*FastReport.Utils.RegisteredObjects.AddConnection(typeof(OracleDataConnection));
                frReport = new FastReport.Report();
                frReport.Load(Server.MapPath("/TEMPLATE.RPT") + "\\" + CbirepRepParams.RPT_TEMPLATE);
                //wr.Report = frReport;
                //wr.ReportFile = ;
                wr.StartReport += new EventHandler(wr_StartReport);
                wr.Prepare();*/
                report.WebPrepared(wr);
                break;

                # endregion
        }

    }

    /*private void DisplayReport(ReportSystemParams rsp)
    {
        // в зависимости от форми отчета frm_UniReport или frm_FastReport строим контролы
        switch (CbirepRepParams.FORM)
        {
            case "frm_UniReport":
                # region frm_UniReport
                // генерируем файл отчета
                /*GeneratedFilePath = rsp.GenerateReportFile();

                String showPattern = "dialog.aspx?type={0}&filename={1}&reportname={2}";

                String type = (Report.FileTypeCode == 3 ? "show_txt_file" : "show_rtf_file");
                String filename = GeneratedFilePath;
                String reportname = Report.FileNameBase;

                ifText.Attributes.Add("src", String.Format(showPattern, type, filename, reportname));

                /*if (Report.FileTypeCode == 3)
                {

                    textReportView.Visible = true;


                    String FileName = Convert.ToString(Request.Params.Get("filename"));
                    String ReportName = Convert.ToString(Request.Params.Get("reportname"));

                    if (FileName != "")
                    {
                        Response.ClearContent();
                        Response.ClearHeaders();
                        Response.Charset = "windows-1251";
                        Response.ContentEncoding = Encoding.GetEncoding(Response.Charset);
                        Response.AddHeader("Content-Disposition", String.Format("inline;filename={0}.txt", ReportName));
                        Response.ContentType = "text/html";
                        Response.Write("<PRE>");
                        Response.WriteFile(FileName, true);
                        Response.Write("</PRE>");
                    }
                }
                else
                {
                    
                }* /
                break;
                # endregion
            case "frm_FastReport":
                # region frm_FastReport
                wr.Prepare();
                break;
                # endregion
        }
    }*/
    # endregion

    /*# region Приватные события
    private void wr_StartReport(object sender, EventArgs e)
    {
        frReport.Report.Dictionary.Connections[0].ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        WebReport wrpt = (WebReport)sender;
        wrpt.Report = frReport;

        // установка параметра session_id
        frReport.Report.SetParameterValue("session_id", Results.SESSION_ID);

        // установка остальных параметров
        foreach (ReportParam p in Report.Params)
            frReport.Report.SetParameterValue(p.ID, (p.ID == "sFdat" || p.ID == "sFdat1" || p.ID == "sFdat2" ? (Object)p.DefaultValueDate : (Object)p.DefaultValueString));
    }
    private FrxParameters GetParams()
    {
        FrxParameters pars = new FrxParameters();

        // установка параметра session_id
        pars.Add(new FrxParameter("session_id", TypeCode.Decimal, Results.SESSION_ID));

        // установка остальных параметров
        foreach (ReportParam p in Report.Params)
            pars.Add(new FrxParameter(p.ID, (p.ID == "sFdat" || p.ID == "sFdat1" || p.ID == "sFdat2" ? TypeCode.DateTime : TypeCode.String), (p.ID == "sFdat" || p.ID == "sFdat1" || p.ID == "sFdat2" ? (Object)p.DefaultValueDate : (Object)p.DefaultValueString)));

        return pars;
    }
    # endregion*/
}

