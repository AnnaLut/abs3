using System;
using System.Data;
using System.Web;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Text;
using System.IO;
using System.Reflection;
using System.Diagnostics;
using System.Collections;

namespace Bars.Logger
{
    /// <summary>
    /// Іменовані константи рівнів повідомлень
    /// </summary>
    enum MESSAGE
    {
        LOG_LEVEL_TRACE = 8,
        LOG_LEVEL_DEBUG = 7,
        LOG_LEVEL_INFO = 6,
        LOG_LEVEL_SECURITY = 5,
        LOG_LEVEL_FINANCIAL = 4,
        LOG_LEVEL_WARNING = 3,
        LOG_LEVEL_ERROR = 2,
        LOG_LEVEL_FATAL = 1
    };
    /// <summary>
    /// Клас бібліотеки
    /// </summary>
    public class DBLogger
    {
        public DBLogger() { }

        /// <summary>
        /// Берем уровень детализации из данных о пользователе в памяти
        /// </summary>
        private static MESSAGE getUserLogLevel()
        {
            MESSAGE res = MESSAGE.LOG_LEVEL_INFO;
            string sLogLevel = "LOG_LEVEL_" + Bars.Configuration.ConfigurationSettings.GetCurrentUserInfo.log_level;
            try
            {
                res = (MESSAGE)Enum.Parse(typeof(MESSAGE), sLogLevel);
            }
            catch
            {

            }
            return res;
        }


        /*
		/// <summary>
		/// Рівень деталізації повідомлень
		/// </summary>
		/// <returns>рівень відповідно до MESSAGE</returns>
		public static Decimal	GetLogLevel				()
		{
			Decimal result = Decimal.MinValue;

			HttpContext ctx = HttpContext.Current;

			IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();
			
			try
			{
				OracleCommand cmdSetRole = connect.CreateCommand();
				cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
				cmdSetRole.ExecuteNonQuery();

				OracleCommand cmdGetLogLevel = new OracleCommand();
				cmdGetLogLevel.Connection = connect;
				cmdGetLogLevel.CommandText = "select bars_audit.get_log_level from dual";
				result = Convert.ToDecimal(Convert.ToString(cmdGetLogLevel.ExecuteScalar()));
			}

			finally
			{
				if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
			}
			return result;
		}
		/// <summary>
		/// Поточний модуль
		/// </summary>
		/// <returns>Імя поточного модуля</returns>
		public static string	GetModule				()
		{
			string result = string.Empty;

			HttpContext ctx = HttpContext.Current;

			IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

			try
			{
				OracleCommand cmdSetRole = connect.CreateCommand();
				cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
				cmdSetRole.ExecuteNonQuery();

				OracleCommand cmdGetLogLevel = new OracleCommand();
				cmdGetLogLevel.Connection = connect;
				cmdGetLogLevel.CommandText = "select bars_audit.get_module from dual";
				result = Convert.ToString(cmdGetLogLevel.ExecuteScalar());
			}

			finally
			{
				if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
			}
			return result;
		}
		/// <summary>
		/// Поточний модуль
		/// </summary>
		/// <param name="moduleName">Імя</param>
		public static void		SetModule				(string moduleName)
		{
			HttpContext ctx = HttpContext.Current;

			IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

			try
			{
				OracleCommand cmdSetRole = connect.CreateCommand();
				cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
				cmdSetRole.ExecuteNonQuery();

				OracleCommand cmdSetModule = new OracleCommand();
				cmdSetModule.Connection = connect;
				cmdSetModule.CommandText =
					"begin "					+
					"bars_audit.set_module("	+		
					":p_module); "				+
					"end;";
		
				cmdSetModule.Parameters.Add("p_module",OracleDbType.Varchar2,moduleName,ParameterDirection.Input);

				cmdSetModule.ExecuteNonQuery();
			}

			finally
			{
				if (connect.State != ConnectionState.Closed)
				{connect.Close();connect.Dispose();}
			}
		}
        */
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Trace(string messageText)
        {
            return DBLogger.Trace(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Trace(string messageText, string moduleName)
        {
            if (getUserLogLevel() < MESSAGE.LOG_LEVEL_TRACE)
                return -1;
            Decimal result = Decimal.MinValue;

            HttpContext ctx = HttpContext.Current;

            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdRegisterMessage = new OracleCommand();
                cmdRegisterMessage.Connection = connect;
                cmdRegisterMessage.CommandText =
                    "begin " +
                    "bars_audit.trace(" +
                    "substr(:p_msg,1,4000), " +
                    ":p_module, " +
                    "substr(:p_machine,1,15), " +
                    ":p_ID); " +
                    "end;";

                cmdRegisterMessage.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000,
                    (messageText.Length > 4000 ? messageText.Substring(0, 4000) : messageText),
                    ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_module", OracleDbType.Varchar2, moduleName, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_machine", OracleDbType.Varchar2, ctx.Request.UserHostAddress, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_ID", OracleDbType.Decimal, result, ParameterDirection.Output);

                cmdRegisterMessage.ExecuteNonQuery();

                result = Convert.ToDecimal(Convert.ToString(cmdRegisterMessage.Parameters["p_ID"].Value));
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
            return result;
        }

        public static Decimal WriteTraceMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return DBLogger.Trace(messageText, moduleName);
        }
        public static Decimal WriteTraceMessage(string messageText, HttpContext ctx)
        {
            return DBLogger.Trace(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Debug(string messageText)
        {
            return DBLogger.Debug(messageText, String.Empty);
        }

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Debug(string messageText, string moduleName)
        {
            if (getUserLogLevel() < MESSAGE.LOG_LEVEL_DEBUG)
                return -1;
            Decimal result = Decimal.MinValue;

            HttpContext ctx = HttpContext.Current;

            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                OracleCommand cmdSetRole = new OracleCommand();
                cmdSetRole.Connection = connect;
                cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdRegisterMessage = new OracleCommand();
                cmdRegisterMessage.Connection = connect;
                cmdRegisterMessage.CommandText =
                    "begin " +
                    "bars_audit.debug(" +
                    "substr(:p_msg,1,4000), " +
                    ":p_module, " +
                    "substr(:p_machine,1,15), " +
                    ":p_ID); " +
                    "end;";
                cmdRegisterMessage.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000,
                    (messageText.Length > 4000 ? messageText.Substring(0, 4000) : messageText),
                    ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_module", OracleDbType.Varchar2, moduleName, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_machine", OracleDbType.Varchar2, ctx.Request.UserHostAddress, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_ID", OracleDbType.Decimal, result, ParameterDirection.Output);

                cmdRegisterMessage.ExecuteNonQuery();

                result = Convert.ToDecimal(Convert.ToString(cmdRegisterMessage.Parameters["p_ID"].Value));
            }
            //catch (Exception ex)
            //{
            //    ;
            //}
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
            return result;
        }

        public static Decimal WriteDebugMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return DBLogger.Debug(messageText, moduleName);
        }
        public static Decimal WriteDebugMessage(string messageText, HttpContext ctx)
        {
            return DBLogger.Debug(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Info(string messageText)
        {
            return DBLogger.Info(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Info(string messageText, string moduleName)
        {
            if (getUserLogLevel() < MESSAGE.LOG_LEVEL_INFO)
                return -1;
            Decimal result = Decimal.MinValue;

            HttpContext ctx = HttpContext.Current;

            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdRegisterMessage = new OracleCommand();
                cmdRegisterMessage.Connection = connect;
                cmdRegisterMessage.CommandText =
                    "begin " +
                    "bars_audit.info(" +
                    "substr(:p_msg,1,4000), " +
                    ":p_module, " +
                    "substr(:p_machine,1,15), " +
                    ":p_ID); " +
                    "end;";

                cmdRegisterMessage.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000,
                    (messageText.Length > 4000 ? messageText.Substring(0, 4000) : messageText),
                    ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_module", OracleDbType.Varchar2, moduleName, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_machine", OracleDbType.Varchar2, ctx.Request.UserHostAddress, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_ID", OracleDbType.Decimal, result, ParameterDirection.Output);

                cmdRegisterMessage.ExecuteNonQuery();

                result = Convert.ToDecimal(Convert.ToString(cmdRegisterMessage.Parameters["p_ID"].Value));
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            return result;
        }
        public static Decimal WriteInfoMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return DBLogger.Info(messageText, moduleName);
        }
        public static Decimal WriteInfoMessage(string messageText, HttpContext ctx)
        {
            return DBLogger.Info(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Security(string messageText)
        {
            return DBLogger.Security(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Security(string messageText, string moduleName)
        {
            if (getUserLogLevel() < MESSAGE.LOG_LEVEL_SECURITY)
                return -1;
            Decimal result = Decimal.MinValue;

            HttpContext ctx = HttpContext.Current;

            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdRegisterMessage = new OracleCommand();
                cmdRegisterMessage.Connection = connect;
                cmdRegisterMessage.CommandText =
                    "begin " +
                    "bars_audit.security(" +
                    "substr(:p_msg,1,4000), " +
                    ":p_module, " +
                    "substr(:p_machine,1,15), " +
                    ":p_ID); " +
                    "end;";

                cmdRegisterMessage.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000,
                    (messageText.Length > 4000 ? messageText.Substring(0, 4000) : messageText),
                    ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_module", OracleDbType.Varchar2, moduleName, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_machine", OracleDbType.Varchar2, ctx.Request.UserHostAddress, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_ID", OracleDbType.Decimal, result, ParameterDirection.Output);

                cmdRegisterMessage.ExecuteNonQuery();

                result = Convert.ToDecimal(Convert.ToString(cmdRegisterMessage.Parameters["p_ID"].Value));
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
            return result;
        }
        public static Decimal WriteSecurityMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return DBLogger.Security(messageText, moduleName);
        }
        public static Decimal WriteSecurityMessage(string messageText, HttpContext ctx)
        {
            return DBLogger.Security(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Financial(string messageText)
        {
            return DBLogger.Financial(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Financial(string messageText, string moduleName)
        {
            if (getUserLogLevel() < MESSAGE.LOG_LEVEL_FINANCIAL)
                return -1;
            Decimal result = Decimal.MinValue;

            HttpContext ctx = HttpContext.Current;

            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdRegisterMessage = new OracleCommand();
                cmdRegisterMessage.Connection = connect;
                cmdRegisterMessage.CommandText =
                    "begin " +
                    "bars_audit.financial(" +
                    "substr(:p_msg,1,4000), " +
                    ":p_module, " +
                    "substr(:p_machine,1,15), " +
                    ":p_ID); " +
                    "end;";

                cmdRegisterMessage.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000,
                    (messageText.Length > 4000 ? messageText.Substring(0, 4000) : messageText),
                    ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_module", OracleDbType.Varchar2, moduleName, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_machine", OracleDbType.Varchar2, ctx.Request.UserHostAddress, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_ID", OracleDbType.Decimal, result, ParameterDirection.Output);

                cmdRegisterMessage.ExecuteNonQuery();

                result = Convert.ToDecimal(Convert.ToString(cmdRegisterMessage.Parameters["p_ID"].Value));
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
            return result;
        }
        public static Decimal WriteFinancialMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return DBLogger.Financial(messageText, moduleName);
        }
        public static Decimal WriteFinancialMessage(string messageText, HttpContext ctx)
        {
            return DBLogger.Financial(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Warning(string messageText)
        {
            return DBLogger.Warning(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Warning(string messageText, string moduleName)
        {
            if (getUserLogLevel() < MESSAGE.LOG_LEVEL_WARNING)
                return -1;
            Decimal result = Decimal.MinValue;

            HttpContext ctx = HttpContext.Current;

            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdRegisterMessage = new OracleCommand();
                cmdRegisterMessage.Connection = connect;
                cmdRegisterMessage.CommandText =
                    "begin " +
                    "bars_audit.warning(" +
                    "substr(:p_msg,1,4000), " +
                    ":p_module, " +
                    "substr(:p_machine,1,15), " +
                    ":p_ID); " +
                    "end;";

                cmdRegisterMessage.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000,
                    (messageText.Length > 4000 ? messageText.Substring(0, 4000) : messageText),
                    ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_module", OracleDbType.Varchar2, moduleName, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_machine", OracleDbType.Varchar2, ctx.Request.UserHostAddress, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_ID", OracleDbType.Decimal, result, ParameterDirection.Output);

                cmdRegisterMessage.ExecuteNonQuery();

                result = Convert.ToDecimal(Convert.ToString(cmdRegisterMessage.Parameters["p_ID"].Value));
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            return result;
        }
        public static Decimal WriteWarningMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return DBLogger.Warning(messageText, moduleName);
        }
        public static Decimal WriteWarningMessage(string messageText, HttpContext ctx)
        {
            return DBLogger.Warning(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Error(string messageText)
        {
            return DBLogger.Error(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Error(string messageText, string moduleName)
        {
            if (getUserLogLevel() < MESSAGE.LOG_LEVEL_ERROR)
                return -1;
            Decimal result = Decimal.MinValue;

            HttpContext ctx = HttpContext.Current;

            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdRegisterMessage = new OracleCommand();
                cmdRegisterMessage.Connection = connect;
                cmdRegisterMessage.CommandText =
                    "begin " +
                    "bars_audit.error(" +
                    "substr(:p_msg,1,4000), " +
                    ":p_module, " +
                    "substr(:p_machine,1,15), " +
                    ":p_ID); " +
                    "end;";

                cmdRegisterMessage.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000,
                    (messageText.Length > 4000 ? messageText.Substring(0, 4000) : messageText),
                    ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_module", OracleDbType.Varchar2, moduleName, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_machine", OracleDbType.Varchar2, ctx.Request.UserHostAddress, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_ID", OracleDbType.Decimal, result, ParameterDirection.Output);

                cmdRegisterMessage.ExecuteNonQuery();

                result = Convert.ToDecimal(Convert.ToString(cmdRegisterMessage.Parameters["p_ID"].Value));
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            return result;
        }

        public static Decimal WriteErrorMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return DBLogger.Error(messageText, moduleName);
        }
        public static Decimal WriteErrorMessage(string messageText, HttpContext ctx)
        {
            return DBLogger.Error(messageText);
        }
        /// <summary>
        /// Запис в базу інформації
        /// про помилку
        /// </summary>
        /// <param name="e">Помилка</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Exception(System.Exception e)
        {
            HttpContext ctx = HttpContext.Current;
            string s_fileName = null;
            int s_line = 0;
            ArrayList exStack = new ArrayList();
            System.Exception initialException = null;
            for (System.Exception ex = e; ex != null; ex = ex.InnerException)
            {
                exStack.Add(ex);
                initialException = ex;
            }
            StringBuilder strContent = new StringBuilder();
            strContent.Append("Описание ошибки");
            strContent.Append("\n");
            strContent.Append("Страница: ");
            strContent.Append(HttpContext.Current.Session["UrlPageError"]);
            strContent.Append("\n");
            strContent.Append("Пользователь Web: ");
            strContent.Append(ctx.User.Identity.Name);
            strContent.Append("(IP : " + ctx.Request.UserHostAddress + ", Host : " + HttpContext.Current.Request.UserHostName + ")");
            strContent.Append("\n");
            strContent.Append("Сервер: ");
            strContent.Append(ctx.Server.MachineName);
            strContent.Append("\n");
            strContent.Append("Описание ошибки: ");
            strContent.Append(initialException.GetType().ToString());
            strContent.Append(": ");
            strContent.Append(initialException.Message);
            strContent.Append("\n");
            // формируем ссылки на исходный код
            StackTrace trace = new StackTrace(initialException, true);
            for (int i = 0; i < trace.FrameCount; i++)
            {
                StackFrame frame = trace.GetFrame(i);
                if (frame.GetILOffset() != -1 && frame.GetFileName() != null)
                {
                    s_fileName = frame.GetFileName();
                    s_line = frame.GetFileLineNumber();
                }
            }
            if (s_fileName != null)
            {
                StringBuilder strCode = new StringBuilder();
                try
                {
                    if (s_fileName.StartsWith("http"))
                        s_fileName = HttpContext.Current.Server.MapPath(s_fileName.Substring(s_fileName.IndexOf("barsroot") - 1));
                    FileInfo f = new FileInfo(s_fileName);
                    if (f.Exists)
                    {
                        StreamReader reader = new StreamReader(s_fileName);
                        string strLine;
                        int pos = 1;
                        while ((strLine = reader.ReadLine()) != null)
                        {
                            if ((pos >= (s_line - 2)) && (pos <= (s_line + 2)))
                            {
                                string errLine = pos.ToString("G");
                                strCode.Append(string.Format("Строка {0}:", errLine));
                                if (errLine.Length < 3)
                                    strCode.Append(' ', 3 - errLine.Length);
                                strCode.Append(strLine);
                                if (pos != (s_line + 2))
                                    strCode.Append("\n");
                            }
                            if (pos <= (s_line + 2))
                                pos++;
                            else
                                break;
                        }
                        reader.Close();
                    }
                    else
                    {
                        strCode.Append("Недоступен");
                    }
                }
                catch (ArgumentException)
                {
                    strContent.Append("s_fileName=" + s_fileName);
                }
                strContent.Append("Исходный код:\n");
                strContent.Append(strCode);
                strContent.Append("\n");
                strContent.Append("Исходный файл: ");
                strContent.Append(s_fileName);
                strContent.Append(" Строка: ");
                strContent.Append(s_line);
                strContent.Append("\n");
            }
            strContent.Append("Детальная информация:\n");
            // формируем текст трассы исключений
            StringBuilder strStackTrace = new StringBuilder();
            for (int i = exStack.Count - 1; i >= 0; i--)
            {
                System.Exception exCur = (System.Exception)exStack[i];
                strStackTrace.Append("[" + exStack[i].GetType().Name + ": " + exCur.Message + "]\n");
                if (null != exCur.StackTrace)
                {
                    strStackTrace.Append(exCur.StackTrace);
                }
                strStackTrace.Append("\n");
            }
            strContent.Append(strStackTrace);
            // версия приложения
            Assembly[] loadedAssemblies = AppDomain.CurrentDomain.GetAssemblies();
            string asms = string.Empty;
            foreach (Assembly a in loadedAssemblies)
            {
                if (a.FullName.StartsWith("Bars"))
                {
                    FileInfo fi = new FileInfo(a.Location);
                    object[] obj = a.GetCustomAttributes(typeof(AssemblyInformationalVersionAttribute), true);
                    string InfoVersion = string.Empty;
                    if (obj.Length > 0)
                        InfoVersion = (obj[0] as AssemblyInformationalVersionAttribute).InformationalVersion;
                    if (InfoVersion == string.Empty)
                        InfoVersion = a.FullName.Split(',')[1].Split('=')[1];
                    asms += "Сборка: " + a.FullName.Split(',')[0] + " Версия продукта: " + InfoVersion + " Версия: " + a.FullName.Split(',')[1].Split('=')[1] + " Дата: " + fi.LastWriteTime.ToString("dd.MM.yyyy HH:mm") + "\n";
                }
            }
            strContent.Append("Используемые сборки:\n");
            strContent.Append(asms);

            return DBLogger.Error(strContent.ToString());
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Fatal(string messageText)
        {
            return DBLogger.Fatal(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public static Decimal Fatal(string messageText, string moduleName)
        {
            if (getUserLogLevel() < MESSAGE.LOG_LEVEL_FATAL)
                return -1;
            Decimal result = Decimal.MinValue;

            HttpContext ctx = HttpContext.Current;

            IOraConnection conn = (IOraConnection)ctx.Application["OracleConnectClass"];
            OracleConnection connect = conn.GetUserConnection();

            try
            {
                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("log_role");
                cmdSetRole.ExecuteNonQuery();

                OracleCommand cmdRegisterMessage = new OracleCommand();
                cmdRegisterMessage.Connection = connect;
                cmdRegisterMessage.CommandText =
                    "begin " +
                    "bars_audit.fatal(" +
                    "substr(:p_msg,1,4000), " +
                    ":p_module, " +
                    "substr(:p_machine,1,15), " +
                    ":p_ID); " +
                    "end;";

                cmdRegisterMessage.Parameters.Add("p_msg", OracleDbType.Varchar2, 4000,
                    (messageText.Length > 4000 ? messageText.Substring(0, 4000) : messageText),
                    ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_module", OracleDbType.Varchar2, moduleName, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_machine", OracleDbType.Varchar2, ctx.Request.UserHostAddress, ParameterDirection.Input);
                cmdRegisterMessage.Parameters.Add("p_ID", OracleDbType.Decimal, result, ParameterDirection.Output);

                cmdRegisterMessage.ExecuteNonQuery();

                result = Convert.ToDecimal(Convert.ToString(cmdRegisterMessage.Parameters["p_ID"].Value));
            }

            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }

            return result;
        }
        public static Decimal WriteFatalMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return DBLogger.Fatal(messageText, moduleName);
        }
        public static Decimal WriteFatalMessage(string messageText, HttpContext ctx)
        {
            return DBLogger.Fatal(messageText);
        }
    }
}
