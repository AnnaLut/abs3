using System;
using System.Activities.Statements;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using Bars.Logger;
using System.Resources;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Security.Cryptography.X509Certificates;
using System.Runtime.InteropServices;
using BarsWeb.Areas.Messages.Controllers.Api;
using BarsWeb.Areas.Messages.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Messages.Infrastructure.Repository.DI.Implementation;
using BarsWeb.Areas.Doc.Infrastructure.Repository.DI.Implementation;

namespace Bars.Classes
{

    /// <summary>
    /// Статический класс для получения интерфейса IOraConnection и пользовательского соединения
    /// Вместо 	
    ///       IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
    /// нужно использовать       
    ///		  IOraConnection conn = Bars.Classes.OraConnector.Handler.IOraConnection;
    ///	или
    ///		  OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
    /// </summary>
    public class OraConnector
    {
        private static OraConnector _connector;

        private static ITalkerRepository _talkerrepo;
        public static OraConnector Handler
        {
            get
            {
                if (_connector == null)
                {
                    _connector = new OraConnector();
                    _talkerrepo = new TalkerRepository( new MessagesModel());
                }
                    return _connector;
            }
        }
        public void InitOraClass()
        {
            if (AppDomain.CurrentDomain.GetData("OracleConnectClass") == null 
                || (HttpContext.Current != null &&
                 HttpContext.Current.Application["OracleConnectClass"] == null))
            {
                AppDomain.CurrentDomain.SetData("OracleConnectClass", (IOraConnection)Activator.CreateInstance(typeof(Connection)));
                HttpContext.Current.Application["OracleConnectClass"] = AppDomain.CurrentDomain.GetData("OracleConnectClass");
            }
        }

        OraConnector()
        {
            
        }
        /// <summary>
        /// Экземпляр интерфейса IOraConnection
        /// </summary>
        public IOraConnection IOraConnection
        {
            get
            {
                InitOraClass();
                return (IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass");
            }
        }
        /// <summary>
        /// Пользовательское соединение
        /// </summary>
        public OracleConnection UserConnection
        {
            get
            {
                InitOraClass();
                return ((IOraConnection)AppDomain.CurrentDomain.GetData("OracleConnectClass")).GetUserConnection();
            }
        }

        public void CheckAccessForPage()
        {
            HttpContext context = HttpContext.Current;
            string path = context.Request.Url.AbsolutePath.ToLower();
            string query = context.Request.Url.Query.ToLower();


            if (path.IndexOf("printnosave.aspx") > 0)
                return;

            string ui_culture = System.Threading.Thread.CurrentThread.CurrentUICulture.Name.Substring(0, 2);
            ResourceManager rm = Resources.Bars.Classes.Resource.ResourceManager;

            IOraConnection conn = this.IOraConnection;
            OracleConnection con = conn.GetUserConnection();
            try
            {
                OracleCommand cmd = con.CreateCommand();

                cmd.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
                cmd.ExecuteNonQuery();

                String hostData =
                        "UserHostAddress=" + HttpContext.Current.Request.UserHostAddress + ";" +
                        "Browser=" + HttpContext.Current.Request.Browser.Browser + ";" +
                        "Version=" + HttpContext.Current.Request.Browser.Version + ";" +
                        "Type=" + HttpContext.Current.Request.Browser.Type + ";" +
                        "Platform=" + HttpContext.Current.Request.Browser.Platform + ";" +
                        "Id=" + HttpContext.Current.Request.Browser.Id + ";";

                cmd.Parameters.Clear();
                cmd.Parameters.Add("p_host_data", OracleDbType.Varchar2, hostData, ParameterDirection.Input);
                cmd.CommandText = "begin web_utl.set_host_data(:host_data); end;";
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();


                cmd.Parameters.Add("page", OracleDbType.Varchar2, path, ParameterDirection.Input);
                cmd.Parameters.Add("query", OracleDbType.Varchar2, query, ParameterDirection.Input);

                cmd.CommandText = "select web_utl.check_user_access_for_page(:page,:query) from dual";

                if (Convert.ToUInt32(cmd.ExecuteScalar()) == 0)
                    throw new ApplicationException(rm.GetString("AccessDenied_" + ui_culture) + "\n[" + context.Request.Url.PathAndQuery +"]");
                else
                    DBLogger.Debug("Web-пользователь " + context.User.Identity.Name + " получил доступ на страницу " + context.Request.Url.PathAndQuery, HttpRuntime.AppDomainAppVirtualPath);
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
            
            // !!!! Нужно для ЭБП Депозиты
            if (
                !(
                path.Contains("/barsroot/docinput/askbeforepay.aspx") || 
                path.Contains("/barsroot/deposit/") ||
                path.Contains("/barsroot/deposit/deloitte") ||
                path.Contains("/barsroot/clientproducts/") ||
                path.Contains("/barsroot/docinput/") ||
                path.Contains("/barsroot/cbirep/") ||
                path.Contains("/barsroot/credit/usercontrols/") ||
                path.Contains("/barsroot/usercontrols/")
                ) 
                && 
                context.Session["AccessRights"] != null
                )
            {
                context.Session.Remove("AccessRights");

                _talkerrepo.SetUserMessage(context.User.Identity.Name, "Роботу з клієнтом завершено!", 1);
            //    System.Web.UI.Page pg = context.Handler as System.Web.UI.Page;
            //    if (pg != null)
            //    {
            //        pg.ClientScript.RegisterStartupScript(pg.GetType(), "alert", "alert('Роботу з клієнтом завершено'); ", true);
            //    }
            //

            }
        }

        public void CheckAccessForService(string method)
        {
            HttpContext context = HttpContext.Current;
            string path = context.Request.Url.AbsolutePath;

            IOraConnection conn = this.IOraConnection;
            OracleConnection con = conn.GetUserConnection();
            try
            {
                OracleCommand cmd = con.CreateCommand();

                cmd.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
                cmd.ExecuteNonQuery();

                String hostData =
                    "UserHostAddress=" + HttpContext.Current.Request.UserHostAddress + ";" +
                    "Browser=" + HttpContext.Current.Request.Browser.Browser + ";" +
                    "Version=" + HttpContext.Current.Request.Browser.Version + ";" +
                    "Type=" + HttpContext.Current.Request.Browser.Type + ";" +
                    "Platform=" + HttpContext.Current.Request.Browser.Platform + ";" +
                    "Id=" + HttpContext.Current.Request.Browser.Id + ";";

                cmd.Parameters.Clear();
                cmd.Parameters.Add("host_data", OracleDbType.Varchar2, hostData, ParameterDirection.Input);
                cmd.CommandText = "begin web_utl.set_host_data(:host_data); end;";
                cmd.ExecuteNonQuery();

                cmd.Parameters.Clear();


                cmd.Parameters.Add("page", OracleDbType.Varchar2, path, ParameterDirection.Input);
                cmd.Parameters.Add("query", OracleDbType.Varchar2, "?" + method, ParameterDirection.Input);

                cmd.CommandText = "select web_utl.check_user_access_for_page(:page,:query) from dual";

                if (Convert.ToUInt32(cmd.ExecuteScalar()) == 0)
                    throw new ApplicationException("Нет права на использование веб-метода " + method + "! Обратитесь к администратору!");
                else
                    DBLogger.Debug("Web-пользователь " + context.User.Identity.Name + " получил доступ к методу <" + method + "> веб-сервиса " + context.Request.Url.PathAndQuery, HttpRuntime.AppDomainAppVirtualPath);
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }

    /// <summary>
    /// Класс для генерации html-страницы с информацией об ошибке 
    /// </summary>
    public class ErrorPageGenerator
    {
        private System.Exception _objErr;
        private ArrayList _exStack;
        private System.Exception _initialException;
        private OracleConnection _con;
        private OracleCommand _cmd;

        private string ErrmodCode
        {
            get
            {
                string result = null;
                if (_objErr != null)
                {
                    result = _objErr.Message.Substring(0, 3);
                }
                return result;
            }
        }

        private int ErrCode
        {
            get
            {
                int result = 0;
                if (_objErr != null)
                {
                    var strCode = _objErr.Message.Substring(4, 5);
                    int.TryParse(strCode, out result);
                }
                return result;
            }
        }

        public string Message { get; private set; }
        public NameValueCollection ErrorDetail { get; private set; }

        public ErrorPageGenerator() { }

        private void Init(System.Exception objErr)
        {
            _objErr = objErr;

            _exStack = new ArrayList();
            _initialException = null;
            for (var ex = _objErr; ex != null; ex = ex.InnerException)
            {
                _exStack.Add(ex);
                _initialException = ex;
            }
            Message = ((System.Exception)_exStack[_exStack.Count - 1]).Message;
            ErrorDetail = new NameValueCollection();

            //инициализация соединения
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            _con = conn.GetUserConnection();
            _cmd = _con.CreateCommand();
            _cmd.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
            _cmd.ExecuteNonQuery();
        }

        /// <summary>
        /// Конструктор генератора текстовых сообщений об ошибках Барса
        /// </summary>
        /// <param name="objErr">исключение, которое произошло</param>
        public ErrorPageGenerator(System.Exception objErr)
        {
            Init(objErr);
        }

        public string GetBarsErrorText()
        {
            string result = "";
            _cmd.Parameters.Clear();
            _cmd.CommandText = "select bars_error.get_error_text(:errmod_code, :err_code) from dual";
            _cmd.Parameters.Add("errmod_code", OracleDbType.Varchar2, ErrmodCode, ParameterDirection.Input);
            _cmd.Parameters.Add("err_code", OracleDbType.Int32, ErrCode, ParameterDirection.Input);
            _cmd.CommandType = CommandType.Text;
            try
            {
                result = _cmd.ExecuteScalar().ToString();
            }
            catch (System.Exception e)
            {
                result = e.Message;
            }
            return result;
        }

        public void GetBarsErrorInfo()
        {
            if (Message.IndexOf("\n") > 0)
                Message = Message.Substring(0, Message.IndexOf("\n")).Trim();
            // Читаем из БД
            _cmd.Parameters.Clear();
            _cmd.Parameters.Add("p_errtxt", OracleDbType.Varchar2, Message, ParameterDirection.Input);
            _cmd.Parameters.Add("p_errumsg", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
            _cmd.Parameters.Add("p_erracode", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
            _cmd.Parameters.Add("p_erramsg", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
            _cmd.Parameters.Add("p_errahlp", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
            _cmd.Parameters.Add("p_modcode", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
            _cmd.Parameters.Add("p_modname", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
            _cmd.Parameters.Add("p_errmsg", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
            _cmd.CommandType = CommandType.StoredProcedure;
            _cmd.CommandText = "bars_error.get_error_info";
            _cmd.ExecuteNonQuery();
            OracleString val;
            Message = ((val = (OracleString)_cmd.Parameters["p_errumsg"].Value).IsNull) ? ("") : (val.Value);

            ErrorDetail["p_errumsg"] = ((val = (OracleString)_cmd.Parameters["p_errumsg"].Value).IsNull) ? ("") : (val.Value);
            ErrorDetail["p_erracode"] = ((val = (OracleString)_cmd.Parameters["p_erracode"].Value).IsNull) ? ("") : (val.Value);
            ErrorDetail["p_erramsg"] = ((val = (OracleString)_cmd.Parameters["p_erramsg"].Value).IsNull) ? ("") : (val.Value);
            ErrorDetail["p_errahlp"] = ((val = (OracleString)_cmd.Parameters["p_errahlp"].Value).IsNull) ? ("") : (val.Value);
            ErrorDetail["p_modcode"] = ((val = (OracleString)_cmd.Parameters["p_modcode"].Value).IsNull) ? ("") : (val.Value);
            ErrorDetail["p_modname"] = ((val = (OracleString)_cmd.Parameters["p_modname"].Value).IsNull) ? ("") : (val.Value);
            ErrorDetail["p_errmsg"] = ((val = (OracleString)_cmd.Parameters["p_errmsg"].Value).IsNull) ? ("") : (val.Value);
        }

        public string GetHtmlErrorPage(System.Exception objErr, bool full)
        {
            Init(objErr);
            return GetHtmlErrorPage(full);
        }

        /// <summary>
        /// Метод для генерации страницы информации об ошибке 
        /// </summary>
        /// <param name="full">уровень детализации описания ошибки</param>
        /// <returns>html-текст страницы</returns>
        public string GetHtmlErrorPage(bool full)
        {
            //Локализация
            string ui_culture = System.Threading.Thread.CurrentThread.CurrentUICulture.Name.Substring(0, 2);
            ResourceManager rm = Resources.Bars.Classes.Resource.ResourceManager;
            
            //Признак, что описание генерируется пакетом bars_error.
            bool isBarsError = (Bars.Configuration.ConfigurationSettings.AppSettings.Get("Error.BarsPackage") == "On") ? (true) : (false);
            bool isOracleUserDefinedExeption = false;
            bool isCanOpenConnection = true;

            Regex re = new Regex(@"ORA-\d{5}");
            if (Message.StartsWith("ORA-604"))
            {
                isCanOpenConnection = false;
                Message = "Помилка доступу до бази даних. Можливо користувач заблокований.\nЗверніться до адміністратора.";
            }
            if (Message.StartsWith("ORA-20") && re.IsMatch(Message.Substring(0, 9)))
                isOracleUserDefinedExeption = true;
            if ((isBarsError || isOracleUserDefinedExeption) && isCanOpenConnection)
            {
                try
                {
                    if (isBarsError)
                    {
                        GetBarsErrorInfo();
                    }
                    else
                    {
                        Message = Message.Substring(Message.IndexOf(":") + 1).Trim();
                        if (Message.StartsWith("\\"))
                        {
                            string codeError = Message.Split(' ')[0].Replace("\\", "");
                            if (codeError.Length == 4)
                            {
                                Message = Message.Split('\n')[0];
                                string nls = string.Empty;
                                if (Message.IndexOf("#") > 0)
                                {
                                    nls = Message.Substring(Message.IndexOf("#") + 1);
                                    if (nls.IndexOf(",") > 0)
                                        nls = nls.Substring(0, nls.IndexOf(",") - 1);
                                }
                                _cmd.Parameters.Add("err", OracleDbType.Varchar2, codeError, ParameterDirection.Input);
                                _cmd.CommandText = "SELECT n_er FROM s_er where k_er = :err";
                                string ErrAbsMessage = Convert.ToString(_cmd.ExecuteScalar());
                                Message = codeError + ": " + ErrAbsMessage + " " + nls;
                            }
                        }
                    }
                }
                catch (System.Exception ex)
                {
                    _initialException = ex;
                    Message = ex.Message;
                }
                finally
                {
                    if (_con.State != ConnectionState.Closed)
                        _con.Close();
                    _con.Dispose();
                }
                /*до сюда*/
            }
            Message = Message.Replace("\n", "<br>");
            if (string.IsNullOrEmpty(Message))
                Message = _initialException.Message;
            
            int nPureMsgIndex = 0;

            StringBuilder strContent = new StringBuilder();
            strContent.Append("<html>\r\n");
            strContent.Append("    <head>\r\n");
            strContent.Append("        <title>" + Message + "</title>\r\n");
            strContent.Append("        <style>\r\n");
            strContent.Append("        \tbody {font-family:\"Verdana\";font-weight:normal;font-size: .7em;color:black;} \r\n");
            strContent.Append("        \t.tbl {font-family:\"Verdana\";font-weight:normal;font-size: 8pt;color:black;} \r\n");
            strContent.Append("        \tp {font-family:\"Verdana\";font-weight:normal;color:black;margin-top: -5px}\r\n");
            strContent.Append("        \tb {font-family:\"Verdana\";font-weight:bold;color:black;margin-top: -5px}\r\n");
            strContent.Append("        \t.h1 { font-family:\"Verdana\";font-weight:normal;font-size:18pt;color:red }\r\n");
            strContent.Append("        \t.h2 { font-family:\"Verdana\";font-weight:normal;font-size:14pt;color:maroon }\r\n");
            strContent.Append("        \t.h3 { font-family:\"Verdana\";font-weight:bold;font-size:12pt;color:black }\r\n");
            strContent.Append("        \tpre {font-family:\"Lucida Console\";font-size: .9em}\r\n");
            strContent.Append("        </style>\r\n");
            strContent.Append("    </head>\r\n\r\n");
            strContent.Append("    <body bgcolor=\"white\">\r\n");
            strContent.Append("            <div class=h1>");
            strContent.Append(rm.GetString("ErrorApp_" + ui_culture));
            strContent.Append("</div><hr width=100% size=1 color=silver>");
            strContent.Append("            <div class=h2><i>");

            strContent.Append(Message);
            nPureMsgIndex = strContent.Length;

            strContent.Append("            </i></div>\r\n");

            if (full)
            {
                strContent.Append("<hr width=100% size=1 color=silver>\n");
                strContent.Append("<script language=\"javascript\">\n");
                strContent.Append("<!--\n");
                strContent.Append("	function add_info_reactor() {\n");
                strContent.Append("		 document.all.detail.style.display = \n");
                strContent.Append("			 (document.all.detail.style.display == 'none') ? ('block'):('none');\n");
                strContent.Append("		 if(document.all.detail.style.display=='none'){\n");
                strContent.Append("		 	 document.all.asm.style.visibility='hidden';\n");
                strContent.Append("		 	 document.getElementById(\"used_asms\").innerText=\"" + rm.GetString("UsedAssembly_" + ui_culture) + "\";\n");
                strContent.Append("		 	 document.all.vars.style.visibility='hidden';\n");
                strContent.Append("		 	 document.getElementById(\"srv_vars\").innerText=\"" + rm.GetString("ServerVars_" + ui_culture) + "\";\n");
                strContent.Append("		 }\n");
                strContent.Append("		 var add_info_el = document.getElementById(\"add_info\");\n");
                strContent.Append("		 if(add_info_el.innerText==\"" + rm.GetString("ShowDetailError_" + ui_culture) + "\")\n");
                strContent.Append("		    add_info_el.innerText = \"" + rm.GetString("HideDetailError_" + ui_culture) + "\";\n");
                strContent.Append("		 else\n");
                strContent.Append("		    add_info_el.innerText = \"" + rm.GetString("ShowDetailError_" + ui_culture) + "\";\n");
                strContent.Append("	 }\n");
                strContent.Append("function used_asms_reactor() {\n");
                strContent.Append(" document.all.asm.style.visibility=(document.all.asm.style.visibility == 'visible')?('hidden'):('visible');\n");
                strContent.Append("	var used_asms_el = document.getElementById(\"used_asms\");\n");
                strContent.Append("	if(used_asms_el.innerText==\"" + rm.GetString("UsedAssembly_" + ui_culture) + "\")\n");
                strContent.Append("		used_asms_el.innerText = \"" + rm.GetString("HideAssembly_" + ui_culture) + "\";\n");
                strContent.Append("	else\n");
                strContent.Append("		used_asms_el.innerText = \"" + rm.GetString("UsedAssembly_" + ui_culture) + "\";\n");
                strContent.Append("}\n");
                strContent.Append("function srv_vars_reactor() {\n");
                strContent.Append(" document.all.vars.style.visibility=(document.all.vars.style.visibility == 'visible')?('hidden'):('visible');\n");
                strContent.Append("	var srv_vars_el = document.getElementById(\"srv_vars\");\n");
                strContent.Append("	if(srv_vars_el.innerText==\"" + rm.GetString("ServerVars_" + ui_culture) + "\")\n");
                strContent.Append("		srv_vars_el.innerText = \"" + rm.GetString("HideServerVars_" + ui_culture) + "\";\n");
                strContent.Append("	else\n");
                strContent.Append("		srv_vars_el.innerText = \"" + rm.GetString("ServerVars_" + ui_culture) + "\";\n");
                strContent.Append("}\n");
                strContent.Append("// -->\n");
                strContent.Append("</script>\n");
                strContent.Append("<b><a id=\"add_info\" href=# onclick=\"javascript:add_info_reactor();\">" + rm.GetString("ShowDetailError_" + ui_culture) + "</a></b>\n");
                //strContent.Append("<div id=detail style='visibility:hidden'>");
                strContent.Append("<div id=detail style='display:none'>");
                //Новое представление ошибки
                if (isBarsError)
                {
                    strContent.Append("            <b>" + rm.GetString("Module_" + ui_culture) + ":</b><br>");
                    strContent.Append("<input readonly type=text style='width:60px' value='" + ErrorDetail["p_modcode"] + "'>&nbsp;&nbsp;<input readonly type=text style='width:260px' value='" + ErrorDetail["p_modname"] + "'>");
                    strContent.Append("<br>\n");
                    strContent.Append("            <b>" + rm.GetString("ErrorText_" + ui_culture) + ":</b>");
                    strContent.Append("<textarea readonly style='width:100%' rows=2>" + ErrorDetail["p_erramsg"] + "</textarea>");
                    strContent.Append("<br>\n");
                    strContent.Append("            <b>" + rm.GetString("CurrAction_" + ui_culture) + ":</b>");
                    strContent.Append("<textarea readonly style='width:100%' rows=5>" + ErrorDetail["p_errahlp"] + "</textarea>");
                    strContent.Append("<br>\n");
                    strContent.Append("            <b>" + rm.GetString("Stack_" + ui_culture) + ":</b>");
                    string sourceCode = _initialException.GetType().FullName + ": " + _initialException.Message;
                    string stack = sourceCode;
                    if (sourceCode.IndexOf("\n") > 0)
                        stack = sourceCode.Substring(sourceCode.IndexOf("\n") + 1);
                    strContent.Append("<textarea readonly style='width:100%' rows=5>" + stack + "</textarea>");
                    strContent.Append("<br>\n");
                    strContent.Append("            <b>" + rm.GetString("SourceCode_" + ui_culture) + ":</b>");
                    strContent.Append("<textarea readonly style='width:100%' rows=5>" + sourceCode + "</textarea>");
                    strContent.Append("<br><br>\n");
                }

                strContent.Append("			   <b>" + rm.GetString("Page_" + ui_culture) + ": </b> " + HttpContext.Current.Session["UrlPageError"] + "\n");
                strContent.Append("<br><br>\n");
                strContent.Append("			   <b>" + rm.GetString("User_" + ui_culture) + ": </b> " + HttpContext.Current.User.Identity.Name + "&nbsp;&nbsp;(<b>IP&nbsp;:</b>&nbsp;" + HttpContext.Current.Request.UserHostAddress + ",<b>&nbsp;Host&nbsp;:</b>&nbsp;" + HttpContext.Current.Request.UserHostName + ")\n");
                strContent.Append("<br><br>\n");

                string _fileName = null;
                int _line = 0;
                if (_initialException.Message != null && !isBarsError)
                {
                    strContent.Append("            <b> " + rm.GetString("ErrorText_" + ui_culture) + ": </b>");
                    strContent.Append(_initialException.GetType().FullName + ":");
                    strContent.Append(HttpUtility.HtmlEncode(_initialException.Message).Replace("\n", "<br>"));
                    strContent.Append("\n<br><br>\n");
                }

                StringBuilder strStackTrace = new StringBuilder();
                for (int i = _exStack.Count - 1; i >= 0; i--)
                {
                    System.Exception exCur = (System.Exception)_exStack[i];
                    strStackTrace.Append("[" + _exStack[i].GetType().Name + ": " + exCur.Message + "]\r\n");
                    if (null != exCur.StackTrace)
                        strStackTrace.Append(exCur.StackTrace.Replace("\n", "<br>"));
                    strStackTrace.Append("\r\n\r\n<br><br>");
                }

                StackTrace trace = new StackTrace(_initialException, true);
                for (int i = 0; i < trace.FrameCount; i++)
                {
                    StackFrame frame = trace.GetFrame(i);
                    if (frame.GetILOffset() != -1 && frame.GetFileName() != null)
                    {
                        _line = frame.GetFileLineNumber();
                        _fileName = frame.GetFileName();
                    }
                }

                if (_fileName != null)
                {
                    StringBuilder strCode = new StringBuilder();
                    try
                    {
                        if (_fileName.StartsWith("http"))
                            _fileName = HttpContext.Current.Server.MapPath(_fileName.Substring(_fileName.IndexOf("barsroot") - 1));

                        FileInfo f = new FileInfo(_fileName);
                        if (f.Exists)
                        {
                            StreamReader reader = new StreamReader(_fileName);
                            string strLine;
                            int pos = 1;
                            while ((strLine = reader.ReadLine()) != null)
                            {
                                if (pos == _line)
                                    strCode.Append("<font color=red>");
                                if ((pos >= (_line - 2)) && (pos <= (_line + 2)))
                                {
                                    string errLine = pos.ToString("G");
                                    strCode.Append(string.Format(rm.GetString("Line_" + ui_culture) + " {0}:", errLine));
                                    if (errLine.Length < 3)
                                        strCode.Append(' ', 3 - errLine.Length);
                                    strCode.Append(HttpUtility.HtmlEncode(strLine));
                                    if (pos != (_line + 2))
                                        strCode.Append("\r\n");
                                }
                                if (pos == _line)
                                    strCode.Append("</font>");
                                if (pos <= (_line + 2))
                                    pos++;
                                else
                                    break;
                            }
                            reader.Close();
                        }
                        else
                        {
                            strCode.Append("----");
                        }
                    }
                    catch (ArgumentException)
                    {
                        strContent.Append("_fileName=" + _fileName);
                    }
                    this.WriteColoredSquare(strContent, rm.GetString("Source_" + ui_culture), null, strCode.ToString(), false);
                    strContent.Append("<b> " + rm.GetString("SourceFile_" + ui_culture) + ": </b> " + _fileName + "<b> &nbsp;&nbsp; " + rm.GetString("Line_" + ui_culture) + ":</b> " + _line + "<br><br>");
                }

                this.WriteColoredSquare(strContent, rm.GetString("FullStack_" + ui_culture), null, strStackTrace.ToString(), false);

                Assembly[] loadedAssemblies = AppDomain.CurrentDomain.GetAssemblies();
                string asms = string.Empty;
                string appName = HttpContext.Current.Request.Url.Segments[1].Replace("/", "");

                foreach (Assembly a in loadedAssemblies)
                {
                    if (a.FullName.StartsWith(appName))
                    {
                        FileInfo fapp = new FileInfo(a.Location);
                        strContent.Append("<b>" + rm.GetString("VersionApp_" + ui_culture) + ": </b> " + a.FullName + "<b>  " + rm.GetString("Date_" + ui_culture) + ": </b>" + fapp.LastWriteTime.ToString("dd.MM.yyyy HH:mm"));
                    }
                    if (a.FullName.StartsWith("Bars"))
                    {
                        FileInfo fi = new FileInfo(a.Location);
                        object[] obj = a.GetCustomAttributes(typeof(AssemblyInformationalVersionAttribute), true);
                        string InfoVersion = string.Empty;
                        if (obj.Length > 0)
                            InfoVersion = (obj[0] as AssemblyInformationalVersionAttribute).InformationalVersion;
                        if (InfoVersion == string.Empty)
                            InfoVersion = a.FullName.Split(',')[1].Split('=')[1];
                        asms += "&nbsp;&nbsp;&nbsp;<b>" + rm.GetString("Assembly_" + ui_culture) + ": </b>" + a.FullName.Split(',')[0] + "<b>  " + rm.GetString("ProductVersion_" + ui_culture) + ": </b>" + InfoVersion + "<b>  " + rm.GetString("Version_" + ui_culture) + ": </b>" + a.FullName.Split(',')[1].Split('=')[1] + "<b>  " + rm.GetString("Date_" + ui_culture) + ": </b>" + fi.LastWriteTime.ToString("dd.MM.yyyy HH:mm") + "<br>\n";
                    }
                }

                StringBuilder srv_vars = new StringBuilder();
                foreach (string key in HttpContext.Current.Request.ServerVariables)
                {
                    string val = HttpContext.Current.Request.ServerVariables[key];
                    if (val != "" && key != "__VIEWSTATE" && key != "ALL_HTTP" && key != "ALL_RAW" && key != "VSDEBUGGER" && key != "AUTH_PASSWORD" && key != "HTTP_COOKIE")
                        srv_vars.Append("&nbsp;&nbsp;&nbsp;<b>" + key + "&nbsp;:</b>&nbsp;&nbsp;" + val + "<br>");
                }

                strContent.Append("<table class=tbl><tr><td nowrap>");
                strContent.Append("<b><a id=\"used_asms\" href=# onclick=\"javascript:used_asms_reactor();\">" + rm.GetString("UsedAssembly_" + ui_culture) + "</a></b><br>");
                strContent.Append("</td><td nowrap>");
                strContent.Append("<b><a id=\"srv_vars\" href=# onclick=\"javascript:srv_vars_reactor();\">" + rm.GetString("ServerVars_" + ui_culture) + "</a></b><br>");
                strContent.Append("</td></tr><tr><td nowrap valign=top>");
                strContent.Append("<div id=asm style='visibility:hidden'>");
                strContent.Append(asms);
                strContent.Append("</div>");
                strContent.Append("</td><td nowrap valign=top>");
                strContent.Append("<div id=vars style='visibility:hidden'>");
                strContent.Append(srv_vars.ToString());
                strContent.Append("</div>");
                strContent.Append("</td></tr></table>");

                strContent.Append("</div>");
            }

            strContent.Append("<br><div>© 2007 UNITY-BARS. All rights reserved.</div>");
            strContent.Append("    </body>\r\n");
            strContent.Append("</html>\r\n");

            if (isCanOpenConnection)
            {
                try
                {
                    decimal errNum = -1;
                    errNum = DBLogger.Exception(_objErr);
                    strContent.Insert(nPureMsgIndex, "<br><hr width=100% size=1 color=black><div class=h3>" + rm.GetString("SecAuditNumber_" + ui_culture) + " " + errNum + ".</div> ");
                }
                catch (System.Exception ex)
                {
                    string msg = "<br>" + rm.GetString("SecAuditError_" + ui_culture) + "<br>[" + ex.Message + "<br>Stack:" + ex.StackTrace + "]" + "<br>";
                    strContent.Insert(nPureMsgIndex, msg);
                }
            }
            return strContent.ToString();
        }

        private void WriteColoredSquare(StringBuilder sb, string title, string description, string content, bool wrapContentLines)
        {
            if (title != null)
            {
                sb.Append(string.Concat(new string[] { "            <b>", title, ":</b> ", description, "<br>\r\n" }));
                sb.Append("            <table width=100% bgcolor=\"#ffffcc\">\r\n");
                sb.Append("               <tr>\r\n");
                sb.Append("                  <td>\r\n");
                sb.Append("                      <code>");
                if (!wrapContentLines)
                {
                    sb.Append("<pre>");
                }
                sb.Append("\r\n\r\n");
                sb.Append(content);
                if (!wrapContentLines)
                {
                    sb.Append("</pre>");
                }
                sb.Append("</code>\r\n\r\n");
                sb.Append("                  </td>\r\n");
                sb.Append("               </tr>\r\n");
                sb.Append("            </table>\r\n\r\n");
                sb.Append("            <br>\r\n");
            }
        }
    }
    /// <summary>
    /// Клас выбора сертификата но серийному номеру
    /// </summary>
    class SSLCertificate
    {

        private static int CERT_STORE_PROV_SYSTEM = 10;
        private static int CERT_SYSTEM_STORE_CURRENT_USER = (1 << 16);
	//private static int CERT_SYSTEM_STORE_USERS = (1 << 16);
        private static int CERT_SYSTEM_STORE_LOCAL_MACHINE = (2 << 16);

        [DllImport("CRYPT32", EntryPoint = "CertOpenStore", CharSet = CharSet.Unicode, SetLastError = true)]
        public static extern IntPtr CertOpenStore(
            int storeProvider, int encodingType,
            int hcryptProv, int flags, string pvPara);

        [DllImport("CRYPT32", EntryPoint = "CertEnumCertificatesInStore", CharSet = CharSet.Unicode, SetLastError = true)]
        public static extern IntPtr CertEnumCertificatesInStore(
            IntPtr storeProvider,
            IntPtr prevCertContext);

        [DllImport("CRYPT32", EntryPoint = "CertCloseStore", CharSet = CharSet.Unicode, SetLastError = true)]
        public static extern bool CertCloseStore(
            IntPtr storeProvider,
            int flags);

        X509CertificateCollection m_certs;

        public SSLCertificate()
        {
            m_certs = new X509CertificateCollection();
        }

        public int Init()
        {
            IntPtr storeHandle;
            storeHandle = CertOpenStore(CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_LOCAL_MACHINE, "MY");
            IntPtr currentCertContext;
            currentCertContext = CertEnumCertificatesInStore(storeHandle, (IntPtr)0);
            int i = 0;
            while (currentCertContext != (IntPtr)0)
            {
                m_certs.Insert(i++, new X509Certificate(currentCertContext));
                currentCertContext = CertEnumCertificatesInStore(storeHandle, currentCertContext);
            }
            CertCloseStore(storeHandle, 0);

            return m_certs.Count;
        }

        public X509Certificate this[int index]
        {
            get
            {
                // Проверка лимита кол-ва сертификатов.
                if (index < 0 || index > m_certs.Count)
                    return null;
                else
                    return m_certs[index];
            }
        }
    }
    
    /// <summary>
    /// Клас выбора сертификата но серийному номеру
    /// </summary>
    
    class ClientCertificate
    {

        public X509Certificate GetCertificate(string CertSerialNumber)
        {
            try
            {
                //Создаем список сертификатов клиента
                SSLCertificate mycert = new SSLCertificate();
                //Получаем к-во установленных сертификатов
                int cnt = mycert.Init();
		//Bars.Logger.DBLogger.Info("certificate cnt = " + cnt.ToString() );
                //ищем сертификат по серийнику
                for (int i = 0; i < cnt; i++)
                {
                    string sn = mycert[i].GetSerialNumberString();
			//Bars.Logger.DBLogger.Info("certificate serial number = " + sn);
                    if (Equals(CertSerialNumber.ToUpper(), sn.ToUpper()))
                    {
                       // Bars.Logger.DBLogger.Info("certificate serial number = " + sn);
			return mycert[i];
                    }


                }
                return null;


            }
            catch (System.Exception ex)
            {
                Bars.Logger.DBLogger.Info("Error text = " + ex.Message );
		return null;
            }

        }

    }

    
    /// <summary>
    /// Класс для работы с профилем пользователя 
    /// </summary>
    public class WebUserProfiles
    {
        //private static WebUserProfiles _WUP = new WebUserProfiles();

        private WebUserProfiles() { }

        /*public static WebUserProfiles GetWebUserProfiles() {
            return _WUP;
        }*/


        public static string GetParam(string Key)
        {

            // Создаем connection 
            IOraConnection conn = OraConnector.Handler.IOraConnection;
            OracleConnection con = conn.GetUserConnection();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
                cmd.ExecuteNonQuery();

                // Читаем из БД
                cmd.Parameters.Clear();
                cmd.Parameters.Add("param_name_", OracleDbType.Varchar2, Key, ParameterDirection.Input);
                cmd.CommandText = "SELECT web_profile_context.get_param(:param_name_) FROM DUAL";
                return Convert.ToString(cmd.ExecuteScalar());

            }
            // Закрываем connection
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        public static void SetParam(string Key, string Value)
        {
            // Создаем connection 
            IOraConnection conn = OraConnector.Handler.IOraConnection;
            OracleConnection con = conn.GetUserConnection();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
                cmd.ExecuteNonQuery();

                // Изменения в БД
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add("param_name_", OracleDbType.Varchar2, Key, ParameterDirection.Input);
                cmd.Parameters.Add("param_value_", OracleDbType.Varchar2, Value, ParameterDirection.Input);
                cmd.CommandText = "web_profile_context.set_param";
                cmd.ExecuteNonQuery();

            }
            // Закрываем connection
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        public static void SetProfileParam(string ProfileId, string Key, string Value)
        {
            // Создаем connection 
            IOraConnection conn = OraConnector.Handler.IOraConnection;
            OracleConnection con = conn.GetUserConnection();
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
                cmd.ExecuteNonQuery();

                // Изменения в БД
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.Add("profileid_", OracleDbType.Varchar2, ProfileId, ParameterDirection.Input);
                cmd.Parameters.Add("param_name_", OracleDbType.Varchar2, Key, ParameterDirection.Input);
                cmd.Parameters.Add("param_value_", OracleDbType.Varchar2, Value, ParameterDirection.Input);
                cmd.CommandText = "web_profile_context.set_profile_param";
                cmd.ExecuteNonQuery();

            }
            // Закрываем connection
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }
}
