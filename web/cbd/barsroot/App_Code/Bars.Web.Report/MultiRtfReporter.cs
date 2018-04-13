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
	/// ����� ��� �������������� �������� ��������� ��� ������, 
	/// ���������� ��������� � ����� ����� (������������� RtfReporter).
	/// </summary>
    public class MultiPrintRtfReporter : IDisposable
	{
		private HttpContext _httpContext;	     //������� HTTP ��������

        private static string _tempDir;	         //��������� ����������

        private static long _adds;               //�������� ADDS ��� ���������

        private static OracleCommand _cmd;

		private long _nEvent = -1;	             //��� ������� ��� ���������� ������ Oracle
	    private long _nLevel = -1;	             //������� ����������� ������� ���������� ������ Oracle

        private static Encoding _encoding = Encoding.GetEncoding(1251);

        /// <summary>
        /// ������������� ������ ���������
        /// </summary>
        /// <param name="context">������� http ��������</param>
        public MultiPrintRtfReporter(HttpContext context)
        {
            _httpContext = context;

			//-- ���� � ���� ����� ������, �� �� ���� ������� ������� �������� ���� 
			//-- ���� ��� �������� �������� �� ����� (�������� tvSukhov)
			string strFilePrefix = Path.GetTempPath().Replace("Documents and Settings", "DOCUME~1").Replace("Local Settings", "LOCALS~1");

            if ('\\' != strFilePrefix[strFilePrefix.Length - 1])
            {
                strFilePrefix += "\\";
            }

            if (_httpContext.Session == null)
            {
                throw new ApplicationException("�� ������������ ����!");
            }

            _tempDir = strFilePrefix + _httpContext.Session.SessionID + ".rep";

			Directory.CreateDirectory(_tempDir);

			_cmd = new OracleCommand();

			IOraConnection icon = (IOraConnection)_httpContext.Application["OracleConnectClass"];
            OracleConnection con = icon.GetUserConnection();
			_cmd.Connection = con;
		}
		
        /// <summary>
        /// �������������� �������� ��� ������ (DOC_SCHEME.ID)
        /// </summary>
        public IEnumerable<string> TemplateIds { get; set; }

	    /// <summary>
	    /// ������ ���������
	    /// </summary>
        public IEnumerable<long> ContractNumbers { get; set; }

	    /// <summary>
        /// �������������� ��������
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
        /// ����� �����, ����������� �������
        /// </summary>
        public string Roles { get; set; }

		public void SetEvent(long nEvent, long nLevel)
		{
			_nEvent = nEvent;
			_nLevel = nLevel;
		}

		/// <summary>
		/// ������� ��������� �����
		/// </summary>
		public void DeleteTempFiles()
		{
			Dispose();
		}

        /// <summary>
        /// ������� ���� ��������
        /// </summary>
        /// <returns>���� � ����� ������</returns>>
        public string GetReportFile()
        {
            //������� ������ ���� �������, � ������� ����� ���������� ��������� ��������� ��������
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
                // ���������� �������

                var strTemplatesId = new StringBuilder();
                foreach (var templateId in TemplateIds)
                {
                    strTemplatesId.AppendFormat("'{0}',", templateId.ToUpper());
                }
                if (strTemplatesId.Length > 0)
                {
                    //������ ��������� �������
                    strTemplatesId.Length--;
                }
                //������� ��� ������� 
                _cmd.CommandText = string.Format(
                    "select ID, TEMPLATE from DOC_SCHEME " +
                    "where upper(ID) in ({0}) order by ID", strTemplatesId);
                var reader = _cmd.ExecuteReader();

                if (!reader.HasRows)	//��� ����� �������
                {
                    throw new ReportException("³����� ������� ��� �����.");
                }

                var reports = new List<Report>();
                while (reader.Read())
                {
                    if (reader.GetValue(1) == DBNull.Value)
                    {
                        throw new ApplicationException("������ �������� ������!");
                    }
                    string reportId = reader["ID"].ToString();
                    string reportTemplate = reader["TEMPLATE"].ToString();
                    //������� ������ ��������� ��� ������� �������
                    foreach (var contractNumber in ContractNumbers)
                    {
                        reports.Add(new Report(reportId, reportTemplate, contractNumber));   
                    }   
                }

                //������� ��������� �������� ������, � ������� ����� ���������� ��������� ������
                var mainReport = new MainReport();
                //������ ������ �� ������� � ��������� ��� ����� � ���� � ������� ���� ������
                foreach (var report in reports.OrderBy(report => report.ContractNumber))
                {
                    report.CreateFile();
                    mainReport.AddStyle(report);
                    mainReport.AddBody(report);
                }
                //��������� �� ���������, ��� ������ ���� ��������� ��� ���� ������� �� ���������� ������
                mainReport.AddHeader(reports.Last());
                mainReport.AddFooter(reports.Last());

            //��������� �� � ���� ����
            return mainReport.CreateReportFile();
        }

        private class Report
	    {
            private string _filePath = _tempDir + "\\" + "report.rtf";	    // ��� ����� �������� ������

            private string _strDataFile = _tempDir + "\\" + "bindvar.dat";        // ��� ����� ������
            private string _strTempFile = _tempDir + "\\" + "raw.tmp";        // ��� ���������� �����
            private string _strTemplateFile = _tempDir + "\\" + "ole_tmp.rtf";     // ��� ����� �������
            private string _strParamListFile = _tempDir + "\\" + "param.lst";    // ��� ����� ������ ����������

            public Report(string id, string template, long contractNumber)
            {
                Id = id;
                Template = template;
                ContractNumber = contractNumber;

                //���� ������ ����� ������� ����� 504B, �� ������������ ������ ��� ������					
                IsCompressed = Template.StartsWith("504B");
            }
            
            /// <summary>
            /// ID �������
            /// </summary>
            public string Id { get; set; }
            /// <summary>
            /// ������ ������ ��� ����������� ������
            /// </summary>
            public string Template { get; set; }
            /// <summary>
            /// true-������ ����, false-��������
            /// </summary>
            public bool IsCompressed { get; private set; }
            /// <summary>
            /// ����� �������� (�� ���� ������ ����������� ����������� �������)
            /// </summary>
            public long ContractNumber { get; private set; }

            /// <summary>
            /// ���� ������ �� ��������� �����, ����������� ����� ����� �������� ������
            /// </summary>
            public string FilePath
            {
                get { return _filePath; }
            }

            /// <summary>
            /// ������� ����� � ��������� ��� ����������
            /// </summary>
            public void CreateFile()
            {
                // ����� ����� � ����
                dumpToDisk();
                // ������� ���� ������
                makeDataFile();
                // ������� ��������� ���� �� ��������� ������� � ������
                makeReport();
            }

            /// <summary>
            /// ������ �������� ����� �� ����
            /// �� ���� �����������, ���� ����
            /// </summary>
            private void dumpToDisk()
            {
                if (IsCompressed)
                {	// ������� ���������
                    StreamWriter sw = File.CreateText(_strTempFile);
                    sw.Write(Template);
                    sw.Close();
                    // ������������ � �������� ���
                    toBin();
                    // ��������� �����
                    unpack();
                }
                else
                {	// ����� ��� ����
                    StreamWriter sw = File.CreateText(_strTemplateFile);
                    sw.Write(Template);
                    sw.Close();
                }
            }
            /// <summary>
            /// �������������� ���� ������
            /// </summary>
            private void makeDataFile()
            {
                // ������� ���������� ����-������ ��������� ����������
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
                        "������ 'RtfConv.exe' �� �������� ������ � ��������� ��� (15 ���).");
                }
                int nExitCode = proc.ExitCode;
                if (0 != nExitCode)
                {
                    throw new ReportException(
                        "������ 'RtfConv.exe' ������� �������� ������. ��� " + nExitCode + "."
                        + "���� ���� ���������� � ������ �������: " + strError);

                }

                // ������ ������ ���������� �� �����, ���������� ��������� �� ��
                // � ����� ���� ������ ��� ������
                TextReader parfile = File.OpenText(_strParamListFile);

                // ������� ���� ������
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
                            // ���� ������ ������ NULL �� ���������� ������,
                            // ������ ���������� ������ ������									
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
                        // ����� � ����					
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
            /// �������������� Hex --> Bin
            /// </summary>
            private void toBin()
            {
                Process proc = Process.Start("ToBin.exe", _strTempFile);
                bool flagTerm = proc.WaitForExit(15000);
                if (!flagTerm)
                {
                    proc.Kill();
                    throw new ReportException(
                        "������ 'ToBin.exe' �� �������� ������ � ��������� ��� (15 ���).");
                }
            }
            /// <summary>
            /// ���������� ZIP-������
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
                        "������ 'pkzip25.exe' �� �������� ������ � ��������� ��� (15 ���).");
                }
                int nExitCode = proc.ExitCode;
                if (0 != nExitCode)
                {
                    throw new ReportException(
                        "������ 'pkzip25.exe' ������� �������� ������. ��� " + nExitCode + "."
                        + "���� ���� ���������� � ������ �������: " + strError);
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
                        "������ 'RtfConv.exe' �� �������� ������ � ��������� ��� (15 ���).");
                }
                int nExitCode = proc.ExitCode;
                if (0 != nExitCode)
                {
                    throw new ReportException(
                        "������ 'RtfConv.exe' ������� �������� ������. ��� " + nExitCode + "."
                        + "���� ���� ���������� � ������ �������: " + strError);
                }
            }
	    }

	    private class MainReport
	    { 
            private StringBuilder _header = new StringBuilder();
            private StringBuilder _footer = new StringBuilder();
            private StringBuilder _styles = new StringBuilder();
            private StringBuilder _bodies = new StringBuilder();

            //������ ��� ����������� ������� � �������� ������ (����� �� ��������� ���������� �����)
	        private List<string> _addedReports = new List<string>();

            /// <summary>
            /// �������� ��������� � ����� �� ����������� ������ (�� ������ ���� body)
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
                //���� ����� �������� ������� ������ ��� �� ��������
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

	                    
                        //�������� �� ��� ���� �� �������� ���� <style>
                        _styles.AppendLine(reportContent.Substring(searchStyleFromIndex, beginOfStartStyleIndex - searchStyleFromIndex));
	                    
                        _styles.AppendLine("<style>");
	                    _styles.AppendLine(reportStyle);
	                    _styles.AppendLine("</style>");

                        //����� ���������� ������ ��������� ��� <style> � ����� �����������
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
            /// �������� ���� � ����� �� ����������� ������
            /// </summary>
            /// <param name="report"></param>a
            public void AddBody(Report report)
            {
                string reportContent = File.ReadAllText(report.FilePath, _encoding);

                int startBodyIndex = reportContent.IndexOf(">", reportContent.IndexOf("<body"));
                int endBodyIndex = reportContent.IndexOf("</body>");

                //������� ����� �� � ����� body, ������� ���� ���� ������
                string reportBody = reportContent
                    .Remove(endBodyIndex, reportContent.Length - endBodyIndex - 1)
                    .Remove(0, startBodyIndex + 1);

                reportBody = reportBody.Replace("Section", "Section" + report.Id);

                //��������� div � ������� �������� ������
                //��� <br> �������� ������ ��������� ��� ����������� ������� �������
                string reportDivBegin = string.Format("<div class = '{0}'>\r\n", report.Id);
                //���� ��� �� ������ ����� ��������� ������ ��������
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
            /// �������� ������� � ����� �� ����������� ������ (����� ����� ���� body)
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
                    //����� ��� �������� � header
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
                // ������� ��������� ���������� � ��� ��� ������
                Directory.Delete(_tempDir, true);
            }
            catch
            {
            }
	    }
	}
}
