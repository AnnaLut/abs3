using System;
using System.Data;
using Oracle.DataAccess.Client;
using Bars.Oracle;
using Bars.DocPrint;
using System.Text;

using System.IO;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;

/// <summary>
///Загрузочная страница.
///Полурает параметром референс документа
///Содержит в себе все закладки
/// </summary>
public partial class _default : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Считывам параметр и передаем его на закладки
        if (Request.Params.Get("ref") == null) throw new Exception(Resources.documentview.GlobalResource.labStranicaVyzvanaBezNeobhodimyhParametrov);

        if (Request.Params.Get("typePrint") != null && Request.Params.Get("typePrint").ToUpper()=="PDF")
        {
            bool prnModel = true;
            
            if (Request.Params.Get("printModel") != null)
            {
                prnModel = Convert.ToString(Request.Params.Get("printModel")[0]) == "1";
            }
	        else
	        {
	            if(Request.Cookies["prnModel"]!=null)
		            prnModel=Convert.ToString(Request.Cookies["prnModel"].Value)== "1";
	        }
            GetPdf(Request.Params.Get("ref").Split(','), prnModel);
            return;
        }

        decimal Ref = Convert.ToDecimal(Request.Params.Get("ref"));
        if (Ref < 0)
        {
            bool prnModel = true;
            if (Request.Cookies["prnModel"] != null)
                prnModel = Convert.ToString(Request.Cookies["prnModel"].Value) == "1";
            PrintTicketHtm(prnModel);
            return;
        }
        //проверка доступности документа и проверяем установлен ли SWIFT
        bool IsSwiftDoc = false;
        bool IsProfileInst;
        bool IsBuhMobShown;
        bool IsBISShown;
        bool IsEDOCSShown;

        InitOraConnection(Context);
        try
        {
            SetRole(Resources.documentview.Global.AppRole);

            ClearParameters();
            SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
            // документ не найден
            if (!Convert.ToBoolean(SQL_SELECT_scalar("SELECT count(*) FROM V_WEB_OPER WHERE REF = :pref"))) throw new Exception("Документ не доступен Вашему пользователю!");

            // --- проверки доступности закладок
            // проверка установлен ли СВИФТ
            ClearParameters();
            if (Convert.ToBoolean(SQL_SELECT_scalar("SELECT count(*) FROM PARAMS WHERE PAR = 'SWIFT' and VAL = '1'")))
            {
                ClearParameters();
                SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
                if (Convert.ToBoolean(SQL_SELECT_scalar("SELECT count(*) FROM SW_OPER WHERE REF = :pref")))
                    IsSwiftDoc = true;
            }

            // показываем или нет БухМодель
            ClearParameters();
            IsProfileInst = (Convert.ToString(SQL_SELECT_scalar("select nvl(min(to_number(val)),0) from params where par='W_PROF'")) == "1") ? (true) : (false);
            if (!IsProfileInst) IsBuhMobShown = true;
            else
            {
                string showBuhModelPar = Bars.Classes.WebUserProfiles.GetParam("SHOW_BUH_MODEL");
                IsBuhMobShown = (showBuhModelPar == "") ? (false) : (Convert.ToBoolean(showBuhModelPar));
            }

            // показывать или нет закладку БИСЫ
            ClearParameters();
            SetParameters("pref", DB_TYPE.Decimal, Ref, DIRECTION.Input);
            IsBISShown = Convert.ToBoolean(SQL_SELECT_scalar("SELECT count(*) FROM OPER WHERE REF = :pref and D_REC like '%#B%'"));

            // Показывать или нет экспортируемые проводки
            ClearParameters();
            IsEDOCSShown = Convert.ToBoolean(SQL_SELECT_scalar("SELECT count(*) FROM PARAMS WHERE PAR = 'W_SEDOCS' and VAL = '1'"));

            string tickToFile = Convert.ToString(SQL_SELECT_scalar("select nvl(min(to_number(val)),0) from params where par='W_TICFL'"));
            if (tickToFile == "2")
            {
                btFile.Attributes["onclick"] = "getTicketFile('" + Ref + "');return false";
                //bt_print.Visible = false;
            }
        }
        finally
        {
            DisposeOraConnection();
        }

        //вписываем его в заголовок
        lb_title.Text = Convert.ToString(Ref);

        string ScriptInit = @"	function InitTabs()
									{   
										var array = new Array();";
        ScriptInit += "array['" + Resources.documentview.GlobalResource.tabDocument + "']='Document.aspx?ref='+doc_ref;";
        ScriptInit += "array['" + Resources.documentview.GlobalResource.tabTechRecv + "']='TechRecv.aspx?ref='+doc_ref;";
        if (IsBuhMobShown)
            ScriptInit += "array['" + Resources.documentview.GlobalResource.tabBuhModel + "']='BuhModel.aspx?ref='+doc_ref;";
        ScriptInit += "array['" + Resources.documentview.GlobalResource.tabDopRekv + "']='DopRekv.aspx?ref='+doc_ref;";
        ScriptInit += "array['" + Resources.documentview.GlobalResource.tabVisa + "']='Visa.aspx?ref='+doc_ref;";
        if (IsSwiftDoc)
            ScriptInit += "array['" + Resources.documentview.GlobalResource.tabSwift + "']='Swift.aspx?ref='+doc_ref;";
        if (IsBISShown)
            ScriptInit += "array['" + Resources.documentview.GlobalResource.tabBIS + "']='BIS.aspx?ref='+doc_ref;";
        if (IsEDOCSShown)
            ScriptInit += "array['" + Resources.documentview.GlobalResource.tabEDOCS + "']='EDocs.aspx?ref='+doc_ref;";

        ScriptInit += @"fnInitTab('webtab',array,440,'onChangeTab');
									}";

        Bars.Configuration.ModuleSettings ms = new Bars.Configuration.ModuleSettings();
        // Новая колонка в табличке VOB
        string colFRTempate = string.Empty;
        btPdfFile.Visible = false;
        if (ms.Documents.EnhancePrint)
        {
            string pdfFileName = DocInput.DocService.GetPdfFileName(Convert.ToDecimal(Request.Params.Get("ref")));
            if (pdfFileName == null || pdfFileName == "")
            {
                btPdfFile.Visible = false;
            }
            else 
            {
                btPdfFile.Visible = true;
            }
        }
        this.RegisterStartupScript("InitRefVar", "<script language=javascript>" + ScriptInit + "  doc_ref = " + Convert.ToString(Ref) + "</script>");
    }
    protected void bt_print_Click(object sender, EventArgs e)
    {
        Response.Redirect("/barsroot/documentview/default.aspx?ref=-" + Request.Params.Get("ref"));
    }
    private void PrintTicketHtm(bool printTrnModel)
    {

        IOraConnection icon = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
        OracleConnection con = icon.GetUserConnection(Context);

        cDocPrint ourTick = new cDocPrint(con,
            (-1) * long.Parse(Request.Params.Get("ref")), Server.MapPath("/TEMPLATE.RPT/"), printTrnModel);

        try
        {
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "windows-1251";
            Response.ContentEncoding = Encoding.GetEncoding("windows-1251");
            Response.ContentType = "text/html";

            Response.AppendHeader("content-disposition", "inline;filename=ticket_" + Request.Params.Get("ref") + ".htm");
            Response.Write("<STYLE>@media Screen{.print_action{DISPLAY: none}} @media Print{.screen_action {DISPLAY: none}}</STYLE>");
            Response.Write("<DIV align=center class=screen_action>");
            Response.Write("<INPUT id=btPrint type=\"button\" value=\"" + Resources.documentview.GlobalResource.printBtn + "\" style=\"FONT-SIZE:14px;WIDTH:100px;font-weight:bold\" onclick=\"window.print()\"><BR>");
            Response.Write("</DIV>");
            Response.Write("<PRE style=\"MARGIN-LEFT: 20pt; FONT-SIZE: 8pt; COLOR: black; FONT-FAMILY: 'Courier New'; WIDTH: 300pt; BACKGROUND-COLOR: gainsboro\">");
            Response.WriteFile(ourTick.GetTicketFileName(), true);
            Response.Write("</PRE>");

            Response.Flush();
            Response.End();
        }
        finally
        {
            ourTick.DeleteTempFiles();
        }
    }
    protected void btFile_Click(object sender, System.EventArgs e)
    {
        IOraConnection icon = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
        OracleConnection con = icon.GetUserConnection(Context);

        try
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = icon.GetSetRoleCommand(Resources.documentview.Global.AppRole);
            cmd.ExecuteNonQuery();

            cmd.CommandText = "select nvl(min(to_number(val)),0) from params where par='W_TICFL'";
            string tickToFile = Convert.ToString(cmd.ExecuteScalar());

            cDocPrint ourTick = new cDocPrint(con,
                long.Parse(Request.Params.Get("ref")), Server.MapPath("/TEMPLATE.RPT/"), cbPrintTrnModel.Checked);

            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "windows-1251";
            Response.ContentEncoding = Encoding.GetEncoding("windows-1251");
            if (tickToFile == "2")
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "printAX", "<script>printTicket('" + ourTick.GetTicketFileName().Replace("\\", "\\\\") + "');</script>");

                //Response.Write("<script>window.open('/barsroot/webservices/printnosave.aspx?filename=" + ourTick.GetTicketFileName().Replace("\\","\\\\") + "','','height=40px,width=350px,status=no,toolbar=no,menubar=no,location=no,left=0,top=0');</script>");
                return;
                //Response.AppendHeader("content-disposition", "attachment;filename=ticket.barsprn");
                //Response.ContentType = "application/octet-stream";
            }
            else
            {
                Response.AppendHeader("content-disposition", "attachment;filename=ticket_" + Request.Params.Get("ref") + ".txt");
                Response.ContentType = "text/html";
            }

            Response.WriteFile(ourTick.GetTicketFileName(), true);
            Response.Flush();
            Response.End();
            ourTick.DeleteTempFiles();
        }
        finally
        {
            if (ConnectionState.Open == con.State) con.Close();
            con.Dispose();
        }
    }
    protected void btTextFile_Click(object sender, EventArgs e)
    {
        //Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        IOraConnection icon = (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

        try
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = icon.GetSetRoleCommand(Resources.documentview.Global.AppRole);
            cmd.ExecuteNonQuery();

            cDocPrint ourTick = new cDocPrint(con,
                long.Parse(Request.Params.Get("ref")), Server.MapPath("/TEMPLATE.RPT/"), cbPrintTrnModel.Checked);

            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "windows-1251";
            Response.ContentEncoding = Encoding.GetEncoding("windows-1251");
            Response.AppendHeader("content-disposition", "attachment;filename=ticket_" + Request.Params.Get("ref") + ".txt");
            Response.ContentType = "text/html";

            Response.WriteFile(ourTick.GetTicketFileName(), true);
            Response.Flush();
            Response.End();
            ourTick.DeleteTempFiles();
        }
        finally
        {
            if (ConnectionState.Open == con.State) con.Close();
            con.Dispose();
        }
    }
    protected void btPdfFile_Click(object sender, EventArgs e)
    {
        bool prnModel = true;
        if (Request.Cookies["prnModel"] != null)
            prnModel = Convert.ToString(Request.Cookies["prnModel"].Value)=="1";
        GetPdf(Request.Params.Get("ref").Split(','), prnModel);
    }

    private void GetPdf(string[] referens, bool prnModel)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        try
        {
            PdfDocument outputDocument = new PdfDocument();
            foreach (var item in referens)
            {
                FrxParameters pars = new FrxParameters();
                pars.Add(new FrxParameter("p_ref_c", TypeCode.Decimal, item));
                pars.Add(new FrxParameter("p_buh_c", TypeCode.Int16, prnModel ? 1 : 0));
                FrxDoc doc = new FrxDoc(
                    FrxDoc.GetTemplatePathByFileName(DocInput.DocService.GetPdfFileName(Convert.ToDecimal(item))),
                    pars,
                    Page);
                using (var str = new MemoryStream())
                {
                    doc.ExportToMemoryStream(FrxExportTypes.Pdf, str);
                    PdfDocument inputDocument = PdfReader.Open(str, PdfDocumentOpenMode.Import);
                    // Iterate pages
                    int count = inputDocument.PageCount;
                    for (int idx = 0; idx < count; idx++)
                    {
                        // Get the page from the external document...
                        PdfPage page = inputDocument.Pages[idx];
                        // ...and add it to the output document.
                        outputDocument.AddPage(page);
                    }
                }
            }
            var stream = new MemoryStream();
            outputDocument.Save(stream,true);
            stream.Flush();
            stream.Close();

            Response.ClearContent();
            Response.ClearHeaders();
            Response.AppendHeader("content-disposition", "attachment;filename=" + (referens.Length == 1 ? "ticket_" + referens[0] : "tickets") + ".pdf");
            Response.ContentType = "application/pdf";
            Response.BinaryWrite(stream.ToArray());
            Response.Flush();
            Response.End();
        }
        finally
        {
            if (ConnectionState.Open == con.State) con.Close();
            con.Dispose();
        }
    }
}
