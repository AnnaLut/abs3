using System;
using System.Data;
using System.Configuration;
using System.Data.Common;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Diagnostics;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

using Bars.Classes;
using Bars.Exception;

using Microsoft.Win32;

namespace Bars.ObjLayer.CbiRep
{
    public enum ParamTypes
    {
        Date,
        String,
        Reference
    }
    public struct ReferenceParams
    {
        /// <summary>
        /// Идентификатор таблицы справочника
        /// </summary>
        public Decimal? TAB_ID;
        /// <summary>
        /// Ключевое поле
        /// </summary>
        public String KEY_FIELD;
        /// <summary>
        /// Поле семантики
        /// </summary>
        public String SEMANTIC_FIELD;
        /// <summary>
        /// Поля для отображения (перечисление через запятую)
        /// </summary>
        public String SHOW_FIELDS;
        /// <summary>
        /// Условие отбора (включая слово where)
        /// </summary>
        public String WHERE_CLAUSE;
    }

    public class ParsedReport
    {
        # region Константы
        public const String XMLVersion = "1.0";
        public const String XMLEncoding = "UTF-8";
        public const String DateFormat = "dd.MM.yyyy";
        public const String DateTimeFormat = "dd.MM.yyyy HH:mm:ss";
        public const String NumberFormat = "######################0.00##";
        public const String DecimalSeparator = ".";
        # endregion

        # region Приватные свойства
        private VCbirepRepparamsRecord _CbirepRepParams;
        private List<ReportParam> _Params = new List<ReportParam>();

        public String _FileNameBase;
        public String _FileNameFull;
        # endregion

        # region Публичные свойства
        public List<ReportParam> Params
        {
            get
            {
                if (_CbirepRepParams.NDAT == 1)
                    FindByID("sFdat1").Name = "На дату";

                return _Params;
            }
        }
        public Int16 FileTypeCode
        {
            get
            {
                return Convert.ToInt16(this._CbirepRepParams.PARAM.Split(',')[1]);
            }
        }
        public String FileTypeExt
        {
            get
            {
                switch (FileTypeCode)
                {
                    case 3: return "txt";
                    default: return "rtf";
                }
            }
        }
        public String FileNameBase
        {
            get
            {
                if (String.IsNullOrEmpty(_FileNameBase))
                {
                    _FileNameBase = "Report" + Convert.ToString(_CbirepRepParams.REP_ID.ToString());

                    # region Доделать
                    /*if (!String.IsNullOrEmpty(_CbirepRepParams.NAMEF))
                    {
                        _FileNameBase = _CbirepRepParams.NAMEF;
                        if (_CbirepRepParams.NAMEF.StartsWith("="))
                        {
                            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
                            OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CBIREP"), con);

                            if (con.State != ConnectionState.Open) con.Open();
                            try
                            {
                                cmd.ExecuteNonQuery();

                                cmd.Parameters.Add("sql_str", OracleDbType.Varchar2, String.Format("select {0} from dual", _CbirepRepParams.NAMEF.Remove(0, 1)), ParameterDirection.Input);
                                cmd.Parameters.Add("param", OracleDbType.Varchar2, null, ParameterDirection.Input);
                                cmd.CommandType= CommandType.StoredProcedure;
                                cmd.CommandText = "exec_refcursor";
                                
                                SetParameters("sql_str", DB_TYPE.Varchar2, , DIRECTION.Input);
                                SetParameters("param", DB_TYPE.Varchar2, null, DIRECTION.Input);
                                DataSet ds = SQL_PROC_REFCURSOR("exec_refcursor", 0, 1);
                                _FileNameBase = Convert.ToString(ds.Tables[0].Rows[0][0]);
                            }
                            catch { }
                            finally
                            {
                                DisposeOraConnection();
                            }
                        }
                    }*/
                    # endregion
                }

                return _FileNameBase;
            }
        }
        public String FileNameFull
        {
            get
            {
                if (String.IsNullOrEmpty(_FileNameFull))
                {
                    _FileNameFull = FileNameBase + "_" + (DateTime.Now - new DateTime(1970, 1, 1)).Ticks.ToString() + "." + FileTypeExt;
                }

                return _FileNameFull;
            }
        }
        # endregion

        # region Конструкторы
        public ParsedReport(VCbirepRepparamsRecord CbirepRepParams)
        {
            this._CbirepRepParams = CbirepRepParams;
            Parse();
        }
        # endregion

        # region Приватные методы
        private void Parse()
        {
            String[] delimeter = new String[] { ",:" };

            // параметры отчета
            if (!String.IsNullOrEmpty(this._CbirepRepParams.BINDVARS))
                foreach (String param in this._CbirepRepParams.BINDVARS.Split(delimeter, StringSplitOptions.None))
                {
                    String ID = param.Split('=')[0].Replace(":", String.Empty);
                    String Name = param.Split('=')[1].Trim('\'');

                    ReportParam Param = new ReportParam(ID, Name);

                    // дефолтные значения
                    if (!String.IsNullOrEmpty(this._CbirepRepParams.DEFAULT_VARS))
                    {
                        foreach (String defvar in this._CbirepRepParams.DEFAULT_VARS.Split(delimeter, StringSplitOptions.None))
                        {
                            if (defvar.Replace(":", String.Empty).StartsWith(ID))
                            {
                                switch (Param.Type)
                                {
                                    case ParamTypes.Date:
                                        Param.DefaultValueDate = Convert.ToDateTime(defvar.Split('=')[1].Trim('\''));
                                        break;
                                    default:
                                        Param.DefaultValueString = defvar.Split('=')[1].Trim('\'');
                                        break;
                                }
                            }
                        }
                    }

                    // наполняющий sql
                    if (!String.IsNullOrEmpty(this._CbirepRepParams.BIND_SQL))
                    {
                        foreach (String bindsql in this._CbirepRepParams.BIND_SQL.Split(delimeter, StringSplitOptions.None))
                        {
                            if (bindsql.Replace(":", String.Empty).StartsWith(ID))
                                Param.BindSQL = bindsql.Replace(":", String.Empty).Replace(ID + "=", String.Empty).Trim('\'');
                        }
                    }

                    // параметр из Url
                    if (HttpContext.Current.Request.Params.Get(ID) != null)
                    {
                        Param.DefaultValueString = HttpContext.Current.Request.Params.Get(ID);
                    }

                    this._Params.Add(Param);
                }
        }
        # endregion

        # region Публичные методы
        public ReportParam FindByID(String ID)
        {
            foreach (ReportParam param in _Params)
                if (param.ID == ID)
                    return param;

            return null;
        }
        public void FillValues(XmlDocument doc)
        {
            foreach (XmlNode param in doc.GetElementsByTagName("Param"))
            {
                String ID = param.Attributes["ID"].Value.Replace(":", String.Empty);
                ReportParam Param = FindByID(ID);

                if (Param != null)
                    Param.DefaultValueString = param.Attributes["Value"].Value;
            }
        }
        # endregion
    }
    public class ReportParam
    {
        # region Приватные свойства
        private String _ID;
        private String _Name;
        private String _DefaultValue;
        private String _BindSQL;
        # endregion

        # region Публичные свойства
        public String ID
        {
            get
            {
                return this._ID.Replace(":", String.Empty);
            }
        }
        public String Name
        {
            get
            {
                if (String.IsNullOrEmpty(this._Name))
                {
                    if (ID == "sFdat1") return "Дата з";
                    if (ID == "sFdat2") return "Дата по";
                }
                return this._Name;
            }
            set
            {
                this._Name = value;
            }
        }
        public ParamTypes Type
        {
            get
            {
                if (this.ID.StartsWith("sFdat")) return ParamTypes.Date;
                if (!String.IsNullOrEmpty(this.BindSQL)) return ParamTypes.Reference;
                return ParamTypes.String;
            }
        }
        public String DefaultValueString
        {
            get
            {
                return this._DefaultValue;
            }
            set
            {
                this._DefaultValue = value;
            }
        }
        public DateTime? DefaultValueDate
        {
            get
            {
                if (String.IsNullOrEmpty(this._DefaultValue)) return DateTime.Now;
                return Convert.ToDateTime(this._DefaultValue);
            }
            set
            {
                this._DefaultValue = value.ToString();
            }
        }
        public String BindSQL
        {
            get
            {
                return this._BindSQL;
            }
            set
            {
                this._BindSQL = value;
            }
        }
        public ReferenceParams Reference
        {
            get
            {
                if (String.IsNullOrEmpty(BindSQL)) return new ReferenceParams();

                // вычитываем ид таблицы
                ReferenceParams refpars = new ReferenceParams();

                String[] BindSQLArray = BindSQL.Split('|');

                String TAB_NAME = BindSQLArray[0];
                refpars.KEY_FIELD = BindSQLArray[1];

                String[] ShowFields = BindSQLArray[2].Split(',');
                foreach (String field in ShowFields)
                    if (field != refpars.KEY_FIELD)
                    {
                        refpars.SEMANTIC_FIELD = field;
                        break;
                    }

                foreach (String field in ShowFields)
                    if (field != refpars.KEY_FIELD && field != refpars.SEMANTIC_FIELD)
                    {
                        refpars.SHOW_FIELDS += (String.IsNullOrEmpty(refpars.SHOW_FIELDS) ? "" : ",") + field;
                    }

                refpars.WHERE_CLAUSE = (BindSQLArray.Length > 3 ? BindSQLArray[3] : "");

                OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
                OracleCommand cmd = new OracleCommand(OraConnector.Handler.IOraConnection.GetSetRoleCommand("WR_CBIREP"), con);

                if (con.State == ConnectionState.Closed) con.Open();
                try
                {
                    cmd.ExecuteNonQuery();

                    cmd.Parameters.Add("p_tabname", OracleDbType.Varchar2, TAB_NAME, ParameterDirection.Input);
                    cmd.CommandText = "select mt.tabid from meta_tables mt where mt.tabname = :p_tabname";
                    Object obj = cmd.ExecuteScalar();

                    if (obj == null) throw new Bars.Exception.BarsException(String.Format("Таблиця {0} не описана у базі мета-данних", TAB_NAME));
                    else refpars.TAB_ID = Convert.ToDecimal(obj);
                }
                finally
                {
                    con.Close();
                    cmd.Dispose();
                    con.Dispose();
                }

                return refpars;
            }
        }
        # endregion

        # region Конструкторы
        public ReportParam(String ID, String Name)
            : this(ID)
        {
            this._Name = Name;
        }
        public ReportParam(String ID)
        {
            this._ID = ID;
        }
        # endregion

        # region Приватные методы
        # endregion
    }
    public class ReportSystemParams
    {
        # region Приватные свойства
        private Decimal? _RepID;
        private String _SessionID;
        private String _FileTypeCode;
        private String _FileNameFull;
        private DirectoryInfo _TmpDirInfo;
        # endregion

        # region Публичные свойства
        public DirectoryInfo TmpDirInfo
        {
            get
            {
                if (_TmpDirInfo == null)
                {
                    String TempPath = Path.GetTempPath() + "CbiReports\\";

                    _TmpDirInfo = new DirectoryInfo(TempPath);
                    if (!_TmpDirInfo.Exists) _TmpDirInfo.Create();
                }

                return _TmpDirInfo;
            }
        }
        public String ApplFilePath
        {
            get
            {
                return "rep_gen.exe";
            }
        }
        public Int32 AppTimeOut
        {
            get
            {
                return Int32.Parse(ConfigurationManager.AppSettings["cbirep.AppTimeOut"]) * 1000 + 5000;
            }
        }
        public String DataBase
        {
            get
            {
                return new OracleConnectionStringBuilder(WebConfigurationManager.ConnectionStrings[BarsWeb.Infrastructure.Constants.AppConnectionStringName].ConnectionString).DataSource;
            }
        }
        public String RptDirPath
        {
            get
            {
                return HttpContext.Current.Server.MapPath("/TEMPLATE.RPT");
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
        public String ExeFileArgs
        {
            get
            {
                return String.Format("{0} {1} {2} {3} {4} {5} {6}", DataBase, _SessionID, _FileTypeCode, TmpDirInfo.FullName + _FileNameFull, RptDirPath, TraceOn, TraceFileName);
            }
        }
        # endregion

        # region Конструкторы
        public ReportSystemParams(Decimal RepID, String SessionID, String FileTypeCode, String FileNameFull)
        {
            this._RepID = RepID;
            this._SessionID = SessionID;
            this._FileTypeCode = FileTypeCode;
            this._FileNameFull = FileNameFull;
        }
        # endregion

        # region Публичные методы
        public Boolean CheckQRPAccess(String QRPFileName)
        {
            return File.Exists(RptDirPath + "\\" + QRPFileName);
        }
        public void ClearTempFiles()
        {
            // удаляем файлы ненужных отчетов
            FileInfo[] TxtFilesInf = TmpDirInfo.GetFiles();
            for (int i = 0; i < TxtFilesInf.Length; i++)
            {
                try
                {
                    if (TxtFilesInf[i].CreationTime < DateTime.Now.AddDays(-1))
                        File.Delete(TxtFilesInf[i].FullName);
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
            SetRegistryParam();

            //-- если работаем в режиме отладки, то пишем строку параметров в logger
            Bars.Logger.DBLogger.WriteDebugMessage("BarsWeb.CbiRep : arguments line = " + ApplFilePath + " " + ExeFileArgs, "BarsWeb.CbiRep", HttpContext.Current);

            //-- запуск процесса формирования отчета
            ProcessStartInfo ProcInf = new ProcessStartInfo(ApplFilePath, ExeFileArgs);
            ProcInf.UseShellExecute = false;
            ProcInf.RedirectStandardError = true;
            ProcInf.CreateNoWindow = true;

            Process Proc = Process.Start(ProcInf);
            bool flagTerm = false;
            try
            {
                flagTerm = Proc.WaitForExit(AppTimeOut);
            }
            catch
            {
                Proc.Kill();
                throw new BarsException("Перевищено ліміт часу на формування звіту (rep_id=" + _RepID.ToString() + ").<br> Спробуйте конкретизувати параметри звіту.");
            }
            if (!flagTerm)
            {
                Proc.Kill();
                throw new BarsException("Перевищено ліміт часу на формування звіту (rep_id=" + _RepID.ToString() + ",timeout=" + (AppTimeOut / 1000).ToString() + ").<br> Спробуйте конкретизувати параметри звіту.");
            }

            string strError = Proc.StandardError.ReadToEnd();
            int nExitCode = Proc.ExitCode;
            if (0 != nExitCode)
            {
                throw new BarsException(
                    "Процесс " + ApplFilePath + " аварийно завершил работу. Код " + nExitCode + "."
                    + "Описание кода возврата из потока ошибок: " + strError);
            }
            Proc.Close();

            //-- если файл не сформирован, то создаем пустой
            if (!File.Exists(TmpDirInfo.FullName + _FileNameFull))
            {
                using (StreamWriter sw = new StreamWriter(TmpDirInfo.FullName + _FileNameFull, false, System.Text.Encoding.GetEncoding("windows-1251")))
                {
                    sw.WriteLine("Данні пусті! Перевірте правильність параметрів.");
                }
            }

            return TmpDirInfo.FullName + _FileNameFull;
        }
        # endregion

        # region Публичные методы
        private void SetRegistryParam()
        {
            /*
            RegistryKey key = Registry.CurrentUser.OpenSubKey(@"Control Panel\International", true);
            key.SetValue("sDecimal", ",", RegistryValueKind.String);
            key.SetValue("sDate", ".", RegistryValueKind.String);
            key.SetValue("sThousand", " ", RegistryValueKind.String);

            key.Close();
            */
        }
        # endregion
    }
}