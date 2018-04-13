using System;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Web;
using Bars.Logger;
using Bars.ObjLayer.CbiRep;
using System.Xml;
using Bars.Classes;
using FastReport;
using FastReport.Web;
using FastReport.Data;
using FastReport.Preview;
using Oracle.DataAccess.Client;

namespace cbirep
{
    /// <summary>
    /// Summary description for CreateReport
    /// </summary>
    public class CreateReport : IDisposable
    {
        private string _rprDirPatch;
        private string _reportFilePath;

        private string _templatePatch;
        private OracleConnection _connection;
        private VCbirepRepresultsRecord _results;
        private VCbirepReplistRecord _cbirepRep;
        private VCbirepRepparamsRecord _cbirepRepParams;
        private ParsedReport _report;
        private Report _frReport;
        private MemoryStream _reportData;
        private string _connectionString;
        private decimal? _queryId;
        //txt- rtf
        private DirectoryInfo _tmpDirInfo;
        public CreateReport(decimal? queryId, string connectionString)
        {
            _queryId = queryId;
            _rprDirPatch = HttpContext.Current.Server.MapPath("/TEMPLATE.RPT");
            _templatePatch = Path.Combine(_rprDirPatch , CbirepRepParams.RPT_TEMPLATE);
            _connectionString = connectionString;
        }

        public CreateReport(string templatePatch, string connectionString)
        {
            _rprDirPatch = Path.GetDirectoryName(templatePatch);
            _templatePatch = templatePatch;
            _connectionString = connectionString;
        }

        public CreateReport(decimal? queryId, string templatePatch, string connectionString)
        {
            _queryId = queryId;
            _rprDirPatch = Path.GetDirectoryName(templatePatch);
            _templatePatch = templatePatch;
            _connectionString = connectionString;
        }

        # region Публичные свойства
        //txt - rtf
        public DirectoryInfo TmpDirInfo
        {
            get
            {
                if (_tmpDirInfo == null)
                {
                    String tempPath = Path.Combine(Path.GetTempPath(), "CbiReports");
                    _tmpDirInfo = new DirectoryInfo(tempPath);
                    if (!_tmpDirInfo.Exists) _tmpDirInfo.Create();
                }
                return _tmpDirInfo;
            }
        }
        public String TraceOn
        {
            get
            {
                return String.IsNullOrEmpty(ConfigurationManager.AppSettings["cbirep.TraceOn"]) ? ("false") : (ConfigurationManager.AppSettings["cbirep.TraceOn"]);
            }
        }
        public String TraceFileName
        {
            get
            {
                return (String.IsNullOrEmpty(ConfigurationManager.AppSettings["TraceFileName"]) ? Path.GetTempPath() + "rep_gen.trc" : ConfigurationManager.AppSettings["TraceFileName"]);
            }
        }
        public String ApplFilePath
        {
            get
            {
                return "rep_gen.exe";
            }
        }
        public String ExeFileArgs
        {
            get
            {
                return String.Format("{0} {1} {2} {3} {4} {5} {6}", DataBase, Results.SESSION_ID, Report.FileTypeCode, Path.Combine(TmpDirInfo.FullName, Report.FileNameFull), _rprDirPatch, TraceOn, TraceFileName);
            }
        }
        public String DataBase
        {
            get
            {
                //return ConfigurationManager.AppSettings["DBConnect.DataSource"];
                return Connection.DataSource;
            }
        }
        public Int32 AppTimeOut
        {
            get
            {
                return Int32.Parse(ConfigurationManager.AppSettings["cbirep.AppTimeOut"]) * 1000 + 5000;
            }
        }
        //fastreport
        public OracleConnection Connection
        {
            get { return _connection ?? (_connection = OraConnector.Handler.IOraConnection.GetUserConnection()); }
        }
        public string ConnectionString
        {
            get { return _connectionString; }
            set { _connectionString = value; }
        }
        public string TemplatePatch
        {
            get { return _templatePatch; }
            set { _templatePatch = value; }
        }
        public Decimal? QueryId
        {
            get
            {
                return _queryId;
            }
        }

        public Report FrReport
        {
            get { return _frReport ?? (_frReport = new Report()); }
        }
        public VCbirepRepresultsRecord Results
        {
            get
            {
                return _results ?? 
                    (_results = (new VCbirepRepresults()).SelectCbirepRepresult(QueryId)); 
            }
        }
        public VCbirepReplistRecord CbirepRep
        {
            get
            {
                return _cbirepRep ?? 
                    (_cbirepRep = (new VCbirepReplist()).SelectCbirepRep(Results.REP_ID)); 
            }
        }
        public VCbirepRepparamsRecord CbirepRepParams
        {
            get 
            {
                return _cbirepRepParams ?? 
                    (_cbirepRepParams = (new VCbirepRepparams()).FindRepByRepID(Results.REP_ID));
            }
        }
        public ParsedReport Report
        {
            get
            {
                if (_report == null)
                {
                    _report = new ParsedReport(CbirepRepParams);
                    XmlDocument doc = new XmlDocument();
                    doc.LoadXml(Results.XML_PARAMS);
                    _report.FillValues(doc);
                }
                return _report;
            }
        }
        public String GeneratedFilePath
        {
            get
            {
                if (string.IsNullOrEmpty(_reportFilePath))
                {
                    var fileStram = new FileStream(Path.Combine(TmpDirInfo.FullName, Report.FileNameFull), FileMode.Create);
                    var array = ReportData.ToArray();
                    fileStram.Write(array, 0, array.Length);
                    fileStram.Close();
                    _reportFilePath = Path.Combine(TmpDirInfo.FullName, Report.FileNameFull);
                }
                return _reportFilePath;
            }
        }

        public MemoryStream ReportData
        {
            get
            {
                if (_reportData == null)
                {
                    OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
                    OracleCommand cmd = Connection.CreateCommand();
                    try
                    {
                        cmd.CommandText = "select * from v_cbirep_queries_data where queries_id = :p_query_id";
                        cmd.Parameters.Add("p_query_id", OracleDbType.Decimal, QueryId, ParameterDirection.Input);
                        var riader = cmd.ExecuteReader();
                        if (riader.Read())
                        {
                            _reportData = new MemoryStream((byte[])riader[1]);
                        }
                    }
                    finally
                    {
                        cmd.Dispose();
                        con.Close();
                        con.Dispose();
                    }
                }
                return _reportData;
            }
            set
            { 
                _reportData = value;
            }
        }
        public Boolean CheckQrpAccess(String qrpFileName)
        {
            return File.Exists(Path.Combine(_rprDirPatch,qrpFileName));
        }
        # endregion

        public void Prepared()
        {
            if (QueryId == null || CbirepRepParams.FORM == "frm_FastReport")
            {
                FastReport.Utils.RegisteredObjects.AddConnection(typeof(OracleDataConnection));
                FrReport.Load(_templatePatch);
                FrReport.StartReport += StartReport;
                FrReport.Prepare();
                _reportData = new MemoryStream();
                FrReport.SavePrepared(ReportData);
            }
            else if (CbirepRepParams.FORM == "frm_UniReport")
            {
                _reportFilePath = GenerateReportFile();
                _reportData = new MemoryStream();
                using (var fileStream = new FileStream(_reportFilePath, FileMode.Open))
                {
                    byte[] byteArray = new byte[fileStream.Length];
                    fileStream.Read(byteArray, 0, byteArray.Length);
                    ReportData.Write(byteArray, 0, byteArray.Length);
                }
            }
        }

        public void ClearTempFiles()
        {
            // удаляем файлы ненужных отчетов
            foreach (FileInfo t in TmpDirInfo.GetFiles())
            {
                try
                {
                     File.Delete(t.FullName);
                }
                catch (IOException)
                {
                    // пропускаем занятые файлы
                }
            }
        }

        public String GenerateReportFile()
        {
            ClearTempFiles();

            //-- если работаем в режиме отладки, то пишем строку параметров в logger
            DBLogger.WriteDebugMessage("BarsWeb.CbiRep : arguments line = " + ApplFilePath + " " + ExeFileArgs,
                "BarsWeb.CbiRep", HttpContext.Current);

            //-- запуск процесса формирования отчета
            ProcessStartInfo procInf = new ProcessStartInfo(ApplFilePath, ExeFileArgs)
            {
                UseShellExecute = false,
                RedirectStandardError = true,
                CreateNoWindow = true
            };

            Process proc = Process.Start(procInf);
            if (proc == null)
            {
                throw new Exception(string.Format("Процес {0} не знайдений.", ApplFilePath));
            }
            bool flagTerm;
            try
            {
                flagTerm = proc.WaitForExit(AppTimeOut);
            }
            catch
            {
                proc.Kill();
                var error = string.Format("Перевищено ліміт часу на формування звіту (rep_id={0}).<br> " +
                                          "Спробуйте конкретизувати параметри звіту.", Results.REP_ID);
                SetStatus("ERROR", error);
                throw new Exception(error);
            }
            if (!flagTerm)
            {
                proc.Kill();
                var error =
                    string.Format("Перевищено ліміт часу на формування звіту (rep_id={0},timeout={1}).<br> " +
                                  "Спробуйте конкретизувати параметри звіту.", Results.REP_ID, (AppTimeOut/1000));
                SetStatus("ERROR", error);
                throw new Exception(error);
            }

            string strError = proc.StandardError.ReadToEnd();
            int nExitCode = proc.ExitCode;
            if (0 != nExitCode)
            {
                var error = string.Format("Процесс {0} аварийно завершил работу. Код {1}." +
                                          "Описание кода возврата из потока ошибок: {2}", ApplFilePath, nExitCode,
                    strError);
                SetStatus("ERROR", error);
                throw new Exception(error);
            }
            proc.Close();

            //-- если файл не сформирован, то создаем пустой
            if (!File.Exists(Path.Combine(TmpDirInfo.FullName, Report.FileNameFull)))
            {
                using (
                    StreamWriter sw = new StreamWriter(Path.Combine(TmpDirInfo.FullName, Report.FileNameFull), false,
                        System.Text.Encoding.GetEncoding("windows-1251")))
                {
                    sw.WriteLine("Данні пусті! Перевірте правильність параметрів.");
                }
            }

            return Path.Combine(TmpDirInfo.FullName, Report.FileNameFull);
        }

        public void SetStatus(string status, string comm)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = @"begin rs.set_status(:p_queries_id,:p_staus_id,:p_comm);end;";
                cmd.Parameters.Add("p_queries_id", OracleDbType.Decimal, QueryId, ParameterDirection.Input);
                cmd.Parameters.Add("p_staus_id", OracleDbType.Varchar2, status, ParameterDirection.Input);
                cmd.Parameters.Add("p_comm", OracleDbType.Varchar2, comm, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }
        }

        public void SaveToBase()
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            try
            {
                cmd.CommandText = @"begin rs.set_report_file(:p_queries_id,:p_file_data,:p_file_type);end;";
                cmd.Parameters.Add("p_queries_id", OracleDbType.Decimal, QueryId, ParameterDirection.Input);
                cmd.Parameters.Add("p_file_data", OracleDbType.Blob, ReportData.ToArray(), ParameterDirection.Input);
                cmd.Parameters.Add("p_file_type", OracleDbType.Varchar2, "", ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                con.Close();
                con.Dispose();
            }
        }
        public void Show(PreviewControl previewControl)
        {
            switch (CbirepRepParams.FORM)
            {
                case "frm_FastReport":
                    FrReport.Preview = previewControl;
                    ReportData.Position = 0;
                    FrReport.LoadPrepared(ReportData);
                    FrReport.ShowPrepared();
                    break;
                case "frm_UniReport":
                    previewControl.Dispose();
                    Process.Start(GeneratedFilePath);
                    break;
            }
        }
        public void WebPrepared(WebReport report)
        {
            if (ReportData == null)
            {
                Prepared();
                SaveToBase();
            }
            report.StartReport += ViewReport;
            report.Prepare();
        }

        # region Приватные события
        private void ViewReport(object sender, EventArgs e)
        {
            var report = (WebReport)sender;
            if (ReportData != null)
            {
                ReportData.Position = 0;
                report.Report.LoadPrepared(ReportData);
                report.ReportDone = true;
            }
        }
        private void StartReport(object sender, EventArgs e)
        {
            FrReport.Dictionary.Connections[0].ConnectionString = ConnectionString;
            // установка параметра session_id
            if (QueryId != null)
            {
                FrReport.SetParameterValue("session_id", Results.SESSION_ID);
                // установка остальных параметров
                foreach (ReportParam p in Report.Params)
                {
                    Object value = p.ID.StartsWith("sFdat")
                        ? (Object) p.DefaultValueDate
                        : p.DefaultValueString;
                    FrReport.SetParameterValue(p.ID, value);
                }
            }
        }
        # endregion

        public void Dispose()
        {
            if (_connection != null)
            {
                _connection.Close();
                _connection.Dispose();
            }
            if (_frReport != null) _frReport.Dispose();

            if (_reportData != null)
            {
                //_reportData.Dispose();
            }
        }
    }
}
