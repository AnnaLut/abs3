using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Data;
using System.Web;
using Bars.Oracle;
using ICSharpCode.SharpZipLib.Zip;
using Oracle.DataAccess.Client;

namespace Bars.Web.Report
{
	/// <summary>
	/// Класс для множественного создания договоров для печати, 
	/// несколькно договоров в одном файле (множественный RtfReporter).
	/// </summary>
    public class MultiPrintRtfReporter : IDisposable
	{
		private HttpContext _httpContext;	     //текущий HTTP контекст

        private static string _tempDir;	         //временная директория

        private static long _adds;               //параметр ADDS для договоров

        private static OracleCommand _cmd;

		private long _nEvent = -1;	             //код события для трасировки сессии Oracle
	    private long _nLevel = -1;	             //уровень детализации события трасировки сессии Oracle

        private static Encoding _encoding = Encoding.GetEncoding(1251);

        /// <summary>
        /// Множественная печать договоров
        /// </summary>
        /// <param name="context">Текущий http контекст</param>
        public MultiPrintRtfReporter(HttpContext context)
        {
            _httpContext = context;

			//-- если в пути будет пробел, то ни один процесс который получает этот 
			//-- путь как параметр работать не будет (проверил tvSukhov)
			string strFilePrefix = Path.GetTempPath().Replace("Documents and Settings", "DOCUME~1").Replace("Local Settings", "LOCALS~1");

            if ('\\' != strFilePrefix[strFilePrefix.Length - 1])
            {
                strFilePrefix += "\\";
            }

            if (_httpContext.Session == null)
            {
                throw new ApplicationException("Не ініціалізована сесія!");
            }

            _tempDir = strFilePrefix + _httpContext.Session.SessionID + ".rep";

			Directory.CreateDirectory(_tempDir);

			_cmd = new OracleCommand();

			IOraConnection icon = (IOraConnection)_httpContext.Application["OracleConnectClass"];
            OracleConnection con = icon.GetUserConnection();
			_cmd.Connection = con;
		}
		
        /// <summary>
        /// Идентификаторы шаблонов для печати (DOC_SCHEME.ID)
        /// </summary>
        public IEnumerable<string> TemplateIds { get; set; }

	    /// <summary>
	    /// Номера договоров
	    /// </summary>
        public IEnumerable<long> ContractNumbers { get; set; }

	    /// <summary>
        /// Дополнительный параметр
        /// </summary>
        public long Adds
        {
            get
            {
                return _adds;
            }
            set
            {
                _adds = value;
            }
        }

        /// <summary>
        /// Набор ролей, разделенных запятой
        /// </summary>
        public string Roles { get; set; }

		public void SetEvent(long nEvent, long nLevel)
		{
			_nEvent = nEvent;
			_nLevel = nLevel;
		}

		/// <summary>
		/// Удалить временные файлы
		/// </summary>
		public void DeleteTempFiles()
		{
			Dispose();
		}

        /// <summary>
        /// Создать файл договора
        /// </summary>
        /// <returns>Путь к файлу отчета</returns>>
        public string GetReportFile()
        {
            //создаем пустой файл шаблона, в который будем закидывать несколько отдельных шаблонов
            if (_nEvent != -1 && _nLevel != -1)
                {
                    _cmd.CommandText = "ALTER SESSION SET EVENTS '" + _nEvent +
                        " trace name context forever, level " + _nLevel + "'";
                    _cmd.ExecuteNonQuery();
                    _nLevel = -1;
                    _nEvent = -1;
                }
                string[] roles = Roles.Split(',');
                var icon = (IOraConnection)_httpContext.Application["OracleConnectClass"];

                foreach (string role in roles)
                {
                    _cmd.CommandText = icon.GetSetRoleCommand(role);
                    _cmd.ExecuteNonQuery();
                }
                // вычитываем шаблоны

                var strTemplatesId = new StringBuilder();
                foreach (var templateId in TemplateIds)
                {
                    strTemplatesId.AppendFormat("'{0}',", templateId.ToUpper());
                }
                if (strTemplatesId.Length > 0)
                {
                    //убрали последнюю запятую
                    strTemplatesId.Length--;
                }
                //выбрать все шаблоны 
                _cmd.CommandText = string.Format(
                    "select ID, TEMPLATE from DOC_SCHEME " +
                    "where upper(ID) in ({0}) order by ID", strTemplatesId);
                var reader = _cmd.ExecuteReader();

                if (!reader.HasRows)	//нет строк шаблона
                {
                    throw new ReportException("Відсутні шаблони для друку.");
                }

                var reports = new List<Report>();
                while (reader.Read())
                {
                    if (reader.GetValue(1) == DBNull.Value)
                    {
                        throw new ApplicationException("Шаблон договору пустий!");
                    }
                    string reportId = reader["ID"].ToString();
                    string reportTemplate = reader["TEMPLATE"].ToString();
                    //создать список договоров для каждого клиента
                    foreach (var contractNumber in ContractNumbers)
                    {
                        reports.Add(new Report(reportId, reportTemplate, contractNumber));   
                    }   
                }

                //создаем экземпляр главного отчета, в который будем закидывать отдельные отчеты
                var mainReport = new MainReport();
                //создаём каждый из отчетов и добавляем его стили и тело в главный файл отчета
                foreach (var report in reports.OrderBy(report => report.ContractNumber))
                {
                    report.CreateFile();
                    mainReport.AddStyle(report);
                    mainReport.AddBody(report);
                }
                //добавляем всё остальное, что должно быть одинаково для всех отчетов из последнего отчета
                mainReport.AddHeader(reports.Last());
                mainReport.AddFooter(reports.Last());

            //скидываем всё в один файл
            return mainReport.CreateReportFile();
        }

        private class Report
	    {
            private string _filePath = _tempDir + "\\" + "report.rtf";	    // имя файла готового отчета

            private string _strDataFile = _tempDir + "\\" + "bindvar.dat";        // имя файла данных
            private string _strTempFile = _tempDir + "\\" + "raw.tmp";        // имя временного файла
            private string _strTemplateFile = _tempDir + "\\" + "ole_tmp.rtf";     // имя файла шаблона
            private string _strParamListFile = _tempDir + "\\" + "param.lst";    // имя файла списка параметров

            public Report(string id, string template, long contractNumber)
            {
                Id = id;
                Template = template;
                ContractNumber = contractNumber;

                //если первые байты шаблона равны 504B, то расматриваем шаблон как сжатый					
                IsCompressed = Template.StartsWith("504B");
            }
            
            /// <summary>
            /// ID шаблона
            /// </summary>
            public string Id { get; set; }
            /// <summary>
            /// Шаблон отчета без заполненных данных
            /// </summary>
            public string Template { get; set; }
            /// <summary>
            /// true-шаблон сжат, false-оригинал
            /// </summary>
            public bool IsCompressed { get; private set; }
            /// <summary>
            /// Номер договора (по нему шаблон заполняется конкретными данными)
            /// </summary>
            public long ContractNumber { get; private set; }

            /// <summary>
            /// Файл отчета во временной папке, заполняется после после создания отчета
            /// </summary>
            public string FilePath
            {
                get { return _filePath; }
            }

            /// <summary>
            /// Создать отчет и заполнить его содержимое
            /// </summary>
            public void CreateFile()
            {
                // пишем буфер в файл
                dumpToDisk();
                // генерим файл данных
                makeDataFile();
                // генерим финальный файл на основании шаблона и данных
                makeReport();
            }

            /// <summary>
            /// Дампим байтовый буфер на диск
            /// По ходу распаковуем, если надо
            /// </summary>
            private void dumpToDisk()
            {
                if (IsCompressed)
                {	// сначала распакуем
                    StreamWriter sw = File.CreateText(_strTempFile);
                    sw.Write(Template);
                    sw.Close();
                    // конвертируем в бинарный вид
                    toBin();
                    // распакуем архив
                    unpack();
                }
                else
                {	// пишем как есть
                    StreamWriter sw = File.CreateText(_strTemplateFile);
                    sw.Write(Template);
                    sw.Close();
                }
            }
            /// <summary>
            /// Подготавливаем файл данных
            /// </summary>
            private void makeDataFile()
            {
                // сначала подготовим файл-список требуемых параметров
                string strParams = "/parse " + _strTemplateFile + " " + _strParamListFile;

                ProcessStartInfo psinfo = new ProcessStartInfo("RtfConv.exe", strParams);
                psinfo.UseShellExecute = false;
                psinfo.RedirectStandardError = true;
                Process proc = Process.Start(psinfo);
                string strError = proc.StandardError.ReadToEnd();
                bool flagTerm = proc.WaitForExit(15000);
                if (!flagTerm)
                {
                    proc.Kill();
                    throw new ReportException(
                        "Процес 'RtfConv.exe' не завершив роботу у відведений час (15 сек).");
                }
                int nExitCode = proc.ExitCode;
                if (0 != nExitCode)
                {
                    throw new ReportException(
                        "Процес 'RtfConv.exe' аварійно завершив работу. Код " + nExitCode + "."
                        + "Опис коду повернення з потоку помилок: " + strError);

                }

                // читаем список параметров из файла, вычитываем параметры из БД
                // и пишем файл данных для отчета
                TextReader parfile = File.OpenText(_strParamListFile);

                // создаем файл данный
                FileStream datfile = File.Create(_strDataFile);
                try
                {
                    while (-1 != parfile.Peek())
                    {
                        string strParamName = parfile.ReadLine();

                        _cmd.CommandText = @"select f_doc_attr(:v_param,:v_nd) from dual";
                        _cmd.Parameters.Clear();
                        _cmd.Parameters.Add("v_param", OracleDbType.Varchar2,
                            strParamName, ParameterDirection.Input);
                        _cmd.Parameters.Add("v_nd", OracleDbType.Long,
                            ContractNumber, ParameterDirection.Input);
                        if (_adds != 0)
                        {
                            _cmd.CommandText = "select f_doc_attr(:v_param,:v_nd, :v_adds) from dual";
                            _cmd.Parameters.Add("v_adds", OracleDbType.Long, _adds, ParameterDirection.Input);
                        }

                        string strParamValue = "";
                        try
                        {
                            // Если запрос вернет NULL не генерируем ошибку,
                            // просто возвращаем пустую строку									
                            try
                            {
                                strParamValue = (string)_cmd.ExecuteScalar();
                            }
                            catch (InvalidCastException) { }
                        }
                        catch (OracleException oe)
                        {
                            if (oe.Message.IndexOf("ORA-01403: no data found") >= 0)
                                strParamValue = "{{" + strParamName + "}}";
                            else
                                throw;
                        }
                        // пишем в файл					
                        string strParamLine = "|0:" + strParamName + ":" + strParamValue + "\n";
                        byte[] bt = _encoding.GetBytes(strParamLine);
                        datfile.Write(bt, 0, bt.Length);
                    }
                }
                finally
                {
                    datfile.Close();
                    parfile.Close();
                }
            }
            /// <summary>
            /// Преобразование Hex --> Bin
            /// </summary>
            private void toBin()
            {
                Process proc = Process.Start("ToBin.exe", _strTempFile);
                bool flagTerm = proc.WaitForExit(15000);
                if (!flagTerm)
                {
                    proc.Kill();
                    throw new ReportException(
                        "Процес 'ToBin.exe' не завершив роботу у відведений час (15 сек).");
                }
            }
            /// <summary>
            /// Распаковка ZIP-архива
            /// </summary>
            private void unpack()
            {
                string args = "-extract -over=all -path=specify -nofix -silent -NoZipExtension "
                    + _strTempFile + " " + _tempDir;

                ProcessStartInfo psinfo = new ProcessStartInfo("pkzip25.exe", args);
                psinfo.UseShellExecute = false;
                psinfo.RedirectStandardError = true;
                Process proc = Process.Start(psinfo);
                string strError = proc.StandardError.ReadToEnd();
                bool flagTerm = proc.WaitForExit(15000);
                if (!flagTerm)
                {
                    proc.Kill();
                    throw new ReportException(
                        "Процес 'pkzip25.exe' не завершив роботу у відведений час (15 сек).");
                }
                int nExitCode = proc.ExitCode;
                if (0 != nExitCode)
                {
                    throw new ReportException(
                        "Процес 'pkzip25.exe' аварійно завершив роботу. Код " + nExitCode + "."
                        + "Опис коду повернення з потоку помилок: " + strError);
                }
            }

            private void makeReport()
            {
                string strParams = "/generate " + _strTemplateFile + " " + _strDataFile + " " + _filePath;
                ProcessStartInfo psinfo = new ProcessStartInfo("RtfConv.exe", strParams);
                psinfo.UseShellExecute = false;
                psinfo.RedirectStandardError = true;
                Process proc = Process.Start(psinfo);
                string strError = proc.StandardError.ReadToEnd();
                bool flagTerm = proc.WaitForExit(15000);
                if (!flagTerm)
                {
                    proc.Kill();
                    throw new ReportException(
                        "Процес 'RtfConv.exe' не завершив роботу у відведений час (15 сек).");
                }
                int nExitCode = proc.ExitCode;
                if (0 != nExitCode)
                {
                    throw new ReportException(
                        "Процес 'RtfConv.exe' аварійно завершив роботу. Код " + nExitCode + "."
                        + "Опис коду повернення з потоку помилок: " + strError);
                }
            }
	    }

	    private class MainReport
	    { 
            private StringBuilder _header = new StringBuilder();
            private StringBuilder _footer = new StringBuilder();
            private StringBuilder _styles = new StringBuilder();
            private StringBuilder _bodies = new StringBuilder();

            //список уже добавленных отчетов к главному отчету (чтобы не повторять одинаковые стили)
	        private List<string> _addedReports = new List<string>();

            /// <summary>
            /// Добавить заголовок в отчет по переданному отчету (до начала тега body)
            /// </summary>
            /// <param name="report"></param>
            public void AddHeader(Report report)
            {
                string reportContent = File.ReadAllText(report.FilePath, _encoding);

                int lastLinkIndex = reportContent.IndexOf(">", reportContent.LastIndexOf("<link"));
                _header.AppendLine(reportContent.Substring(0, lastLinkIndex + 1));

                //int endStyleIndex = reportContent.IndexOf(">", reportContent.LastIndexOf("</style"));
                //string afterStyleHeader = reportContent.Substring(endStyleIndex + 1, startBodyIndex - endStyleIndex - 1);

                _header.AppendLine(_styles.ToString());
                _header.AppendLine("</head>");

                int startBodyIndex = reportContent.IndexOf("<body");
                int endBodyIndex = reportContent.IndexOf(">", startBodyIndex);
                _header.AppendLine(reportContent.Substring(startBodyIndex, endBodyIndex - startBodyIndex + 1));
            }

	        public void AddStyle(Report report)
	        {
                //если стиль текущего шаблона отчета ещё не добавили
                if (!_addedReports.Contains(report.Id))
	            {
                    string reportContent = File.ReadAllText(report.FilePath, _encoding);
                    int searchStyleFromIndex = reportContent.IndexOf(">", reportContent.LastIndexOf("<link")) + 1;
	                while (reportContent.IndexOf("<style", searchStyleFromIndex) != -1)
	                {
	                    int beginOfStartStyleIndex = reportContent.IndexOf("<style", searchStyleFromIndex);
                        int endOfStartStyleIndex = reportContent.IndexOf(">", beginOfStartStyleIndex);
                        int endStyleIndex = reportContent.IndexOf("</style>", endOfStartStyleIndex);

	                    string reportStyle = reportContent.Substring(endOfStartStyleIndex + 1,
	                        endStyleIndex - endOfStartStyleIndex - 1);

	                    string htmlBeginCommentSymbols = "<!--\r\n ";
	                    for (int i = 0; i < reportStyle.Length; i++)
	                    {
	                        if (!htmlBeginCommentSymbols.Contains(reportStyle[i]))
	                        {
	                            reportStyle = reportStyle.Insert(i, string.Format(" .{0} ", report.Id));
	                            break;
	                        }
	                    }

	                    reportStyle = reportStyle.Remove(reportStyle.LastIndexOf("}"), 1);
	                    reportStyle = reportStyle.Replace("}", "}\r\n." + report.Id + " ");
	                    reportStyle = reportStyle.Replace(",", ", ." + report.Id + " ");

	                    string htmlEndCommentSymbols = "-->\r\n ";
	                    for (int i = reportStyle.Length - 1; i > 0; i--)
	                    {
	                        if (!htmlEndCommentSymbols.Contains(reportStyle[i]))
	                        {
	                            reportStyle = reportStyle.Insert(i + 1, "}");
	                            break;
	                        }
	                    }
	                    reportStyle = reportStyle.Replace("Section", "Section" + report.Id);

	                    
                        //добавили всё что было до текущего тега <style>
                        _styles.AppendLine(reportContent.Substring(searchStyleFromIndex, beginOfStartStyleIndex - searchStyleFromIndex));
	                    
                        _styles.AppendLine("<style>");
	                    _styles.AppendLine(reportStyle);
	                    _styles.AppendLine("</style>");

                        //будем продолжать искать следующий тег <style> с конца предыдущего
	                    searchStyleFromIndex = endStyleIndex + "</style>".Length;

	                    int nextStyleIndex = reportContent.IndexOf("<style", searchStyleFromIndex);
	                    if (nextStyleIndex == -1)
	                    {
	                        int endHeadIndex = reportContent.IndexOf("</head>");
                            _styles.AppendLine(reportContent.Substring(searchStyleFromIndex, endHeadIndex - searchStyleFromIndex));
                        }
	                }

	                _addedReports.Add(report.Id);
	            }
	        }

            /// <summary>
            /// Добавить тело в отчет по переданному отчету
            /// </summary>
            /// <param name="report"></param>a
            public void AddBody(Report report)
            {
                string reportContent = File.ReadAllText(report.FilePath, _encoding);

                int startBodyIndex = reportContent.IndexOf(">", reportContent.IndexOf("<body"));
                int endBodyIndex = reportContent.IndexOf("</body>");

                //удаляем часто до и после body, остаётся само тело отчета
                string reportBody = reportContent
                    .Remove(endBodyIndex, reportContent.Length - endBodyIndex - 1)
                    .Remove(0, startBodyIndex + 1);

                reportBody = reportBody.Replace("Section", "Section" + report.Id);

                //добавляем div с классом текущего отчета
                //тег <br> переноса строки добавляем для корректного разрыва страниц
                string reportDivBegin = string.Format("<div class = '{0}'>\r\n", report.Id);
                //если это не первый отчет добавляем разрыв страницы
                if (_bodies.Length > 0)
                {
                    reportDivBegin += "<br clear='all' style='page-break-before:always;mso-break-type:section-break'>";
                }
                string reportDivEnd = "</div>";

                _bodies.AppendLine(reportDivBegin);
                _bodies.AppendLine(reportBody);
                _bodies.AppendLine(reportDivEnd);
            }

            /// <summary>
            /// Добавить подпись в отчет по переданному отчету (после конца тега body)
            /// </summary>
            /// <param name="report"></param>
            public void AddFooter(Report report)
            {
                string reportContent = File.ReadAllText(report.FilePath, _encoding);
                int endBodyIndex = reportContent.IndexOf("</body>");

                string reportFooter = reportContent.Substring(endBodyIndex, reportContent.Length - endBodyIndex - 1);

                _footer.AppendLine(reportFooter);
            }

	        public string CreateReportFile()
	        {
                string filePath = Path.Combine(_tempDir, "MainReport.rtf");
	            using (var stream = new StreamWriter(filePath, false, _encoding))
	            {
                    //стили уже записаны в header
	                stream.WriteLine(_header.ToString());
                    stream.WriteLine(_bodies.ToString());
                    stream.WriteLine(_footer.ToString());
	            }
	            string zipFilePath = Path.Combine(_tempDir, "MainReport.zip");
                toZip(filePath, zipFilePath);
	            return zipFilePath;
	        }

            private void toZip(string fileToZip, string zipFile)
            {
                var zipOutputStream = new ZipOutputStream(File.Create(zipFile));

                ZipEntry zipEntry = new ZipEntry(Path.GetFileName(fileToZip));
                zipOutputStream.PutNextEntry(zipEntry);

                FileStream fs = File.OpenRead(fileToZip);
                byte[] buffer = new byte[fs.Length];
                fs.Read(buffer, 0, buffer.Length);

                zipOutputStream.Write(buffer, 0, buffer.Length);

                fs.Close();
                zipOutputStream.Finish();
                zipOutputStream.Close();
            }
	    }

	    public void Dispose()
	    {
            try
            {
                // удаляем временную директорию и все что внутри
                Directory.Delete(_tempDir, true);
            }
            catch
            {
            }
	    }
	}
}
