using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;
using System.Resources;
using System.Reflection;
using System.Globalization;
using System.Threading;
using Bars.Configuration;
using Bars.Classes;

namespace Bars.Web.Dialog
{
    public class Dialogs : IHttpHandler, IRequiresSessionState
    {
        public const string COOKIES_NAME = "LanguagePref";
        // Культура по умолчанию
        string ui_culture = "ru";

        bool IHttpHandler.IsReusable
        {
            get { return true; }
        }
        void IHttpHandler.ProcessRequest(HttpContext context)
        {
            HttpRequest Request = context.Request;
            HttpResponse Response = context.Response;
            // прочитаем культуру
            if (ConfigurationSettings.AppSettings.Get("Localization.Mode") == "Off")
            {
                // Берем культуру из Bars.config
                ui_culture = ConfigurationSettings.AppSettings.Get("Localization.UICulture");
            }
            else
            {
                // Если пользователя нет в БД
                if (ConfigurationSettings.AppSettings.Get("allowAnonymousAuthentication") == "On")
                {
                    HttpCookie _cookie;
                    // Пытаемся прочитать язык с Cookies
                    _cookie = Request.Cookies[COOKIES_NAME];
                    ui_culture = _cookie.Value;
                    // Если нет - читаем настройки пользователя
                    if (String.Empty == ui_culture || null == ui_culture)
                    {
                        ui_culture = Request.UserLanguages[0].Substring(0, 2);
                    }
                }
                else if ("promptpsw" == Request.Params.Get("type"))
                {
                    // Берем культуру из Bars.config
                    ui_culture = ConfigurationSettings.AppSettings.Get("Localization.UICulture");
                }
                // читаем из профиля
                else
                {
                    ui_culture = WebUserProfiles.GetParam("UI_CULTURE");
                }
            }

            Response.ContentType = "text/html";
            string resp_str = "";
            string message = Request.Params.Get("message");
            var type = Request.Params.GetValues("type");
            if (type != null)
                switch (type.FirstOrDefault())
                {
                    case "0": resp_str = ShowConfirm(message); break;
                    case "1": resp_str = ShowAlert(message); break;
                    case "confirm": resp_str = ShowConfirm(message); break;
                    case "alert": resp_str = ShowAlert(message); break;
                    case "prompt": resp_str = ShowPrompt(message); break;
                    case "promptpsw": resp_str = ShowPromptPassword(message); break;
                    case "psw": resp_str = ShowInputPsw(); break;
                    case "2": resp_str = ShowDDDialog(Request.Params.Get("obj"), Request.Params.Get("name"), Request.Params.Get("method"), Request.Params.Get("param")); break;
                    case "5": resp_str = ShowDDDialogFilter(Request.Params.Get("obj"), Request.Params.Get("name"), Request.Params.Get("method"), Request.Params.Get("param")); break;
                    case "3": resp_str = ShowDicDialog(Request.Params.Get("obj"), Request.Params.Get("name"), Request.Params.Get("method"), Request.Params.Get("param1"), Request.Params.Get("param2")); break;
                    case "4": resp_str = ShowError(Request.Params.Get("message"), Request.Params.Get("source"), Request.Params.Get("trace")); break;
                    case "error": resp_str = ShowError(Request.Params.Get("message"), Request.Params.Get("source"), Request.Params.Get("trace")); break;
                    case "mnltab": resp_str = ShowManualTable(Request.Params.Get("message"), Request.Params.Get("role")); break;
                    case "mnltab_tail": resp_str = ShowManualTableMod(Request.Params.Get("message"), Request.Params.Get("tail"), Request.Params.Get("field"), Request.Params.Get("role")); break;
                    case "sp_tab": resp_str = ShowSPTable(Request.Params.Get("spid"), Request.Params.Get("nbs")); break;
                    case "metatab": resp_str = ShowMetaTable(Request.Params.Get("metatab"), Request.Params.Get("tabname"), Request.Params.Get("pk"), Request.Params.Get("sk"), Request.Params.Get("tail"), Request.Params.Get("role"), Request.Params.Get("field"), Request.Params.Get("param"), Request.Params.Get("colnum"), Request.Params.Get("title")); break;
                    case "metatab_req": resp_str = ShowMetaTableReq(Request.Params.Get("reqname"), Request.Params.Get("reqvalue"), Request.Params.Get("role")); break;
                    case "metatab_base": resp_str = ShowMetaTableBase(Request.Params.Get("dk"), Request.Params.Get("role"), Request.Params.Get("nls"), Request.Params.Get("mfo"), Request.Params.Get("kv"), Request.Params.Get("tt")); break;
                    case "showdate": resp_str = ShowDateInput(Request.Params.Get("initdate")); break;
                    case "show_txt_file":
                    {
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

                        break;
                    }
                    case "show_rtf_file":
                    {
                        String FileName = Convert.ToString(Request.Params.Get("filename"));
                        String ReportName = Convert.ToString(Request.Params.Get("reportname"));

                        if (FileName != "")
                        {
                            Response.ClearContent();
                            Response.ClearHeaders();
                            Response.Charset = "windows-1251";
                            Response.ContentEncoding = Encoding.GetEncoding(Response.Charset);
                            if (FileName.Contains(".csv"))
                            {
                                Response.AddHeader("Content-Disposition", String.Format("inline;filename={0}.csv", ReportName));
                                Response.ContentType = "application/ms-excel";
                            }
                            else
                            {
                                Response.AddHeader("Content-Disposition", String.Format("inline;filename={0}.rtf", ReportName));
                                Response.ContentType = "application/rtf";
                            }
                            Response.WriteFile(FileName, true);
                        }

                        break;
                    }
                    case "print_file":
                    {
                        string fileName = Request.Params.Get("filename");
                        if (Uri.IsWellFormedUriString(fileName, new UriKind()))
                        {
                            Response.Redirect(fileName);
                        }
                        else
                        {
                            Response.ClearContent();
                            Response.ClearHeaders();
                            Response.Charset = "windows-1251";
                            Response.AppendHeader("content-disposition", "attachment;filename=ticket.barsprn");
                            Response.ContentType = "application/octet-stream";
                            Response.WriteFile(Request.Params.Get("filename"), true);
                            Response.Flush();
                            Response.End();
                            try
                            {
                                File.Delete(fileName);
                            }
                            catch{}
                        }

                        break;
                    }
                    case "print_tic":
                    {
                        if (Request.Params.Get("barsprn") == "yes")
                        {
                            string fileName = Request.Params.Get("filename");
                            Response.ClearContent();
                            Response.ClearHeaders();
                            Response.Charset = "windows-1251";
                            Response.AppendHeader("content-disposition", "attachment;filename=ticket.barsprn");
                            Response.ContentType = "application/octet-stream";
                            Response.WriteFile(Request.Params.Get("filename"), true);
                            Response.Flush();
                            Response.End();
                            try
                            {
                                File.Delete(fileName);
                            }
                            catch { }
                        }
                        else
                        {
                            Response.Charset = "windows-1251";
                            Response.ContentEncoding = Encoding.GetEncoding("windows-1251");
                            Response.AppendHeader("content-disposition", "inline;filename=ticket.txt");
                            Response.ContentType = "text/html";
                            Response.Write(@"<script language='JavaScript' src='\Common\Script\PrintPage.js'></script>");
                            Response.Write("<STYLE>@media Screen{.print_action{DISPLAY: none}} @media Print{.screen_action {DISPLAY: none}}</STYLE>");
                            Response.Write("<DIV align=center class=screen_action>");
                            Response.Write("<div id=msg style=\"FONT-FAMILY:Verdana;FONT-SIZE:10px;COLOR:red;\"></div>");
                            Response.Write("<INPUT id=btPrint type=\"button\" value=\"" + getResource("strPrint") + "\" style=\"FONT-SIZE:14px;WIDTH:100px;COLOR:red;font-weight:bold\" onclick=\"PrintPage()\"><BR>");
                            Response.Write("<INPUT id=btSet type=\"button\" value=\"" + getResource("strOptions") + "\" style=\"FONT-SIZE:14px;WIDTH:100px;COLOR:navy;font-weight:bold\" onclick=\"SetupPage()\"><BR>");
                            Response.Write("<INPUT id=btView type=\"button\" value=\"" + getResource("strView") + "\" style=\"FONT-SIZE:14px;WIDTH:100px;COLOR:green;font-weight:bold\" onclick=\"PreviewPage()\"><BR>");
                            /// Реєстрація елемента ActiveX для друку
                            Response.Write("<OBJECT id=\"BarsPrint\" classid=\"CLSID:0E21DB0E-5A6E-435B-885B-04D3D92AA3BE\" BORDER=0 VSPACE=0 HSPACE=0 ALIGN=TOP HEIGHT=0% WIDTH=0%></OBJECT>");
                            Response.Write("</DIV>");
                            Response.Write("<PRE class=print_action style=\"MARGIN-LEFT: 20pt; FONT-SIZE: 8pt; COLOR: black; FONT-FAMILY: 'Courier New'; WIDTH: 300pt; BACKGROUND-COLOR: gainsboro\">");
                            Response.WriteFile(Request.Params.Get("filename"), true);
                            Response.Write("</PRE>");
                            try
                            {
                                File.Delete(Request.Params.Get("filename"));
                            }
                            catch { };
                        }
                        break;
                    }
                    case "print_html":
                    {
                        Response.AppendHeader("content-disposition", "inline;filename=ticket.txt");
                        Response.ContentType = "text/html";
                        Response.Write(@"<script language='JavaScript' src='\Common\Script\PrintPage.js'></script>");
                        Response.Write(@"<script language='JavaScript' src='\Common\Script\BarsIE.js'></script>");
                        Response.Write("<STYLE>@media Screen{.print_action{DISPLAY: none}} @media Print{.screen_action {DISPLAY: none}}</STYLE>");
                        Response.Write("<DIV align=center class=screen_action>");
                        Response.Write("<div id=msg style=\"FONT-FAMILY:Verdana;FONT-SIZE:10px;COLOR:red;\"></div>");
                        Response.Write("<INPUT id=btPrint type=\"button\" value=\"" + getResource("strPrint") + "\" style=\"FONT-SIZE:14px;WIDTH:100px;COLOR:red;font-weight:bold\" onclick=\"PrintPage()\"><BR>");
                        Response.Write("<INPUT id=btSet type=\"button\" value=\"" + getResource("strOptions") + "\" style=\"FONT-SIZE:14px;WIDTH:100px;COLOR:navy;font-weight:bold\" onclick=\"SetupPage()\"><BR>");
                        Response.Write("<INPUT id=btView type=\"button\" value=\"" + getResource("strView") + "\" style=\"FONT-SIZE:14px;WIDTH:100px;COLOR:green;font-weight:bold\" onclick=\"PreviewPage()\"><BR>");
                        /// Реєстрація елемента ActiveX для друку
                        //Response.Write("<OBJECT id=\"BarsPrint\" classid=\"CLSID:0E21DB0E-5A6E-435B-885B-04D3D92AA3BE\" BORDER=0 VSPACE=0 HSPACE=0 ALIGN=TOP HEIGHT=0% WIDTH=0%></OBJECT>");
                        Response.Write("</DIV>");
                        Response.Write("<DIV class=print_action>");
                        Response.WriteFile(Request.Params.Get("filename"), true);
                        Response.Write("</DIV>");
                        try { File.Delete(Request.Params.Get("filename")); }
                        catch { };
                        break;
                    }
                    case "print_url":
                    {
                        Response.ContentType = "text/html";
                        Response.Write("<html><head>");
                        Response.Write(@"<script language='javascript' type='text/jscript'>
                                        function InitObjects()
                                        {
                                            window.frames['contents'].focus();
                                            window.frames['contents'].print();

                                            window.close();
                                        }
                                    </script>");
                        Response.Write("</head><body>");
                        Response.Write("<iframe id='contents' onload='InitObjects()' class=print_action frameborder='1' style='width: 1; height: 1' src='" + Request.Params.Get("filename") + "?rnd=" + (new Random(DateTime.Now.Millisecond)).Next(0, 1000000).ToString() + "'>");
                        Response.Write("</iframe>");
                        Response.Write("</body>");
                        Response.Write("</html>");

                        break;
                    }
                    case "print_mht":
                    {
                        Response.ContentType = "text/html";
                        Response.Write("<html><head>");
                        Response.Write(@"<script language='javascript' type='text/jscript'>
                                        function InitObjects()
                                        {
                                            window.frames['contents'].focus();
                                            window.frames['contents'].print();

                                            window.close();
                                        }
                                    </script>");
                        Response.Write("</head><body>");
                        Response.Write("<iframe id='contents' onload='InitObjects()' class=print_action frameborder='1' style='width: 1; height: 1' src='dialog.aspx?type=print_mht_file&filename=" + Request.Params.Get("filename") + "&rnd=" + (new Random(DateTime.Now.Millisecond)).Next(0, 1000000).ToString() + "'>");
                        Response.Write("</iframe>");
                        Response.Write("</body>");
                        Response.Write("</html>");

                        break;
                    }
                    case "print_mht_file":
                    {
                        Response.ContentType = "message/rfc822";
                        Response.WriteFile(Request.Params.Get("filename"), true);

                        break;
                    }
                    case "err":
                    {
                        Response.ContentEncoding = Encoding.GetEncoding("utf-8");
                        Response.StatusDescription = "BRS-500";
                        ErrorPageGenerator ergen = new ErrorPageGenerator((System.Exception)HttpContext.Current.Session["AppError"]);
                        bool fullInfo = (ConfigurationSettings.GetCurrentUserInfo.errormode == "1") ? (true) : (false);
                        if (HttpContext.Current.Session != null && HttpContext.Current.Session["AppError"] != null)
                        {
                            resp_str = ergen.GetHtmlErrorPage(fullInfo);
                            //HttpContext.Current.Session.Remove("AppError");
                        }
                        else
                        {
                            string hash = HttpContext.Current.Request.UserAgent;
                            hash += HttpContext.Current.Request.UserHostAddress;
                            hash += HttpContext.Current.Request.UserHostName;
                            string key = hash.GetHashCode().ToString();
                            if (Request.Params.Get("key") != null)
                                key = HttpUtility.UrlDecode(Request.Params.Get("key"));
                            if (AppDomain.CurrentDomain.GetData(key) != null)
                            {
                                resp_str = ergen.GetHtmlErrorPage(fullInfo);
                                AppDomain.CurrentDomain.SetData(key, null);
                            }
                            else
                                //HttpContext.Current.Response.Redirect("/barsroot/barsweb/default.aspx");
                                resp_str = getResource("strNoDataFound");
                        }
                        break;
                    }
                    case "errPage":
                    {
                        Response.ContentEncoding = Encoding.GetEncoding("utf-8");
                        string key = HttpUtility.UrlDecode(Request.Params.Get("key"));
                        resp_str = (string)AppDomain.CurrentDomain.GetData(key);
                        if (resp_str == null)
                            resp_str = getResource("strNoDataFound");//"Данные об ошибке не найдены!";
                        AppDomain.CurrentDomain.SetData(key, null);
                        break;
                    }
                    case "fullADR": resp_str = ShowfullADR(Request.Params.Get("message")); break;
                    case "passplist": resp_str = Showpasplist(); break;
                    case "BarsPayments":
                    {
                        WebServices.BarsPayments bp = new WebServices.BarsPayments();
                        string login = Request.Params.Get("login");
                        string xmlData = Request.Params.Get("xmlData");
                        bool debug = false;
                        Boolean.TryParse(Request.Params.Get("debug"), out debug);
                        resp_str = bp.ImportXml(login, xmlData, debug).OuterXml;
                        break;
                    }
                }
            Response.Write(resp_str);
            Response.End();
        }
        private string ShowDateInput(string initdate)
        {
            return "<HTML><HEAD><TITLE>" + getResource("strDateForPrint") + "</TITLE>" +
                   "<script type=\"text/javascript\" src=\"/Common/WebEdit/RadInput.js\"></script>" +
                   "<script type=\"text/javascript\">" +
                    "function IniDateTimeControl(name) " +
                    "{" +
                    " window[name] = new RadDateInput(name, \"Windows\"); " +
                    " window[name].PromptChar=\" \"; " +
                    " window[name].DisplayPromptChar=\"_\"; " +
                    " window[name].SetMask(rdmskr(1, 31, false, true),rdmskl('/'),rdmskr(1,12, false, true),rdmskl('/'),rdmskr(1, 2999, false, true)); " +
                    " window[name].RangeValidation=true; " +
                    " window[name].SetMinDate('01/01/1980 00:00:00'); " +
                    " window[name].SetMaxDate('31/12/2099 00:00:00'); " +
                    " window[name].SetValue(document.getElementById(name+\"_TextBox\").value); " +
                    " window[name].Initialize(); " +
                    "} window.onload = Init; function Init(){IniDateTimeControl('tbDate');}</script>" +
                   "</HEAD><BODY bgColor=#f0f0f0 onkeydown='if(event.keyCode == 27){window.close();window.returnValue = null;} else if(event.keyCode == 13) document.all.btOk.fireEvent(\"onclick\");'>" +
                   "<form id='SelectDateForm'><TABLE id=\"T1\" width=\"100%\" border=\"0\"><TR><TD><TABLE id=\"T2\" width=\"100%\" border=\"0\">" +
                   "<TR style=\"height:80px\"><TD align=\"left\" style=\"font-weight:bold;COLOR:navy;FONT-FAMILY:Verdana;HEIGHT:12px\">" + getResource("strSelectDate") + "&nbsp;&nbsp;<input id='tbDate' type='hidden'><input id='tbDate_Value' type='hidden' name='tbDate'><input id='tbDate_TextBox' name='tbDate_TextBox' type=text value='" + initdate + @"' style='TEXT-ALIGN:center;WIDTH:100px;'>" +
                   "</TD></TR><TR><TD align=\"center\"><BR><INPUT id=btOk type=\"button\" value=\"" + getResource("strYes") + "\" style=\"FONT-SIZE:16px;WIDTH:100px;COLOR:green;font-weight:bold\" onclick=\"javascript:window.close();window.returnValue = document.all.tbDate_TextBox.value;\">&nbsp;&nbsp;&nbsp;" +
                   "<INPUT id=btCancel type=\"button\" value=\"" + getResource("wgFilterCancel") + "\" style=\"FONT-SIZE:16px;WIDTH:100px;COLOR:red;font-weight:bold\" onclick=\"javascript:window.close();\">" +
                   "</TD></TR></TABLE></TD></TR></TABLE></form></BODY></HTML>";
        }

        private string ShowConfirm(string message)
        {
            return "<HTML><HEAD><TITLE>" + getResource("strAttention") + "</TITLE></HEAD><BODY bgColor=#f0f0f0 onkeydown='if(event.keyCode == 27){window.close();window.returnValue = 0;} else if(event.keyCode == 37) btOk.focus(); else if(event.keyCode == 39) btCancel.focus();'>" +
                   "<TABLE id=\"T1\" width=\"100%\" border=\"0\"><TR><TD><TABLE id=\"T2\" width=\"100%\" border=\"0\">" +
                   "<TR style=\"height:80px\"><TD align=\"center\"><p style=\"FONT-WEIGHT:bold;COLOR:navy;FONT-FAMILY:Verdana;HEIGHT:20px\">" + message + "</p>" +
                   "</TD></TR><TR><TD align=\"center\"><INPUT id=btOk type=\"button\" value=\"" + getResource("strYes") + "\" style=\"FONT-SIZE:16px;WIDTH:80px;COLOR:green;font-weight:bold\" onclick=\"javascript:window.close();window.returnValue = 1;\">&nbsp;&nbsp;&nbsp;" +
                   "<INPUT id=btCancel type=\"button\" value=\"" + getResource("strNo") + "\" style=\"FONT-SIZE:16px;WIDTH:80px;COLOR:red;font-weight:bold\" onclick=\"javascript:window.close();window.returnValue = 0;\">" +
                   "</TD></TR></TABLE></TD></TR></TABLE></BODY></HTML>";
        }

        private string ShowInputPsw()
        {
            return "<HTML><HEAD><TITLE>" + getResource("strInputTehPass") + "</TITLE></HEAD><BODY bgColor=#f0f0f0 onkeydown='if(event.keyCode == 27){window.close();window.returnValue = 0;} else if(event.keyCode == 37) btOk.focus(); else if(event.keyCode == 39) btCancel.focus();'>" +
                "<TABLE id=\"T1\" width=\"100%\" border=\"0\"><TR><TD><TABLE id=\"T2\" width=\"100%\" border=\"0\">" +
                "<TR style=\"height:80px\"><TD nowrap=true align=\"center\"><span style=\"FONT-WEIGHT:bold;COLOR:navy;FONT-FAMILY:Verdana;HEIGHT:20px\">" + getResource("strPassword") + "</span><input type=password id=psw onkeydown='if(event.keyCode==13) document.all.btOk.fireEvent(\"onclick\")'>" +
                "</TD></TR><TR><TD align=\"center\"><INPUT id=btOk type=\"button\" value=\"" + getResource("strAccept") + "\" style=\"FONT-SIZE:16px;WIDTH:100px;COLOR:green;font-weight:bold\" onclick=\"var dt=new Date();var mnth = (dt.getMonth()+1).toString();str = (mnth.length>1)?(mnth):('0'+mnth)+dt.getDate().toString();if(document.all.psw.value != str){alert('Ошибка ввода технологического пароля!');document.all.psw.focus();document.all.psw.select();}else{javascript:window.close();window.returnValue = 1;}\">&nbsp;&nbsp;&nbsp;" +
                "<INPUT id=btCancel type=\"button\" value=\"" + getResource("strCancel") + "\" style=\"FONT-SIZE:16px;WIDTH:100px;COLOR:red;font-weight:bold\" onclick=\"javascript:window.close();window.returnValue = 0;\">" +
                "</TD></TR></TABLE></TD></TR></TABLE></BODY></HTML>";
        }

        private string ShowPrompt(string message)
        {
            return "<HTML><HEAD><TITLE>" + getResource("strAttention") + "</TITLE></HEAD><BODY bgColor=#f0f0f0 onkeydown='if(event.keyCode == 27){window.close();window.returnValue = null;} else if(event.keyCode == 37) btOk.focus(); else if(event.keyCode == 39) btCancel.focus();'>" +
                "<TABLE id=\"T1\" width=\"100%\" border=\"0\"><TR><TD><TABLE id=\"T2\" width=\"100%\" border=\"0\">" +
                "<TR><TD align=\"center\"><div style=\"FONT-WEIGHT:bold;COLOR:navy;FONT-FAMILY:Verdana;\">" + message + "</div>" +
                "</TD></TR><TR><TD align=\"center\"><input type=text id=txt onkeydown='if(event.keyCode==13) document.all.btOk.fireEvent(\"onclick\")' style=\"COLOR:navy;FONT-FAMILY:Verdana\"></TD></TR><TR><TD align=\"center\"><INPUT type=\"button\" id=btOk value=\"" + getResource("strYes") + "\" style=\"FONT-SIZE:16px;WIDTH:80px;COLOR:green;font-weight:bold\" onclick=\"javascript:window.close();window.returnValue = txt.value;\">&nbsp;&nbsp;&nbsp;" +
                "<INPUT id=btCancel type=\"button\" value=\"" + getResource("strNo") + "\" style=\"FONT-SIZE:16px;WIDTH:80px;COLOR:red;font-weight:bold\" onclick=\"javascript:window.close();window.returnValue = null;\">" +
                "</TD></TR></TABLE></TD></TR></TABLE></BODY></HTML>";
        }
        private string ShowPromptPassword(string message)
        {
            return "<HTML><HEAD><TITLE>" + getResource("strAttention") + "</TITLE></HEAD><BODY bgColor=#f0f0f0 onkeydown='if(event.keyCode == 27){window.close();window.returnValue = null;} else if(event.keyCode == 37) btOk.focus(); else if(event.keyCode == 39) btCancel.focus();'>" +
                "<TABLE id=\"T1\" width=\"100%\" border=\"0\"><TR><TD><TABLE id=\"T2\" width=\"100%\" border=\"0\">" +
                "<TR><TD align=\"center\"><div style=\"FONT-WEIGHT:bold;COLOR:navy;FONT-FAMILY:Verdana;\">" + message + "</div>" +
                "</TD></TR><TR><TD align=\"center\"><input type=password id=txt onkeydown='if(event.keyCode==13) document.all.btOk.fireEvent(\"onclick\")' style=\"COLOR:navy;FONT-FAMILY:Verdana\"></TD></TR><TR><TD align=\"center\"><INPUT type=\"button\" id=btOk value=\"" + getResource("strYes") + "\" style=\"FONT-SIZE:16px;WIDTH:80px;COLOR:green;font-weight:bold\" onclick=\"javascript:window.close();window.returnValue = txt.value;\">&nbsp;&nbsp;&nbsp;" +
                "<INPUT id=btCancel type=\"button\" value=\"" + getResource("strNo") + "\" style=\"FONT-SIZE:16px;WIDTH:80px;COLOR:red;font-weight:bold\" onclick=\"javascript:window.close();window.returnValue = null;\">" +
                "</TD></TR></TABLE></TD></TR></TABLE></BODY></HTML>";
        }
        private string ShowAlert(string message)
        {
            return "<HTML><HEAD><TITLE>" + getResource("strAttention") + "</TITLE></HEAD><BODY bgColor=#f0f0f0 onkeydown='if(event.keyCode == 27) window.close();'>" +
                "<TABLE id=\"T1\" width=\"100%\" border=\"0\"><TR><TD><TABLE id=\"T2\" width=\"100%\" border=\"0\">" +
                "<TR style=\"height:80px\"><TD align=\"center\"><p style=\"FONT-WEIGHT:bold;COLOR:navy;FONT-FAMILY:Verdana;HEIGHT:20px\">" + message + "</p>" +
                "</TD></TR><TR><TD align=\"center\"><INPUT type=\"button\" value=\"" + getResource("strOk") + "\" style=\"FONT-SIZE:16px;WIDTH:80px;COLOR:green;font-weight:bold\" onclick=\"javascript:window.close();\">" +
                "</TD></TR></TABLE></TD></TR></TABLE></BODY></HTML>";
        }
        private string ShowDDDialog(string s_obj, string s_name, string s_method, string param)
        {
            string data = "";
            if (param != "") data = "v_data[0]='" + param + "';";
            return @"<HTML><HEAD>
			       <title>" + getResource("strSelectPar") + @"</title>
		           <LINK href='Styles.css' type='text/css' rel='stylesheet'>
				   <LINK href='/Common/WebGrid/Grid.css' type='text/css' rel='stylesheet'>		
				   <script language='javascript' src='/Common/Script/Localization.js'></script>				   
				   <script language='JavaScript' src='\Common\WebGrid\Grid2005.js?v1.0'></script>
				   <script language='JavaScript'>
			    	   v_Obj_Xslt.load('Xslt/DDList.xsl');
					   var obj = new Object();
                       obj.v_serviceObjName = '" + s_obj + @"';
				       obj.v_serviceName = '" + s_name + @"';
				       obj.v_serviceMethod = '" + s_method + @"';
					   obj.pageSize = 20;" + data + @"
				       fn_InitVariables(obj);
				       window.onload = InitGrid;
				   </script>	
				   </HEAD>
				   <body bgColor=#f0f0f0 topMargin=5>
				   <div class=webservice id=webService showProgress=true></div>
					" + stringForWebGrid() + @"
			       </body></HTML>";
        }
        private string ShowDDDialogFilter(string s_obj, string s_name, string s_method, string param)
        {
            string data = "";
            if (param != "") data = "v_data[0]='" + param + "';";
            return @"<HTML><HEAD>
			       <title>" + getResource("strSelectPar") + @"</title>
		           <LINK href='Styles.css' type='text/css' rel='stylesheet'>
				   <LINK href='/Common/WebGrid/Grid.css' type='text/css' rel='stylesheet'>
				   <script language='javascript' src='/Common/Script/Localization.js'></script>		 
				   <script language='JavaScript' src='\Common\WebGrid\Grid2005.js?v1.0'></script>
				   <script language='JavaScript'>
			    	   v_Obj_Xslt.load('Xslt/DDList.xsl');
					   var obj = new Object();
                       obj.v_serviceObjName = '" + s_obj + @"';
				       obj.v_serviceName = '" + s_name + @"';
				       obj.v_serviceMethod = '" + s_method + @"';
					   obj.pageSize = 20;" + data + @"
				       fn_InitVariables(obj);
				       window.onload = InitGrid;
				   </script>	
				   </HEAD>
				   <body bgColor=#f0f0f0 topMargin=5>
				   <div align=center>
				   <select name='ddOp' id='ddOp' style='width:100px;'>
					<option value='='>=</option><option value='!1'>&lt;</option>
					<option value='!2'>&lt;=</option><option value='>'>&gt;</option>
					<option value='>='>&gt;=</option><option value='<>'>&lt;&gt;</option>
					<option value='LIKE'>" + getResource("strLike") + @"</option><option value='LIKE NOT'>" + getResource("strNotLike") + @"</option>
					<option value='IS NULL'>" + getResource("strNull") + @"</option><option value='IS NOT NULL'>" + getResource("strNotNull") + @"</option>
					</select><input name='tbVal' type='text' id='tbVal'><input type=button value='" + getResource("strFilter") + @"' onclick='Find()'><input type=button value='" + getResource("strCancel") + @"' onclick='RefreshGrid()'>
					</div>
				   <div class=webservice id=webService showProgress=true></div>
					" + stringForWebGrid() + @"
			       </body></HTML>";
        }

        private string ShowDicDialog(string s_obj, string s_name, string s_method, string param1, string param2)
        {
            string data = "";
            if (param1 != "") data = "v_data[0]='" + param1 + "';";
            if (param2 != "") data += "v_data[1]='" + param2 + "';";
            return @"<HTML><HEAD>
			       <title>" + getResource("strSelectPar") + @"</title>
		           <LINK href='Styles.css' type='text/css' rel='stylesheet'>
				   <LINK href='/Common/WebGrid/Grid.css' type='text/css' rel='stylesheet'>
				   <script language='javascript' src='/Common/Script/Localization.js'></script>	
				   <script language='JavaScript' src='\Common\WebGrid\Grid2005.js?v1.0'></script>
				   <script language='JavaScript'>
			    	   v_Obj_Xslt.load('Xslt/Dic.xsl');
					   var obj = new Object();
                       obj.v_serviceObjName = '" + s_obj + @"';
				       obj.v_serviceName = '" + s_name + @"';
				       obj.v_serviceMethod = '" + s_method + @"';
					   obj.pageSize = 20;" + data + @"
				       fn_InitVariables(obj);
				       window.onload = InitGrid;
				   </script>	
				   </HEAD>
				   <body bgColor=#f0f0f0 topMargin=5>
				   <div class=webservice id=webService showProgress=true></div>
					" + stringForWebGrid() + @"
			       </body></HTML>";
        }
        private string ShowError(string message, string source, string trace)
        {
            return "<HTML><HEAD><TITLE>" + getResource("strError") + "</TITLE></HEAD><BODY bgColor=#f0f0f0>" +
                    "<TABLE width='100%'><TR align='center'><TD><STRONG><FONT size='5'>" + getResource("strErrorOnPage") + "</FONT></STRONG></TD>" +
                    "<TABLE width='100%' border='1'>" +
                    "<TR><TD height='24'><FONT color='navy' size='4'>" + message + "</FONT></TD></TR>" +
                    "<TR><TD><FONT color='navy' size='4'>" + source + "</FONT></TD></TR>" +
                    "<TR><TD><FONT color='navy' size='4'>" + trace + "</FONT></TD></TR></TABLE><BR>" +
                    "<DIV align='center'><STRONG><FONT color='maroon' size='5'> <a href=# onclick='document.close();window.close();'>" + getResource("strCloseWindow") + "</a></FONT></STRONG></DIV>" +
                    "</TD></TR></TABLE></BODY></HTML>";
        }
        private string ShowManualTable(string TabName, string Role)
        {
            return @"<HTML><HEAD>
			       <title>" + getResource("strRefer") + @"</title>
		           <LINK href='/Common/ManualTable/ManualTableCss.css' type='text/css' rel='stylesheet'>
				   <LINK href='/Common/WebGrid/Grid.css' type='text/css' rel='stylesheet'>	
				   <script language='javascript' src='/Common/Script/Localization.js'></script>
				   <script language='JavaScript' src='/Common/WebGrid/Grid2005.js?v1.0'></script>
				   <script language='javascript' src='/Common/ManualTable/ManualTableScript2005.js'></script>
				   <script language='JavaScript'>
				       window.onload = InitManualTable;
					   v_data[11] =  '" + TabName + @"';
					   v_data[12] =  '" + Role + @"';	
					   function ReturnResult(code,value)
					   {
							var array = new Array();
							array[0] = code;array[1] = value;
							window.returnValue = array;
							window.close();
					   }
				   document.onkeydown = function(){if(event.keyCode==27) window.close();}	
				   </script>	
				   </HEAD>
				   <body bgColor=#f0f0f0>
					<table height='400px' width='100%'>
						<tr>
							<td align='center' valign='middle' style='PADDING-LEFT: 20px; PADDING-TOP: 5px; BORDER-BOTTOM: #000000 2px solid; HEIGHT: 40px'>
							<input type=button value='" + getResource("strFilter") + @"' onclick='ShowFilter()'>
							</td>
						</tr>
						<tr>
							<td align='center' valign='top'>
							<div class=webservice id=webService showProgress=true></div>
							</td>
						</tr>
					</table>
					" + stringForWebGrid() + @"
				   </body></HTML>";
        }
        private string ShowSPTable(string spid, string nbs)
        {
            return @"<HTML><HEAD>
			       <title>" + getResource("strRefer") + @"</title>
		           <LINK href='/Common/ManualTable/ManualTableCss.css' type='text/css' rel='stylesheet'>
				   <LINK href='/Common/WebGrid/Grid.css' type='text/css' rel='stylesheet'>
				   <script language='javascript' src='/Common/Script/Localization.js'></script>	
				   <script language='JavaScript' src='/Common/WebGrid/Grid2005.js?v1.0'></script>
				   <script language='JavaScript'>
				       v_data[9] =  '" + spid + @"';
					   v_data[10] =  '" + nbs + @"';
					   v_Obj_Xslt.load('/Common/ManualTable/ManualTableXsl.xsl');
					   var obj = new Object();
                       obj.v_serviceObjName = 'webService';
				       obj.v_serviceName = 'AccService.asmx';
				       obj.v_serviceMethod = 'GetSPTable';
					   fn_InitVariables(obj);
				       window.onload = InitGrid;	
					   function ReturnResult(code,value)
					   {
							var array = new Array();
							array[0] = code;array[1] = value;
							window.returnValue = array;
							window.close();
					   }
					   document.onkeydown = function(){if(event.keyCode==27) window.close();}				
				   </script>	
				   </HEAD>
				   <body bgColor=#f0f0f0>
					<table height='400px' width='100%'>
						<tr>
							<td align='center' valign='top'>
							<div class=webservice id=webService showProgress=true></div>
							</td>
						</tr>
					</table>
					" + stringForWebGrid() + @"
				   </body></HTML>";
        }

        private string ShowManualTableMod(string TabName, string SqlTail, string Field, string Role)
        {
            return @"<HTML><HEAD>
			       <title>" + getResource("strRefer") + @"</title>
		           <LINK href='/Common/ManualTable/ManualTableCss.css' type='text/css' rel='stylesheet'>
				   <LINK href='/Common/WebGrid/Grid.css' type='text/css' rel='stylesheet'>
				   <script language='javascript' src='/Common/Script/Localization.js'></script>	
				   <script language='JavaScript' src='/Common/WebGrid/Grid2005.js?v1.0'></script>
				   <script language='javascript' src='/Common/ManualTable/ManualTableScript2005.js'></script>
				   <script language='JavaScript'>
				       window.onload = InitManualTable;
					   v_data[12] =  '" + Role + @"';		
					   v_data[11] =  '" + TabName + @"';
					   v_data[10] = '" + Field + @"';	
					   v_data[9] = " + SqlTail + @";	
					   function ReturnResult(val1,val2,val3,val4,val5)
					   {
							var array = new Array();
							array[0] = val1;array[1] = val2;array[2] = val3;array[3] = val4;array[4] = val5;
							window.returnValue = array;
							window.close();
					   }	
					  document.onkeydown = function(){if(event.keyCode==27) window.close();}	
				   </script>	
				   </HEAD>
				   <body bgColor=#f0f0f0>
					<table height='400px' width='100%'>
						<tr>
							<td align='center' valign='middle' style='PADDING-LEFT: 20px; PADDING-TOP: 5px; BORDER-BOTTOM: #000000 2px solid; HEIGHT: 40px'>
							<input type=button value='" + getResource("strFilter") + @"' onclick='ShowFilter()'>
							</td>
						</tr>
						<tr>
							<td align='center' valign='top'>
							<div class=webservice id=webService showProgress=true></div>
							</td>
						</tr>
					</table>
					" + stringForWebGrid() + @"
				   </body></HTML>";
        }
        private string ShowMetaTable(string MetaTab, string TabName, string PKField, string SKField, string SqlTail, string Role, string Field, string Param, string colNum, string Title)
        {
            string title = (Title != string.Empty) ? ("<div align='center' style='FONT-WEIGHT:bold;COLOR:navy;FONT-FAMILY:Verdana;'>" + Title + @"</div>") : ("");
            return @"<HTML><HEAD>
			       <title>" + getResource("strRefer") + @"</title>
		           <LINK href='/Common/ManualTable/ManualTableCss.css' type='text/css' rel='stylesheet'>
				   <LINK href='/Common/WebGrid/Grid.css' type='text/css' rel='stylesheet'>
				   <script language='javascript' src='/Common/Script/Localization.js'></script>	
				   <script language='JavaScript' src='/Common/WebGrid/Grid2005.js?v1.0'></script>
				   <script language='javascript' src='/Common/ManualTable/ManualTableScript2005.js'></script>
				   <script language='JavaScript'>
				       window.onload = InitMetaTable;
                       v_data[17] = '" + MetaTab + @"';	
					   v_data[16] = '" + colNum + @"';	
					   v_data[15] = '" + Param + @"';	
					   v_data[14] = '" + Field + @"';	
					   v_data[13] =  '" + Role + @"';		
					   v_data[12] =  " + SqlTail + @";		
					   v_data[11] =  '" + SKField + @"';
					   v_data[10] = '" + PKField + @"';	
					   v_data[9] = '" + TabName + @"';	
					   function ReturnResult(val1,val2,val3,val4,val5)
					   {
							var array = new Array();
							array[0] = val1;array[1] = val2;array[2] = val3;array[3] = val4;array[4] = val5;
							window.returnValue = array;
							window.close();
					   }	
					   document.onkeydown = function(){if(event.keyCode==27) window.close();}		
				   </script>	
				   </HEAD>
				   <body bgColor=#f0f0f0>" + title + @"
				   <table height='400px' width='100%'>
						<tr>
							<td align='center' valign='middle' style='PADDING-LEFT: 20px; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1px solid; HEIGHT: 30px'>
							<input type=button value='" + getResource("strFilter") + @"' onclick='ShowFilter()'>
							<INPUT type=button value='" + getResource("strCancel") + @"' style='COLOR:red' onclick='javascript:window.close();window.returnValue = null;'>
							</td>
						</tr>
						<tr>
							<td align='center' valign='top'>
							<div class=webservice id=webService showProgress=true></div>
							</td>
						</tr>
					</table>
					" + stringForWebGrid() + @"
				   </body></HTML>";
        }

        private string ShowMetaTableReq(string reqName, string reqValue, string Role)
        {
            return @"<HTML><HEAD>
			       <title>" + getResource("strRefer") + @"</title>
		           <LINK href='/Common/ManualTable/ManualTableCss.css' type='text/css' rel='stylesheet'>
				   <LINK href='/Common/WebGrid/Grid.css' type='text/css' rel='stylesheet'>
				   <script language='javascript' src='/Common/Script/Localization.js'></script>	
				   <script language='JavaScript' src='/Common/WebGrid/Grid2005.js?v1.0'></script>
				   <script language='javascript' src='/Common/ManualTable/ManualTableScript2005.js'></script>
				   <script language='JavaScript'>
				       window.onload = InitMetaTable_Req;
                       v_data[11] = unescape('" + reqValue + @"');
					   v_data[10] = '" + Role + @"';	
					   v_data[9] = '" + reqName + @"';	
					   function ReturnResult(val1,val2,val3,val4,val5)
					   {
							var array = new Array();
							array[0] = val1;array[1] = val2;array[2] = val3;array[3] = val4;array[4] = val5;
							window.returnValue = array;
							window.close();
					   }
					   document.onkeydown = function(){if(event.keyCode==27) window.close();}			
				   </script>	
				   </HEAD>
				   <body bgColor=#f0f0f0>
					<table height='400px' width='100%'>
						<tr>
							<td align='center' valign='middle' style='PADDING-LEFT: 20px; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1px solid; HEIGHT: 30px'>
                            <input type=button value='" + getResource("strFilter") + @"' onclick='ShowFilter()'>
							<INPUT type=button value='" + getResource("strCancel") + @"' style='COLOR:red' onclick='javascript:window.close();window.returnValue = null;'>
							</td>
						</tr>
						<tr>
							<td align='center' valign='top'>
							<div class=webservice id=webService showProgress=true></div>
							</td>
						</tr>
					</table>
					" + stringForWebGrid() + @"
				   </body></HTML>";
        }
        private string ShowMetaTableBase(string type, string Role, string nls, string mfo, string kv, string tt)
        {
            return @"<HTML><HEAD>
			       <title>" + getResource("strRefer") + @"</title>
		           <LINK href='/Common/ManualTable/ManualTableCss.css' type='text/css' rel='stylesheet'>
				   <LINK href='/Common/WebGrid/Grid.css' type='text/css' rel='stylesheet'>
				   <script language='javascript' src='/Common/Script/Localization.js'></script>	
				   <script language='JavaScript' src='/Common/WebGrid/Grid2005.js?v1.0'></script>
				   <script language='javascript' src='/Common/ManualTable/ManualTableScript2005.js'></script>
				   <script language='JavaScript'>
				       window.onload = InitMetaTable_Base;
                       v_data[14] = '" + tt + @"';
					   v_data[13] = '" + kv + @"';
					   v_data[12] = '" + mfo + @"';
					   v_data[11] = '" + nls + @"';
					   v_data[10] = '" + Role + @"';	
					   v_data[9] = '" + type + @"';	
					   function ReturnResult(val1,val2,val3,val4,val5)
					   {
							var array = new Array();
							array[0] = val1;array[1] = val2;array[2] = val3;array[3] = val4;array[4] = val5;
							window.returnValue = array;
							window.close();
					   }
					   document.onkeydown = function(){if(event.keyCode==27) window.close();}
                       function find()
                       {
                         v_data[15] = document.all.tbSearch.value;
                         ReInitGrid();   
                       }
				   </script>	
				   </HEAD>
				   <body bgColor=#f0f0f0>
					<table height='400px' width='100%'>
						<tr>
							<td align='center' noWrap='true' style='PADDING-LEFT: 20px; PADDING-TOP: 1px; BORDER-BOTTOM: #000000 1px solid; HEIGHT: 30px'>
                            <span style='FONT-WEIGHT:bold;COLOR:navy;FONT-FAMILY:Verdana;'>" + getResource("strFind") + @"</span>
							<input id='tbSearch' type=text style='width=300' onkeydown='if(event.keyCode == 13) find();' >
                            &nbsp;<input type=button value='" + getResource("strCancel") + @"' style='COLOR:red' onclick='javascript:window.close();window.returnValue = null;'>
							</td>
						</tr>
						<tr>
							<td align='center' valign='top'>
							<div class=webservice id=webService showProgress=true></div>
							</td>
						</tr>
					</table>
					" + stringForWebGrid() + @"
				   </body></HTML>";
        }

        /// <summary>
        /// Диалог для ввода полного адреса
        /// </summary>
        /// <param name="msg">Пусто или строка в виде FGIDX+";"+FGOBL+";"+FGDST+";"+FGTWN+";"+FGADR</param>
        /// <returns>Поток-диалог ввода</returns>
        private string ShowfullADR(string msg)
        {
            string ed_FGIDX;
            string ed_FGOBL;
            string ed_FGDST;
            string ed_FGTWN;
            string ed_FGADR;

            if (msg.Trim() != string.Empty)
            {
                string[] tmp = msg.Split(';');

                ed_FGIDX = tmp[0];
                ed_FGOBL = tmp[1];
                ed_FGDST = tmp[2];
                ed_FGTWN = tmp[3];
                ed_FGADR = tmp[4];
            }
            else
            {
                ed_FGIDX = "";
                ed_FGOBL = "";
                ed_FGDST = "";
                ed_FGTWN = "";
                ed_FGADR = "";
            }

            return @"<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' >
						<HTML>
							<HEAD>
								<title>" + getResource("strFullAdres") + @"</title>
								<meta content='http://schemas.microsoft.com/intellisense/ie5' name='vs_targetSchema'>
								<script language='JavaScript'>
									function trim(a)
									{
										if(a == null) return null;
										return a.replace(/^\s*|\s*$/g,'');
									}
									function isEmpty(edit)
									{
										return (edit == null || edit.value == null || trim(edit.value).length == 0)
									}
									function ReturnVal()
									{
										if(isEmpty(document.getElementById('ed_FGTWN')))
										{
											alert('" + getResource("strFillFields") + @"');
											document.getElementById('ed_FGTWN').focus();
											document.getElementById('ed_FGTWN').select();
										}
										else if(isEmpty(document.getElementById('ed_FGADR')))
										{
											alert('" + getResource("strFillFields") + @"');
											document.getElementById('ed_FGADR').focus();
											document.getElementById('ed_FGADR').select();
										}
										else
										{
											var tmp = ed_FGIDX.value +';'+ ed_FGOBL.value +';'+ ed_FGDST.value +';'+ ed_FGTWN.value +';'+ ed_FGADR.value;
											window.returnValue = tmp;
											window.close();
										}
									}	
									function ReturnValKey(evt)
									{
										if(evt.keyCode == '13')
											ReturnVal();
									}
								</script>
							</HEAD>
							<body bgColor='#f0f0f0'>
								<table width='100%' cellpadding='1' cellspacing='0' style='FONT-SIZE: 10pt; BORDER-BOTTOM: black 2px solid; FONT-FAMILY: Arial'>
									<tr>
										<td align='right' width='50%'>" + getResource("strIndex") + @"</td>
										<td align='left'><input type='text' id='ed_FGIDX' value='" + ed_FGIDX + @"' style='WIDTH:150px' maxLength='20' onkeypress='ReturnValKey(event)'></td>
									</tr>
									<tr>
										<td align='right'>" + getResource("strRegion") + @"</td>
										<td align='left'><input type='text' id='ed_FGOBL' value='" + ed_FGOBL + @"' style='WIDTH:400px' maxLength='30' onkeypress='ReturnValKey(event)'></td>
									</tr>
									<tr>
										<td align='right'>" + getResource("strDistrict") + @"</td>
										<td align='left'><input type='text' id='ed_FGDST' value='" + ed_FGDST + @"' style='WIDTH:400px' maxLength='30' onkeypress='ReturnValKey(event)'></td>
									</tr>
									<tr>
										<td align='right'>" + getResource("strCity") + @"</td>
										<td align='left'><input type='text' id='ed_FGTWN' value='" + ed_FGTWN + @"' style='WIDTH:400px' maxLength='30' onkeypress='ReturnValKey(event)'></td>
									</tr>
									<tr>
										<td align='right'>" + getResource("strStreet") + @"</td>
										<td align='left'><input type='text' id='ed_FGADR' value='" + ed_FGADR + @"' style='WIDTH:400px' maxLength='30' onkeypress='ReturnValKey(event)'></td>
									</tr>
								</table>
								<table width='100%' cellpadding='1'>
									<tr>
										<td align='center'><input type='button' value='" + getResource("strOk") + @"' onkeypress='ReturnValKey(event)' style='FONT-WEIGHT: bold; FONT-SIZE: 10pt; WIDTH: 75px; COLOR: darkgreen; FONT-FAMILY: Arial' onclick='ReturnVal()'></td>
									</tr>
								</table>
							</body>
						</HTML>";
        }
        private string Showpasplist()
        {

            return @"<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN' >
						<HTML>
							<HEAD>
								<title>" + getResource("strDoc") + @"</title>
								<meta content='http://schemas.microsoft.com/intellisense/ie5' name='vs_targetSchema'>
								<script language='JavaScript'>
									function ReturnVal(edit)
									{
										window.returnValue = edit.innerText;
										window.close();
									}	
								</script>
							</HEAD>
							<body bgColor='lemonchiffon'>
								<table width='100%' cellpadding='1' cellspacing='0' style='FONT-SIZE: 10pt; BORDER-BOTTOM: #000000 1px solid; FONT-FAMILY: Arial'>
									<tr>
										<td align='center' style='BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid'><a id='a_1' href='#' onclick='ReturnVal(a_1)'>Інший</a></td>
									</tr>
								</table>
							</body>
						</HTML>";
        }

        private string getResource(string key)
        {
            ResourceManager rm = Resources.Bars.Web.Dialog.Localization.ResourceManager;
            return rm.GetString(key + "_" + ui_culture);
        }

        private string stringForWebGrid()
        {
            return @"<input runat='server' type='hidden' id='currentPageCulture' value='" + getResource("currentPageCulture") + @"' />
					 <input runat='server' type='hidden' id='wgPageSizeText' value='" + getResource("wgPageSizeText") + @"' />
					 <input runat='server' type='hidden' id='wgPrevPage' value='" + getResource("wgPrevPage") + @"' />
					 <input runat='server' type='hidden' id='wgNextPage' value='" + getResource("wgNextPage") + @"' />
					 <input runat='server' type='hidden' id='wgRowsInTable' value='" + getResource("wgRowsInTable") + @"'/>
					 <input runat='server' type='hidden' id='wgAscending' value='" + getResource("wgAscending") + @"' />
					 <input runat='server' type='hidden' id='wgDescending' value='" + getResource("wgDescending") + @"' />
					 <input runat='server' type='hidden' id='wgSave' value='" + getResource("wgSave") + @"' />
					 <input runat='server' type='hidden' id='wgCancel' value='" + getResource("wgCancel") + @"' />
					 <input runat='server' type='hidden' id='wgSetFilter' value='" + getResource("wgSetFilter") + @"' />
					 <input runat='server' type='hidden' id='wgFilter' value='" + getResource("wgFilter") + @"' />
					 <input runat='server' type='hidden' id='wgAttribute' value='" + getResource("wgAttribute") + @"' />
					 <input runat='server' type='hidden' id='wgOperator' value='" + getResource("wgOperator") + @"' />
					 <input runat='server' type='hidden' id='wgLike' value='" + getResource("wgLike") + @"' />
					 <input runat='server' type='hidden' id='wgNotLike' value='" + getResource("wgNotLike") + @"' />
					 <input runat='server' type='hidden' id='wgIsNull' value='" + getResource("wgIsNull") + @"' />
					 <input runat='server' type='hidden' id='wgIsNotNull' value='" + getResource("wgIsNotNull") + @"' />
					 <input runat='server' type='hidden' id='wgOneOf' value='" + getResource("wgOneOf") + @"' />
					 <input runat='server' type='hidden' id='wgNotOneOf' value='" + getResource("wgNotOneOf") + @"' />
					 <input runat='server' type='hidden' id='wgValue' value='" + getResource("wgValue") + @"' />
					 <input runat='server' type='hidden' id='wgApply' value='" + getResource("wgApply") + @"' />
					 <input runat='server' type='hidden' id='wgFilterCancel' value='" + getResource("wgFilterCancel") + @"' />
					 <input runat='server' type='hidden' id='wgCurrentFilter' value='" + getResource("wgCurrentFilter") + @"' />
					 <input runat='server' type='hidden' id='wgDeleteRow' value='" + getResource("wgDeleteRow") + @"' />
					 <input runat='server' type='hidden' id='wgDeleteAll' value='" + getResource("wgDeleteAll") + @"' />";
        }
    }
}
