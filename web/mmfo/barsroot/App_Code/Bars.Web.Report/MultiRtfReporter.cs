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
    public class MultiPrintRtfReporter
    {
        private readonly HttpContext _httpContext;
        private readonly string _tempDir;
        private long _adds;               //�������� ADDS ��� ���������
        private long _nEvent = -1;	             //��� ������� ��� ���������� ������ Oracle
        private long _nLevel = -1;	             //������� ����������� ������� ���������� ������ Oracle
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
        }

        public IEnumerable<string> TemplateIds { get; set; }
        public IEnumerable<long> ContractNumbers { get; set; }
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
        public string Roles { get; set; }
        public void SetEvent(long nEvent, long nLevel)
        {
            _nEvent = nEvent;
            _nLevel = nLevel;
        }
        public void DeleteTempFiles()
        {
            Directory.Delete(_tempDir, true);
        }
        public string GetReportFile()
        {
            var mainReport = new MainReport(_tempDir);
            OracleCommand cmd = new OracleCommand();
            IOraConnection icon = (IOraConnection)_httpContext.Application["OracleConnectClass"];
            OracleConnection con = icon.GetUserConnection();
            cmd.Connection = con;
            //������� ������ ���� �������, � ������� ����� ���������� ��������� ��������� ��������
            try
            {
                if (_nEvent != -1 && _nLevel != -1)
                {
                    cmd.CommandText = "ALTER SESSION SET EVENTS '" + _nEvent +
                                      " trace name context forever, level " + _nLevel + "'";
                    cmd.ExecuteNonQuery();
                    _nLevel = -1;
                    _nEvent = -1;
                }
                string[] roles = Roles.Split(',');

                foreach (string role in roles)
                {
                    cmd.CommandText = icon.GetSetRoleCommand(role);
                    cmd.ExecuteNonQuery();
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
                cmd.CommandText = string.Format(
                    "select ID, TEMPLATE from DOC_SCHEME " +
                    "where upper(ID) in ({0}) order by ID", strTemplatesId);
                var reader = cmd.ExecuteReader();

                if (!reader.HasRows) //��� ����� �������
                {
                    throw new ReportException("³����� ������� ��� �����.");
                }

                var reports = new List<Report>();
                try
                {
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
                            reports.Add(new Report(reportId, reportTemplate, contractNumber, _httpContext, _tempDir,
                                _adds));
                        }
                    }
                }
                finally
                {
                    reader.Close();
                    reader.Dispose();
                }

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
            }
            finally
            {
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }
            //��������� �� � ���� ����
            return mainReport.CreateReportFile();
        }
    }


    internal class Report
    {
        private string _filePath;
        private string _strDataFile;
        private string _strTempFile;
        private string _strTemplateFile;
        private string _strParamListFile;
        private string _tempDir;
        private HttpContext _httpContext;
        private long _adds;
        private readonly Encoding _encoding = Encoding.GetEncoding(1251);
        public Report(string id, string template, long contractNumber, HttpContext httpContext, string tempDir, long adds)
        {
            Id = id;
            Template = template;
            ContractNumber = contractNumber;
            //���� ������ ����� ������� ����� 504B, �� ������������ ������ ��� ������					
            IsCompressed = Template.StartsWith("504B");
            _httpContext = httpContext;
            _filePath = tempDir + "\\" + "report.rtf";
            _strDataFile = tempDir + "\\" + "bindvar.dat";
            _strTempFile = tempDir + "\\" + "raw.tmp";
            _strTemplateFile = tempDir + "\\" + "ole_tmp.rtf";
            _strParamListFile = tempDir + "\\" + "param.lst";
            _adds = adds;
            _tempDir = tempDir;
        }

        public string Id { get; set; }
        private string Template { get; set; }
        private bool IsCompressed { get; set; }
        public long ContractNumber { get; private set; }

        public string FilePath
        {
            get { return _filePath; }
        }

        public void CreateFile()
        {
            DumpToDisk();
            MakeDataFile();
            MakeReport();
        }

        private void DumpToDisk()
        {
            if (IsCompressed)
            {
                StreamWriter sw = File.CreateText(_strTempFile);
                sw.Write(Template);
                sw.Close();
                ToBin();
                Unpack();
            }
            else
            {
                StreamWriter sw = File.CreateText(_strTemplateFile);
                sw.Write(Template);
                sw.Close();
            }
        }

        private void MakeDataFile()
        {
            OracleCommand cmd = new OracleCommand();
            IOraConnection icon = (IOraConnection)_httpContext.Application["OracleConnectClass"];
            OracleConnection con = icon.GetUserConnection();
            cmd.Connection = con;
            string strParams = "/parse " + _strTemplateFile + " " + _strParamListFile;

            ProcessStartInfo psinfo = new ProcessStartInfo("RtfConv.exe", strParams);
            psinfo.UseShellExecute = false;
            psinfo.RedirectStandardError = true;
            Process proc = Process.Start(psinfo);
            if (proc != null)
            {
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
            TextReader parfile = File.OpenText(_strParamListFile);
            FileStream datfile = File.Create(_strDataFile);
            try
            {
                while (-1 != parfile.Peek())
                {
                    string strParamName = parfile.ReadLine();
                    cmd.CommandText = @"select f_doc_attr(:v_param,:v_nd) from dual";
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add("v_param", OracleDbType.Varchar2,
                        strParamName, ParameterDirection.Input);
                    cmd.Parameters.Add("v_nd", OracleDbType.Long,
                        ContractNumber, ParameterDirection.Input);
                    if (_adds != 0)
                    {
                        cmd.CommandText = "select f_doc_attr(:v_param,:v_nd, :v_adds) from dual";
                        cmd.Parameters.Add("v_adds", OracleDbType.Long, _adds, ParameterDirection.Input);
                    }
                    string strParamValue = "";
                    try
                    {
                        try
                        {
                            strParamValue = (string)cmd.ExecuteScalar();
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
                    string strParamLine = "|0:" + strParamName + ":" + strParamValue + "\n";
                    byte[] bt = _encoding.GetBytes(strParamLine);
                    datfile.Write(bt, 0, bt.Length);
                }
            }
            finally
            {
                datfile.Close();
                parfile.Close();
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }
        }
        private void ToBin()
        {
            Process proc = Process.Start("ToBin.exe", _strTempFile);
            bool flagTerm = proc != null && proc.WaitForExit(15000);
            if (!flagTerm)
            {
                if (proc != null) proc.Kill();
                throw new ReportException(
                    "������ 'ToBin.exe' �� �������� ������ � ��������� ��� (15 ���).");
            }
        }
        private void Unpack()
        {
            string args = "-extract -over=all -path=specify -nofix -silent -NoZipExtension "
                + _strTempFile + " " + _tempDir;

            ProcessStartInfo psinfo = new ProcessStartInfo("pkzip25.exe", args)
            {
                UseShellExecute = false,
                RedirectStandardError = true
            };
            Process proc = Process.Start(psinfo);
            if (proc != null)
            {
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
        }
        private void MakeReport()
        {
            string strParams = "/generate " + _strTemplateFile + " " + _strDataFile + " " + _filePath;
            ProcessStartInfo psinfo = new ProcessStartInfo("RtfConv.exe", strParams);
            psinfo.UseShellExecute = false;
            psinfo.RedirectStandardError = true;
            Process proc = Process.Start(psinfo);
            if (proc != null)
            {
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
    }

    internal class MainReport
    {
        private readonly StringBuilder _header = new StringBuilder();
        private readonly StringBuilder _footer = new StringBuilder();
        private readonly StringBuilder _styles = new StringBuilder();
        private readonly StringBuilder _bodies = new StringBuilder();
        private readonly List<string> _addedReports = new List<string>();
        private readonly Encoding _encoding = Encoding.GetEncoding(1251);
        private readonly string _tempDir;
        public MainReport(string tempDir)
        {
            _tempDir = tempDir;
        }
        public void AddHeader(Report report)
        {
            string reportContent = File.ReadAllText(report.FilePath, _encoding);

            int lastLinkIndex = reportContent.IndexOf(">", reportContent.LastIndexOf("<link"));
            _header.AppendLine(reportContent.Substring(0, lastLinkIndex + 1));

            _header.AppendLine(_styles.ToString());
            _header.AppendLine("</head>");

            int startBodyIndex = reportContent.IndexOf("<body");
            int endBodyIndex = reportContent.IndexOf(">", startBodyIndex);
            _header.AppendLine(reportContent.Substring(startBodyIndex, endBodyIndex - startBodyIndex + 1));
        }
        public void AddStyle(Report report)
        {
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

                    const string htmlBeginCommentSymbols = "<!--\r\n ";
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

                    const string htmlEndCommentSymbols = "-->\r\n ";
                    for (int i = reportStyle.Length - 1; i > 0; i--)
                    {
                        if (!htmlEndCommentSymbols.Contains(reportStyle[i]))
                        {
                            reportStyle = reportStyle.Insert(i + 1, "}");
                            break;
                        }
                    }
                    reportStyle = reportStyle.Replace("Section", "Section" + report.Id);

                    _styles.AppendLine(reportContent.Substring(searchStyleFromIndex, beginOfStartStyleIndex - searchStyleFromIndex));
                    _styles.AppendLine("<style>");
                    _styles.AppendLine(reportStyle);
                    _styles.AppendLine("</style>");
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
        public void AddBody(Report report)
        {
            string reportContent = File.ReadAllText(report.FilePath, _encoding);

            int startBodyIndex = reportContent.IndexOf(">", reportContent.IndexOf("<body"));
            int endBodyIndex = reportContent.IndexOf("</body>");

            string reportBody = reportContent
                .Remove(endBodyIndex, reportContent.Length - endBodyIndex - 1)
                .Remove(0, startBodyIndex + 1);

            reportBody = reportBody.Replace("Section", "Section" + report.Id);

            string reportDivBegin = string.Format("<div class = '{0}'>\r\n", report.Id);
            if (_bodies.Length > 0)
            {
                reportDivBegin += "<br clear='all' style='page-break-before:always;mso-break-type:section-break'>";
            }
            const string reportDivEnd = "</div>";

            _bodies.AppendLine(reportDivBegin);
            _bodies.AppendLine(reportBody);
            _bodies.AppendLine(reportDivEnd);
        }
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
                stream.WriteLine(_header.ToString());
                stream.WriteLine(_bodies.ToString());
                stream.WriteLine(_footer.ToString());
            }
            string zipFilePath = Path.Combine(_tempDir, "MainReport.zip");
            ToZip(filePath, zipFilePath);
            return zipFilePath;
        }
        private void ToZip(string fileToZip, string zipFile)
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

}
