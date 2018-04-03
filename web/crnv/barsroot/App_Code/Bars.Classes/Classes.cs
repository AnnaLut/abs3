using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.SessionState;
using System.Web.Services.Protocols;
using System.Xml;
using Bars.Configuration;
using Bars.Logger;
using System.Resources;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

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

        public static OraConnector Handler
        {
            get
            {
                if (_connector == null)
                    _connector = new OraConnector();
                return _connector;
            }
        }
        public void InitOraClass()
        {
            if (AppDomain.CurrentDomain.GetData("OracleConnectClass") == null || HttpContext.Current.Application["OracleConnectClass"] == null)
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
        public ErrorPageGenerator() { }

        /// <summary>
        /// Метод для генерации страницы информации об ошибке 
        /// </summary>
        /// <param name="objErr">исключение, которое произошло</param>
        /// <param name="full">уровень детализации описания ошибки</param>
        /// <returns>html-текст страницы</returns>
        public string GetHtmlErrorPage(System.Exception objErr, bool full)
        {
            ArrayList exStack = new ArrayList();
            System.Exception initialException = null;
            for (System.Exception ex = objErr; ex != null; ex = ex.InnerException)
            {
                exStack.Add(ex);
                initialException = ex;
            }

            string message = ((System.Exception)exStack[exStack.Count - 1]).Message;
            //string message = ((Exception)exStack[0]).Message.Replace("\n","<br>");
            decimal errNum = -1;
            //Локализация
            string ui_culture = System.Threading.Thread.CurrentThread.CurrentUICulture.Name.Substring(0, 2);
            ResourceManager rm = Resources.Bars.Classes.Resource.ResourceManager;
            //Признак, что описание генерируется пакетом bars_error.
            bool isBarsError = (Bars.Configuration.ConfigurationSettings.AppSettings.Get("Error.BarsPackage") == "On") ? (true) : (false);
            bool isOracleUserDefinedExeption = false;
            bool isCanOpenConnection = true;
            NameValueCollection errorDetail = new NameValueCollection();
            Regex re = new Regex(@"ORA-\d{5}");
            if (message.StartsWith("ORA-604"))
            {
                isCanOpenConnection = false;
                message = "Помилка доступу до бази даних. Можливо користувач заблокований.\nЗверніться до адміністратора.";
            }
            if (message.StartsWith("ORA-20") && re.IsMatch(message.Substring(0, 9)))
                isOracleUserDefinedExeption = true;
            if ((isBarsError || isOracleUserDefinedExeption) && isCanOpenConnection)
            {
                IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
                //IOraConnection conn = OraConnector.Handler.IOraConnection;
                OracleConnection con = new OracleConnection();
                try
                {
                    con = conn.GetUserConnection();
                    OracleCommand cmd = con.CreateCommand();
                    cmd.CommandText = conn.GetSetRoleCommand("BASIC_INFO");
                    cmd.ExecuteNonQuery();
                    if (isBarsError)
                    {
                        if (message.IndexOf("\n") > 0)
                            message = message.Substring(0, message.IndexOf("\n")).Trim();
                        // Читаем из БД
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add("p_errtxt", OracleDbType.Varchar2, message, ParameterDirection.Input);
                        cmd.Parameters.Add("p_errumsg", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
                        cmd.Parameters.Add("p_erracode", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
                        cmd.Parameters.Add("p_erramsg", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
                        cmd.Parameters.Add("p_errahlp", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
                        cmd.Parameters.Add("p_modcode", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
                        cmd.Parameters.Add("p_modname", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
                        cmd.Parameters.Add("p_errmsg", OracleDbType.Varchar2, 50000, null, ParameterDirection.Output);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "bars_error.get_error_info";
                        cmd.ExecuteNonQuery();
                        OracleString val = OracleString.Null;
                        message = ((val = (OracleString)cmd.Parameters["p_errumsg"].Value).IsNull) ? ("") : (val.Value);

                        errorDetail["p_errumsg"] = ((val = (OracleString)cmd.Parameters["p_errumsg"].Value).IsNull) ? ("") : (val.Value);
                        errorDetail["p_erracode"] = ((val = (OracleString)cmd.Parameters["p_erracode"].Value).IsNull) ? ("") : (val.Value);
                        errorDetail["p_erramsg"] = ((val = (OracleString)cmd.Parameters["p_erramsg"].Value).IsNull) ? ("") : (val.Value);
                        errorDetail["p_errahlp"] = ((val = (OracleString)cmd.Parameters["p_errahlp"].Value).IsNull) ? ("") : (val.Value);
                        errorDetail["p_modcode"] = ((val = (OracleString)cmd.Parameters["p_modcode"].Value).IsNull) ? ("") : (val.Value);
                        errorDetail["p_modname"] = ((val = (OracleString)cmd.Parameters["p_modname"].Value).IsNull) ? ("") : (val.Value);
                        errorDetail["p_errmsg"] = ((val = (OracleString)cmd.Parameters["p_errmsg"].Value).IsNull) ? ("") : (val.Value);
                    }
                    else
                    {
                        message = message.Substring(message.IndexOf(":") + 1).Trim();
                        if (message.StartsWith("\\"))
                        {
                            string codeError = message.Split(' ')[0].Replace("\\", "");
                            if (codeError.Length == 4)
                            {
                                message = message.Split('\n')[0];
                                string nls = string.Empty;
                                if (message.IndexOf("#") > 0)
                                {
                                    nls = message.Substring(message.IndexOf("#") + 1);
                                    if (nls.IndexOf(",") > 0)
                                        nls = nls.Substring(0, nls.IndexOf(",") - 1);
                                }
                                cmd.Parameters.Add("err", OracleDbType.Varchar2, codeError, ParameterDirection.Input);
                                cmd.CommandText = "SELECT n_er FROM s_er where k_er = :err";
                                string ErrAbsMessage = Convert.ToString(cmd.ExecuteScalar());
                                message = codeError + ": " + ErrAbsMessage + " " + nls;
                            }
                        }
                    }
                }
                catch (System.Exception ex)
                {
                    initialException = ex;
                    message = ex.Message;
                }
                finally
                {
                    if (con.State != ConnectionState.Closed)
                        con.Close();
                    con.Dispose();
                }
            }
            message = message.Replace("\n", "<br>");
            if (string.IsNullOrEmpty(message))
                message = initialException.Message;
            int nPureMsgIndex = 0;

            StringBuilder strContent = new StringBuilder();
            strContent.Append("<html>\r\n");
            strContent.Append("    <head>\r\n");
            strContent.Append("        <title>" + message + "</title>\r\n");
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

            strContent.Append(message);
            nPureMsgIndex = strContent.Length;

            strContent.Append("            </i></div>\r\n");

            if (full)
            {
                strContent.Append("<hr width=100% size=1 color=silver>\n");
                strContent.Append("<script language=\"javascript\">\n");
                strContent.Append("<!--\n");
                strContent.Append("	function add_info_reactor() {\n");
                strContent.Append("		 document.all.detail.style.visibility = \n");
                strContent.Append("			 (document.all.detail.style.visibility == 'visible') ? ('hidden'):('visible');\n");
                strContent.Append("		 if(document.all.detail.style.visibility=='hidden'){\n");
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
                strContent.Append("<div id=detail style='visibility:hidden'>");
                //Новое представление ошибки
                if (isBarsError)
                {
                    strContent.Append("            <b>" + rm.GetString("Module_" + ui_culture) + ":</b><br>");
                    strContent.Append("<input readonly type=text style='width:60px' value='" + errorDetail["p_modcode"] + "'>&nbsp;&nbsp;<input readonly type=text style='width:260px' value='" + errorDetail["p_modname"] + "'>");
                    strContent.Append("<br>\n");
                    strContent.Append("            <b>" + rm.GetString("ErrorText_" + ui_culture) + ":</b>");
                    strContent.Append("<textarea readonly style='width:100%' rows=2>" + errorDetail["p_erramsg"] + "</textarea>");
                    strContent.Append("<br>\n");
                    strContent.Append("            <b>" + rm.GetString("CurrAction_" + ui_culture) + ":</b>");
                    strContent.Append("<textarea readonly style='width:100%' rows=5>" + errorDetail["p_errahlp"] + "</textarea>");
                    strContent.Append("<br>\n");
                    strContent.Append("            <b>" + rm.GetString("Stack_" + ui_culture) + ":</b>");
                    string sourceCode = initialException.GetType().FullName + ": " + initialException.Message;
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
                if (initialException.Message != null && !isBarsError)
                {
                    strContent.Append("            <b> " + rm.GetString("ErrorText_" + ui_culture) + ": </b>");
                    strContent.Append(initialException.GetType().FullName + ":");
                    strContent.Append(HttpUtility.HtmlEncode(initialException.Message).Replace("\n", "<br>"));
                    strContent.Append("\n<br><br>\n");
                }

                StringBuilder strStackTrace = new StringBuilder();
                for (int i = exStack.Count - 1; i >= 0; i--)
                {
                    System.Exception exCur = (System.Exception)exStack[i];
                    strStackTrace.Append("[" + exStack[i].GetType().Name + ": " + exCur.Message + "]\r\n");
                    if (null != exCur.StackTrace)
                        strStackTrace.Append(exCur.StackTrace.Replace("\n", "<br>"));
                    strStackTrace.Append("\r\n\r\n<br><br>");
                }

                StackTrace trace = new StackTrace(initialException, true);
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
                    errNum = DBLogger.Exception(objErr);
                    strContent.Insert(nPureMsgIndex, "<br><hr width=100% size=1 color=black><div class=h3>" + rm.GetString("SecAuditNumber_" + ui_culture) + " " + errNum + ".</div> ");
                }
                catch (System.Exception ex)
                {
                    string msg = "<br>" + rm.GetString("SecAuditError_" + ui_culture) + "<br>[" + ex.Message + "<br>Stack:" + ex.StackTrace + "]" + "<br>";
                    strContent.Insert(nPureMsgIndex, msg);
                    nPureMsgIndex += msg.Length;
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
