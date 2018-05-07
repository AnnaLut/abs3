using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Text;
using System.Web;
using BarsWeb.Core.Infrastructure.Repository;
using BarsWeb.Core.Models;

namespace BarsWeb.Core.Logger
{
    /// <summary>
    /// Клас бібліотеки
    /// </summary>
    public class DbLogger : IDbLogger
    {
        private readonly IUserInfoRepository _userRepository;
        private readonly CoreDbContext _dbContext;
        public DbLogger(ICoreModel dbModel, IUserInfoRepository userRepository)
        {
            _dbContext = dbModel.GetDbContext();
            _userRepository = userRepository;
        }

        private decimal ExecuteProcedure(string name, string message, string moduleName)
        {
            decimal result = decimal.MinValue;
            object[] parameters =
            {
                (message.Length > 4000 ? message.Substring(0, 4000) : message),
                moduleName,
                HttpContext.Current.Request.UserHostAddress,
                result
            };
            var sql = string.Format(
                        @"begin 
                            bars_audit.{0}(
                                substr(:p_msg,1,4000),
                                :p_module,
                                substr(:p_machine,1,15),
                                :p_ID);                            
                         end;",
                        name);

            _dbContext.Database.ExecuteSqlCommand(sql, parameters);
            result = Convert.ToDecimal(Convert.ToString(parameters[3]));
            return result;
        }

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Trace(string messageText)
        {
            return Trace(messageText, string.Empty);
        }


        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Trace(string messageText, string moduleName)
        {
            return ExecuteProcedure("trace", messageText, moduleName);
        }

        public decimal WriteTraceMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return Trace(messageText, moduleName);
        }
        public decimal WriteTraceMessage(string messageText, HttpContext ctx)
        {
            return Trace(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Debug(string messageText)
        {
            return Debug(messageText, String.Empty);
        }

        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Debug(string messageText, string moduleName)
        {
            return ExecuteProcedure("debug", messageText, moduleName);
        }

        public decimal WriteDebugMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return Debug(messageText, moduleName);
        }
        public decimal WriteDebugMessage(string messageText, HttpContext ctx)
        {
            return Debug(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Info(string messageText)
        {
            return Info(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Info(string messageText, string moduleName)
        {
            return ExecuteProcedure("info", messageText, moduleName);
        }
        public decimal WriteInfoMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return Info(messageText, moduleName);
        }
        public decimal WriteInfoMessage(string messageText, HttpContext ctx)
        {
            return Info(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Security(string messageText)
        {
            return Security(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Security(string messageText, string moduleName)
        {
            return ExecuteProcedure("security", messageText, moduleName);
        }
        public decimal WriteSecurityMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return Security(messageText, moduleName);
        }
        public decimal WriteSecurityMessage(string messageText, HttpContext ctx)
        {
            return Security(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Financial(string messageText)
        {
            return Financial(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Financial(string messageText, string moduleName)
        {
            return ExecuteProcedure("financial", messageText, moduleName);
        }
        public decimal WriteFinancialMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return Financial(messageText, moduleName);
        }
        public decimal WriteFinancialMessage(string messageText, HttpContext ctx)
        {
            return Financial(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Warning(string messageText)
        {
            return Warning(messageText, String.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Warning(string messageText, string moduleName)
        {
            return ExecuteProcedure("warning", messageText, moduleName);
        }
        public decimal WriteWarningMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return Warning(messageText, moduleName);
        }
        public decimal WriteWarningMessage(string messageText, HttpContext ctx)
        {
            return Warning(messageText);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Error(string messageText)
        {
            return Error(messageText, string.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Error(string messageText, string moduleName)
        {
            return ExecuteProcedure("error", messageText, moduleName);
        }

        public decimal WriteErrorMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return Error(messageText, moduleName);
        }
        public decimal WriteErrorMessage(string messageText, HttpContext ctx)
        {
            return Error(messageText);
        }
        /// <summary>
        /// Запис в базу інформації
        /// про помилку
        /// </summary>
        /// <param name="e">Помилка</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Exception(Exception e)
        {
            HttpContext ctx = HttpContext.Current;
            string sFileName = null;
            int sLine = 0;
            ArrayList exStack = new ArrayList();
            Exception initialException = null;
            for (Exception ex = e; ex != null; ex = ex.InnerException)
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
            strContent.Append(initialException.GetType());
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
                    sFileName = frame.GetFileName();
                    sLine = frame.GetFileLineNumber();
                }
            }
            if (sFileName != null)
            {
                StringBuilder strCode = new StringBuilder();
                try
                {
                    if (sFileName.StartsWith("http"))
                        sFileName = HttpContext.Current.Server.MapPath(sFileName.Substring(sFileName.IndexOf("barsroot") - 1));
                    FileInfo f = new FileInfo(sFileName);
                    if (f.Exists)
                    {
                        StreamReader reader = new StreamReader(sFileName);
                        string strLine;
                        int pos = 1;
                        while ((strLine = reader.ReadLine()) != null)
                        {
                            if ((pos >= (sLine - 2)) && (pos <= (sLine + 2)))
                            {
                                string errLine = pos.ToString("G");
                                strCode.Append(string.Format("Строка {0}:", errLine));
                                if (errLine.Length < 3)
                                    strCode.Append(' ', 3 - errLine.Length);
                                strCode.Append(strLine);
                                if (pos != (sLine + 2))
                                    strCode.Append("\n");
                            }
                            if (pos <= (sLine + 2))
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
                    strContent.Append("s_fileName=" + sFileName);
                }
                strContent.Append("Исходный код:\n");
                strContent.Append(strCode);
                strContent.Append("\n");
                strContent.Append("Исходный файл: ");
                strContent.Append(sFileName);
                strContent.Append(" Строка: ");
                strContent.Append(sLine);
                strContent.Append("\n");
            }
            strContent.Append("Детальная информация:\n");
            // формируем текст трассы исключений
            StringBuilder strStackTrace = new StringBuilder();
            for (int i = exStack.Count - 1; i >= 0; i--)
            {
                Exception exCur = (Exception)exStack[i];
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
                    string infoVersion = string.Empty;
                    if (obj.Length > 0)
                        infoVersion = (obj[0] as AssemblyInformationalVersionAttribute).InformationalVersion;
                    if (infoVersion == string.Empty)
                        infoVersion = a.FullName.Split(',')[1].Split('=')[1];
                    asms += "Сборка: " + a.FullName.Split(',')[0] + " Версия продукта: " + infoVersion + " Версия: " + a.FullName.Split(',')[1].Split('=')[1] + " Дата: " + fi.LastWriteTime.ToString("dd.MM.yyyy HH:mm") + "\n";
                }
            }
            strContent.Append("Используемые сборки:\n");
            strContent.Append(asms);

            return Error(strContent.ToString());
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Fatal(string messageText)
        {
            return Fatal(messageText, string.Empty);
        }
        /// <summary>
        /// Запис в базу повідомлення
        /// </summary>
        /// <param name="messageText">Текст повідомлення</param>
        /// <param name="moduleName">Модуль</param>
        /// <returns>Номер запису в базі</returns>
        public decimal Fatal(string messageText, string moduleName)
        {
            return ExecuteProcedure("fatal", messageText, moduleName);
        }
        public decimal WriteFatalMessage(string messageText, string moduleName, HttpContext ctx)
        {
            return Fatal(messageText, moduleName);
        }
        public decimal WriteFatalMessage(string messageText, HttpContext ctx)
        {
            return Fatal(messageText);
        }
    }
}
