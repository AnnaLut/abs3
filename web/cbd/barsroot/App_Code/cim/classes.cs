using System;
using System.Globalization;
using System.IO;
using System.Web.UI;
using barsroot.core;
using FastReport.Design;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using System.Data;
using System.Collections.Generic;
using System.Web;
using Newtonsoft.Json.Serialization;
using JavaScriptSerializer = System.Web.Script.Serialization.JavaScriptSerializer;

// Основной класс 
namespace barsroot.cim
{
    public struct JqGridResults
    {
        public int page;
        public int total;
        public int records;
        public List<string[]> rows;
    }

    public enum MessageType
    {
        Info,
        Error,
        Warning,
        Success
    }

    public class CreditPaymentClass
    {
        public decimal? ContrId { get; set; }
        public string RowId { get; set; }
        public string Date { get; set; }
        public decimal? Sum { get; set; }
        public int PayFlag { get; set; }
    }

    public class CreditPeriodClass
    {
        public decimal? ContrId { get; set; }
        public string RowId { get; set; }
        public string EndDate { get; set; }
        public decimal? Z { get; set; }
        public int CrMethodId { get; set; }
        public int CrPaymentPeriodId { get; set; }
        public decimal? Percent { get; set; }
        public decimal? PercentNbu { get; set; }
        public int PercentBaseId { get; set; }
        public int PercentPeriodId { get; set; }
        public int AdaptiveId { get; set; }
        public decimal PaymentDelay { get; set; }
        public decimal PercentDelay { get; set; }
        public int GetDayId { get; set; }
        public int PayDayId { get; set; }
    }

    public class ConclusionClass
    {
        public decimal? ContrId { get; set; }
        public string RowId { get; set; }
        public decimal? ConclId { get; set; }
        public decimal? OrgId { get; set; }
        public string OutNum { get; set; }
        public DateTime? OutDate { get; set; }
        public string OutDateS
        {
            get { return (OutDate.HasValue) ? (OutDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) OutDate = DateTime.ParseExact(value, "dd/MM/yyyy", CultureInfo.InvariantCulture); }
        }
        public DateTime? BeginDate { get; set; }
        public string BeginDateS
        {
            get { return (BeginDate.HasValue) ? (BeginDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) BeginDate = DateTime.ParseExact(value, "dd/MM/yyyy", CultureInfo.InvariantCulture); }
        }
        public DateTime? EndDate { get; set; }
        public string EndDateS
        {
            get { return (EndDate.HasValue) ? (EndDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) EndDate = DateTime.ParseExact(value, "dd/MM/yyyy", CultureInfo.InvariantCulture); }
        }
        public decimal? Sum { get; set; }
        public int? Kv { get; set; }
    }

    public class ApeClass
    {
        public decimal? ContrId { get; set; }
        public string RowId { get; set; }
        public decimal? ApeId { get; set; }
        public string Num { get; set; }
        public string Comment { get; set; }
        public decimal? Sum { get; set; }
        public decimal? Rate { get; set; }
        public decimal? SumVK { get; set; }
        public DateTime? BeginDate { get; set; }
        public string BeginDateS
        {
            get { return (BeginDate.HasValue) ? (BeginDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) BeginDate = DateTime.ParseExact(value, "dd/MM/yyyy", CultureInfo.InvariantCulture); }
        }
        public DateTime? EndDate { get; set; }
        public string EndDateS
        {
            get { return (EndDate.HasValue) ? (EndDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) EndDate = DateTime.ParseExact(value, "dd/MM/yyyy", CultureInfo.InvariantCulture); }
        }
        public int? Kv { get; set; }
    }

    public class BindClass
    {
        public decimal? BoundId { get; set; }
        public int DocKind { get; set; }
        public int PaymentType { get; set; }
        public int PayFlag { get; set; }
        public int Direct { get; set; }
        public Int64? DocRef { get; set; }
        public decimal SumVP { get; set; }
        public decimal SumComm { get; set; }
        public decimal? Rate { get; set; }
        public decimal? SumVC { get; set; }
        public int? OpType { get; set; }
        public string Comment { get; set; }
        public int? Subject { get; set; }
        public string ServiceCode { get; set; }
        public int? DocKv { get; set; }
        public string DocNum { get; set; }
        public DateTime? DocDateVal { get; set; }
        public string DocDateValS
        {
            get { return (DocDateVal.HasValue) ? (DocDateVal.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) DocDateVal = DateTime.ParseExact(value, "dd/MM/yyyy", CultureInfo.InvariantCulture); }
        }
        public DateTime? AllowDate { get; set; }
        public string AllowDateS
        {
            set { if (!string.IsNullOrEmpty(value)) AllowDate = DateTime.ParseExact(value, "dd/MM/yyyy", CultureInfo.InvariantCulture); }
        }

        public string FileName { get; set; }

        public decimal? VmdId { get; set; }
        public DateTime? FileDate { get; set; }
        public string FileDateS
        {
            set { if (!string.IsNullOrEmpty(value)) FileDate = DateTime.ParseExact(value, "dd/MM/yyyy", CultureInfo.InvariantCulture); }
        }

        public string JContrNum { get; set; }
        public DateTime? JContrDate { get; set; }
        public string JContrDateS
        {
            get { return (JContrDate.HasValue) ? (JContrDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) JContrDate = DateTime.ParseExact(value, "dd/MM/yyyy", CultureInfo.InvariantCulture); }
        }
        public string DocDetails { get; set; }
        public int? Rnk { get; set; }
        public int? BenefId { get; set; }
        public bool IsFantom { get; set; }
        public bool IsFullBind { get; set; }
        public bool JUnbind { get; set; }
        public bool IsForSend { get; set; }


        public string SBMode { get; set; }
        public string SBValDate { get; set; }
        public string SBSum71F { get; set; }
        public string SBSum32A { get; set; }
        public string SBBankMfo { get; set; }
        public string SBBankName { get; set; }
        public string SBZapNum { get; set; }
        public string SBZapDate { get; set; }
        public string SBDir { get; set; }
        public string SBDirFio { get; set; }
        public string SBPerFio { get; set; }
        public string SBPerTel { get; set; }
    }

    public class ResultData
    {
        public int Code { get; set; }
        public int CodeMinor { get; set; }
        public int CodeMajor { get; set; }
        public string Message { get; set; }
        public object DataObj { get; set; }
        public decimal DataDec { get; set; }
        public string DataStr { get; set; }
    }

    /// <summary>
    /// Основной класс
    /// </summary>
    public class CimManager
    {
        protected CimManager()
        {
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";
        }
        // Вычитка базовых параметров 
        public CimManager(bool readParams)
        {
            if (readParams)
            {
                InitConnection();
                try
                {
                    oraCmd = oraConn.CreateCommand();
                    oraCmd.CommandText = "select bankdate,f_ourmfo_g, cim_mgr.get_visa_id visaid, sys_context('bars_context', 'user_branch') branch, nvl((select par_value from cim_params where par_name='PRINT_CORP2_DOC'),1) prncorp2, nvl((select par_value from cim_params where par_name='SET_MD_ALLOW_DATE'),0) autoaldat, nvl((select par_value from cim_params where par_name='CONTRACT_OWNER_FLAG'),0) owner_flag, user_id, nvl((select par_value from cim_params where par_name='SYNC_SIDE'),0) sync_side, (select par_value from cim_params where par_name='REQUISITE_FILTER_CONDITION') req_filter_cond from dual";

                    oraRdr = oraCmd.ExecuteReader();
                    if (oraRdr.Read())
                    {
                        BankDate = Convert.ToDateTime(oraRdr["bankdate"]);
                        BankId = Convert.ToString(oraRdr["f_ourmfo_g"]);
                        VisaId = Convert.ToString(oraRdr["visaid"]);
                        Branch = Convert.ToString(oraRdr["branch"]);
                        PrintCorp2Doc = Convert.ToByte(oraRdr["prncorp2"]);
                        AutoFillAllowDate = Convert.ToByte(oraRdr["autoaldat"]);
                        ContractOwnerFlag = Convert.ToByte(oraRdr["owner_flag"]);
                        UserId = Convert.ToDecimal(oraRdr["user_id"]);
                        SyncSide = Convert.ToByte(oraRdr["sync_side"]);
                        SyncSide = Convert.ToByte(oraRdr["sync_side"]);
                        ReqFilterCondition = Convert.ToString(oraRdr["req_filter_cond"]);

                        HttpContext.Current.Session[Constants.StateKeys.Branch] = Branch;
                        HttpContext.Current.Session[Constants.StateKeys.BankDate] = BankDate;
                        HttpContext.Current.Session[Constants.StateKeys.VisaId] = VisaId;
                        HttpContext.Current.Session[Constants.StateKeys.BankId] = BankId;
                        HttpContext.Current.Session[Constants.StateKeys.ParamsPrintCorp2Doc] = PrintCorp2Doc;
                        HttpContext.Current.Session[Constants.StateKeys.ParamsAutoFillAllowDate] = AutoFillAllowDate;
                        HttpContext.Current.Session[Constants.StateKeys.ParamsContractOwnerFlag] = ContractOwnerFlag;
                        HttpContext.Current.Session[Constants.StateKeys.UserId] = UserId;
                        HttpContext.Current.Session[Constants.StateKeys.SyncSide] = SyncSide;
                        HttpContext.Current.Session[Constants.StateKeys.ParamsReqFilterCondition] = ReqFilterCondition;

                    }
                }
                catch (System.Exception ex)
                {
                    SaveException(ex);
                    throw ex;
                }
                finally
                {
                    oraCmd.Dispose();
                    oraConn.Close();
                    oraConn.Dispose();
                }
            }
        }

        protected CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");

        protected OracleConnection oraConn;
        protected OracleCommand oraCmd;
        protected OracleDataReader oraRdr;

        public static string Version = "1.0.0.53";
        public static bool IsDebug = false;

        public string BankId = string.Empty;
        public DateTime? BankDate = null;
        public string VisaId = string.Empty;
        public string Branch = string.Empty;
        public decimal? UserId;
        public byte PrintCorp2Doc = 0;
        public byte AutoFillAllowDate = 0;
        public byte ContractOwnerFlag = 0;
        public byte SyncSide = 0;
        public string ReqFilterCondition = string.Empty;

        public void InitConnection()
        {
            oraConn = OraConnector.Handler.UserConnection;
            // попытка установить в переменную пакета аудита клиентский адрес (если доступен)
            string hostName = WebUtility.GetHostName();
            if (!string.IsNullOrEmpty(hostName))
            {
                try
                {
                    OracleCommand cmd = oraConn.CreateCommand();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("p_machine", OracleDbType.Varchar2, hostName, ParameterDirection.Input);
                    cmd.CommandText = "bars.bars_audit.set_machine";
                    cmd.ExecuteNonQuery();
                }
                catch { } // давим на всякий случай все
            }
        }

        public static CultureInfo GetCI
        {
            get
            {
                CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
                ci.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
                ci.DateTimeFormat.DateSeparator = "/";
                return ci;
            }
        }

        public static string NumberFormat(decimal? inValue)
        {
            return string.Format("{0:N}", inValue).Replace(",", " ");
        }
        public static decimal StrToNumber(string inValue)
        {
            if (string.IsNullOrEmpty(inValue))
                inValue = "0";
            return Convert.ToDecimal((inValue).Replace(" ", ""));
        }
        public static DateTime StrToDate(string inValue)
        {
            return Convert.ToDateTime(inValue, GetCI);
        }

        public static string StrDosToWin(string source)
        {
            if (String.IsNullOrEmpty(source)) return source;
            const string WinCharSet = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЪЫЭЮЯІЇЄабвгдеёжзийклмнопрстуфхцчшщьъыэюяіїє№Ґґ";
            const string NbuDosSet = "ЂЃ‚ѓ„…р†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—™њљ›ќћџцшф ЎўЈ¤Ґс¦§Ё©Є«¬­®Їабвгдежзиймклнопчщхьту";
            string res = String.Empty;
            for (int i = 0; i < source.Length; i++)
            {
                int offset = NbuDosSet.IndexOf(source[i]);
                res += offset >= 0 ? WinCharSet[offset] : source[i];
            }
            return res;
        }

        public void SaveException(System.Exception ex)
        {
            if (ex is System.Reflection.TargetInvocationException)
                ex = ex.InnerException;
            decimal? rec_id = 0;
            HttpContext.Current.Session[Constants.StateKeys.LastError] = ErrorHelper.AnalyzeException(ex, ref rec_id);
            HttpContext.Current.Session[Constants.StateKeys.LastErrorRecID] = rec_id;
        }

        public void SetOwner(decimal contrId)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("contrID", OracleDbType.Decimal, contrId, ParameterDirection.Input);
                oraCmd.CommandText = "update bars.cim_contracts set owner_uid=bars.user_id where contr_id=:contrID";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void SetContractBranch(decimal contrId, string branch)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, contrId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_new_branch", OracleDbType.Varchar2, branch, ParameterDirection.Input);
                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.change_contract_branch";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }



        public ResultData GetCorp2Doc(decimal docRef, string tt)
        {
            ResultData res = new ResultData();
            res.Message = "";
            res.DataStr = "";

            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("ref", OracleDbType.Decimal, docRef, ParameterDirection.Input);
                oraCmd.CommandText = "select doc_desc from v_corp2_docs where ref=:ref";
                oraRdr = oraCmd.ExecuteReader();
                if (oraRdr.Read())
                {
                    OracleBlob blob = oraRdr.GetOracleBlob(0);
                    if (blob.IsNull)
                    {
                        res.Code = -1;
                        res.Message = "Не знайденно друкованої форми по документу ref=" + docRef + " в таблиці імпортованих з corp2!";
                    }
                    else
                    {

                        string fileName = Path.GetTempFileName();
                        Byte[] byteArr = new Byte[blob.Length];
                        blob.Read(byteArr, 0, Convert.ToInt32(blob.Length));
                        using (FileStream fs = new FileStream(fileName, FileMode.Append, FileAccess.Write))
                        {
                            fs.Write(byteArr, 0, byteArr.Length);
                        }
                        res.Message = string.Format("card_{0}({1}).rtf", tt, docRef);
                        res.DataStr = fileName;
                        res.Code = 0;
                    }
                    blob.Dispose();
                }
                else
                {
                    res.Code = -2;
                    res.Message = "Не знайденно данних по документу ref=" + docRef + " в таблиці імпортованих з corp2!";
                }

            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return res;
        }

        public ResultData CheckForVisa(decimal docRef, BindClass bindInfo)
        {
            ResultData res = new ResultData();
            // Удаляем из сесии прошлый документ
            HttpContext.Current.Session.Remove(Constants.StateKeys.CurrRef);
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.check_visa_status";
                oraCmd.Parameters.Add("ref", OracleDbType.Decimal, docRef, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_code", OracleDbType.Decimal, 0, ParameterDirection.Output);
                oraCmd.Parameters.Add("p_msg", OracleDbType.Varchar2, "".PadRight(4000), ParameterDirection.InputOutput);
                oraCmd.ExecuteNonQuery();
                string outMsg = string.Empty;
                if ((OracleString)oraCmd.Parameters["p_msg"].Value != OracleString.Null)
                    outMsg = Convert.ToString(oraCmd.Parameters["p_msg"].Value);
                string status = Convert.ToString(oraCmd.Parameters["p_code"].Value);
                if (string.IsNullOrEmpty(outMsg))
                {
                    res.Code = 0;
                    // все ок, помещаем в сессию документ для визирования
                    HttpContext.Current.Session[Constants.StateKeys.CurrRef] = docRef;
                    /*if (bindInfo != null)
                    {
                        Contract contr = new Contract();
                        contr.ContrId = 0;
                        res.DataDec = contr.SaveBind(bindInfo);

                        if (bindInfo.IsForSend)
                        {
                            FrxParameters pars = new FrxParameters();
                            string templatePath =
                                Path.Combine(HttpContext.Current.Server.MapPath("/barsroot/cim/tools/templates"),
                                    "payment_mail.frx");

                            pars.Add(new FrxParameter("rnk", TypeCode.String, bindInfo.Rnk));
                            pars.Add(new FrxParameter("zap_date", TypeCode.String, bindInfo.SBZapDate));
                            pars.Add(new FrxParameter("zap_num", TypeCode.String, bindInfo.SBZapNum));
                            pars.Add(new FrxParameter("contr_num", TypeCode.String, bindInfo.JContrNum));
                            pars.Add(new FrxParameter("contr_date", TypeCode.String, bindInfo.JContrDateS));
                            pars.Add(new FrxParameter("val_date", TypeCode.String, bindInfo.SBValDate));
                            pars.Add(new FrxParameter("ref", TypeCode.String, bindInfo.DocRef));
                            pars.Add(new FrxParameter("control_bank", TypeCode.String, bindInfo.SBBankName));
                            pars.Add(new FrxParameter("director", TypeCode.String, bindInfo.SBDir));
                            pars.Add(new FrxParameter("vik_name", TypeCode.String, bindInfo.SBPerFio));
                            pars.Add(new FrxParameter("vik_tel", TypeCode.String, bindInfo.SBPerTel));
                            pars.Add(new FrxParameter("swift_71f", TypeCode.String, bindInfo.SBSum71F));
                            pars.Add(new FrxParameter("swift_32a", TypeCode.String, bindInfo.SBSum32A));
                            pars.Add(new FrxParameter("director_name", TypeCode.String, bindInfo.SBDirFio));
                            pars.Add(new FrxParameter("control_bank_mfo", TypeCode.String, bindInfo.SBBankMfo));

                            FrxDoc doc = new FrxDoc(templatePath, pars, null);
                            res.DataStr = doc.Export(FrxExportTypes.Rtf);
                        }
                    }*/
                }
                else
                    res.Code = 1;
                res.Message = outMsg;
                res.DataObj = status;
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return res;
        }

        public ResultData BindZeroContract(BindClass bindInfo)
        {
            ResultData res = new ResultData();

            Contract contr = new Contract();
            contr.ContrId = 0;
            res.DataDec = contr.SaveBind(bindInfo);

            if (bindInfo.JUnbind)
                contr.UnboundPayment(res.DataDec, bindInfo.PaymentType, "Привязка з занесенням в журнал");

            return res;
        }

        public ResultData AutoBind(string strDateStart, string strDateFinish, string okpo)
        {
            ResultData res = new ResultData();
            // Удаляем из сесии прошлый документ
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.process_all_vmd";
                DateTime datBegin = DateTime.ParseExact(strDateStart, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                DateTime datFinish = DateTime.ParseExact(strDateFinish, "dd/MM/yyyy", CultureInfo.InvariantCulture);

                oraCmd.Parameters.Add("p_begin_date", OracleDbType.Date, datBegin, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_end_date", OracleDbType.Date, datFinish, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, okpo, ParameterDirection.Input);
                oraCmd.ExecuteNonQuery();

                res.Code = 1;
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return res;
        }

        public decimal GetDeclarationSum(decimal type_id, decimal bound_id)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "select nvl(round(sum(s)/100,2),0) from CIM_LINK where delete_date is null and decode(:type_id,0, vmd_id, act_id) = :bound_id";
                oraCmd.Parameters.Add("type_id", OracleDbType.Decimal, type_id, ParameterDirection.Input);
                oraCmd.Parameters.Add("bound_id", OracleDbType.Decimal, bound_id, ParameterDirection.Input);
                return Convert.ToDecimal(oraCmd.ExecuteScalar());
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public decimal GetConclusionSum(decimal type_id, decimal bound_id)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "select nvl(round(sum(s)/100,2),0) as conclusion_sum from cim_conclusion_link where delete_date is null and decode(:type_id,0,payment_id,fantom_id) = :bound_id";
                oraCmd.Parameters.Add("type_id", OracleDbType.Decimal, type_id, ParameterDirection.Input);
                oraCmd.Parameters.Add("bound_id", OracleDbType.Decimal, bound_id, ParameterDirection.Input);
                return Convert.ToDecimal(oraCmd.ExecuteScalar());
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public decimal GetLicenseSum(decimal type_id, decimal sBoundId)
        {
            InitConnection();
            try
            {
                decimal? boundId = null;
                if (sBoundId > 0)
                    boundId = sBoundId;
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "select nvl(round(sum(s)/100,2),0) as s_license from cim_license_link where delete_date is null and ( decode(:type_id, 0, payment_id, fantom_id) = :bound_id or :bound_id is null and payment_id is null and fantom_id is null )";
                oraCmd.Parameters.Add("type_id", OracleDbType.Decimal, type_id, ParameterDirection.Input);
                oraCmd.Parameters.Add("bound_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                oraCmd.Parameters.Add("bound_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                return Convert.ToDecimal(oraCmd.ExecuteScalar());
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public decimal GetApeSum(decimal type_id, decimal bound_id)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "select nvl(round(sum(s)/100,2),0) as s_ape from cim_ape_link where delete_date is null and decode(:type_id, 0, payment_id, fantom_id) = :bound_id and ape_id is not null";
                oraCmd.Parameters.Add("type_id", OracleDbType.Decimal, type_id, ParameterDirection.Input);
                oraCmd.Parameters.Add("bound_id", OracleDbType.Decimal, bound_id, ParameterDirection.Input);
                return Convert.ToDecimal(oraCmd.ExecuteScalar());
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public decimal GetApeSum2(decimal contrId, decimal s)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "select nvl(round(sum(al.s)/100,2),0) as s_ape from cim_ape_link al, cim_contracts_ape ca where al.ape_id=ca.ape_id and al.delete_date is null and al.payment_id is null and al.fantom_id is null and ca.contr_id=:contrId and al.s = :s * 100";
                oraCmd.Parameters.Add("contrId", OracleDbType.Decimal, contrId, ParameterDirection.Input);
                oraCmd.Parameters.Add("s", OracleDbType.Decimal, s, ParameterDirection.Input);
                return Convert.ToDecimal(oraCmd.ExecuteScalar());
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void BackPayment(int docKind, decimal docID)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("docKind", OracleDbType.Decimal, docKind, ParameterDirection.Input);
                oraCmd.Parameters.Add("fantomID", OracleDbType.Decimal, docID, ParameterDirection.Input);
                oraCmd.CommandType = CommandType.StoredProcedure; ;
                oraCmd.CommandText = "cim_mgr.back_payment";
                oraCmd.ExecuteNonQuery();
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void DeleteJournalRecord(decimal docKind, decimal docType, decimal boundId)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_doc_kind", OracleDbType.Decimal, docKind, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_type", OracleDbType.Decimal, docType, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_bound_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.delete_from_journal";
                oraCmd.ExecuteNonQuery();
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void UpdateComment(string comment, decimal docKind, decimal docType, decimal boundId, string level)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_doc_kind", OracleDbType.Decimal, docKind, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_type", OracleDbType.Decimal, docType, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_bound_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_str_level", OracleDbType.Varchar2, level, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, comment, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.update_comment";
                oraCmd.ExecuteNonQuery();
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }


        public void EnumJournal()
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandType = CommandType.StoredProcedure; ;
                oraCmd.CommandText = "cim_mgr.journal_numbering";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public bool SetDeclPaperDate(decimal id, string date)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("cim_date", OracleDbType.Date, Convert.ToDateTime(date, cinfo), ParameterDirection.Input);
                oraCmd.Parameters.Add("cim_id", OracleDbType.Decimal, id, ParameterDirection.Input);
                oraCmd.CommandText = "update customs_decl set cim_date=:cim_date where cim_id=:cim_id";
                oraCmd.ExecuteNonQuery();

                oraCmd.Parameters.Clear();
                oraCmd.Parameters.Add("cim_id", OracleDbType.Decimal, id, ParameterDirection.Input);
                oraCmd.CommandText = "select decode(trunc(allow_dat), trunc(cim_date),1,0) from customs_decl where cim_id=:cim_id";
                return Convert.ToString(oraCmd.ExecuteScalar()) == "1";
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public ResultData PrepareSendDecl(decimal vmdId, string okpo)
        {
            ResultData res = new ResultData();
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("okpo", OracleDbType.Varchar2, okpo, ParameterDirection.Input);
                oraCmd.CommandText = "select max(rnk) from customer where okpo=:okpo";
                res.Message = Convert.ToString(oraCmd.ExecuteScalar());

                oraCmd.Parameters.Clear();
                oraCmd.Parameters.Add("cim_id", OracleDbType.Decimal, vmdId, ParameterDirection.Input);
                oraCmd.CommandText = "select nvl(sum(s_vt),0) from cim_vmd_bound where delete_date is null and vmd_id=:cim_id";
                oraRdr = oraCmd.ExecuteReader();
                res.DataDec = Convert.ToDecimal(oraCmd.ExecuteScalar(), cinfo);
                return res;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public ResultData SendToBank(decimal vmdId, BindClass bindInfo)
        {
            ResultData res = new ResultData();
            // Удаляем из сесии прошлый документ
            HttpContext.Current.Session.Remove(Constants.StateKeys.CurrRef);
            InitConnection();
            decimal boundId = 0;
            try
            {
                oraCmd = oraConn.CreateCommand();

                string comment = string.Format("Передано в банк {0} згідно запиту {1} від {2} р.", bindInfo.SBBankName, bindInfo.SBZapNum, bindInfo.SBZapDate);

                oraCmd.Parameters.Add("boundId", OracleDbType.Decimal, boundId, ParameterDirection.InputOutput);
                oraCmd.Parameters.Add("p_ref", OracleDbType.Decimal, vmdId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_s_vt", OracleDbType.Decimal, bindInfo.SumVC, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, comment, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_rnk", OracleDbType.Decimal, bindInfo.Rnk, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_benef_id", OracleDbType.Decimal, bindInfo.BenefId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_c_num", OracleDbType.Varchar2, bindInfo.JContrNum, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_c_date", OracleDbType.Date, bindInfo.JContrDate, ParameterDirection.Input);

                oraCmd.CommandText = "declare boundId number; begin :boundId := cim_mgr.bound_vmd(0,:p_ref,0,:p_s_vt,null,null,null,:p_comments, null,null,null,:p_rnk,:p_benef_id,:p_c_num,:p_c_date); end;";
                oraCmd.ExecuteNonQuery();
                if (oraCmd.Parameters["boundId"].Value != null)
                    boundId = Convert.ToDecimal(oraCmd.Parameters["boundId"].Value.ToString());

                FrxParameters pars = new FrxParameters();
                string templatePath =
                    Path.Combine(HttpContext.Current.Server.MapPath("/barsroot/cim/tools/templates"),
                        "vmd_mail.frx");

                pars.Add(new FrxParameter("rnk", TypeCode.String, bindInfo.Rnk));
                pars.Add(new FrxParameter("zap_date", TypeCode.String, bindInfo.SBZapDate));
                pars.Add(new FrxParameter("zap_num", TypeCode.String, bindInfo.SBZapNum));
                pars.Add(new FrxParameter("cim_id", TypeCode.String, vmdId));
                pars.Add(new FrxParameter("control_bank", TypeCode.String, bindInfo.SBBankName));
                pars.Add(new FrxParameter("director", TypeCode.String, bindInfo.SBDir));
                pars.Add(new FrxParameter("vik_name", TypeCode.String, bindInfo.SBPerFio));
                pars.Add(new FrxParameter("vik_tel", TypeCode.String, bindInfo.SBPerTel));
                pars.Add(new FrxParameter("swift_71f", TypeCode.String, bindInfo.SBSum71F));
                pars.Add(new FrxParameter("swift_32a", TypeCode.String, bindInfo.SBSum32A));
                pars.Add(new FrxParameter("director_name", TypeCode.String, bindInfo.SBDirFio));
                pars.Add(new FrxParameter("control_bank_mfo", TypeCode.String, bindInfo.SBBankMfo));
                pars.Add(new FrxParameter("bound_sum", TypeCode.Decimal, bindInfo.SumVC));

                FrxDoc doc = new FrxDoc(templatePath, pars, null);
                res.DataStr = doc.Export(FrxExportTypes.Rtf);
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return res;
        }

        public ResultData FormSendToBankMail(decimal mailId, BindClass bindInfo)
        {
            ResultData res = new ResultData();
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                string name = string.Empty;
                string nameOv = string.Empty;
                string ourMfo = string.Empty;
                oraCmd.CommandText = "select f_ourmfo, name, name_ov from cim_journal_num where length(branch)=8";
                oraRdr = oraCmd.ExecuteReader();
                if (oraRdr.Read())
                {
                    ourMfo = Convert.ToString(oraRdr.GetValue(0));
                    name = Convert.ToString(oraRdr.GetValue(1));
                    nameOv = Convert.ToString(oraRdr.GetValue(2));
                }

                string frxFile = "payment_mail_link.frx";
                if (bindInfo.SBMode == "0")
                    frxFile = "vmd_mail_link.frx";

                FrxParameters pars = new FrxParameters();
                string templatePath =
                    Path.Combine(HttpContext.Current.Server.MapPath("/barsroot/cim/tools/templates"),
                        frxFile);

                pars.Add(new FrxParameter("zap_date", TypeCode.String, bindInfo.SBZapDate));
                pars.Add(new FrxParameter("zap_num", TypeCode.String, bindInfo.SBZapNum));
                pars.Add(new FrxParameter("control_bank", TypeCode.String, bindInfo.SBBankName));
                pars.Add(new FrxParameter("director", TypeCode.String, bindInfo.SBDir));
                pars.Add(new FrxParameter("vik_name", TypeCode.String, bindInfo.SBPerFio));
                pars.Add(new FrxParameter("vik_tel", TypeCode.String, bindInfo.SBPerTel));
                pars.Add(new FrxParameter("director_name", TypeCode.String, bindInfo.SBDirFio));
                pars.Add(new FrxParameter("control_bank_mfo", TypeCode.String, bindInfo.SBBankMfo));
                pars.Add(new FrxParameter("mail_id", TypeCode.String, mailId));
                pars.Add(new FrxParameter("mfo", TypeCode.String, ourMfo));
                pars.Add(new FrxParameter("bank_name", TypeCode.String, name));
                pars.Add(new FrxParameter("bank_name_ov", TypeCode.String, nameOv));

                FrxDoc doc = new FrxDoc(templatePath, pars, null);
                res.DataStr = doc.Export(FrxExportTypes.Rtf);
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return res;
        }

        public void ApproveBorgMessage(string listId)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "update cim_borg_message set approve=1 where id in (" + listId + ")";
                oraCmd.ExecuteNonQuery();
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void ClearNullLicense(string okpo)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, okpo, ParameterDirection.Input);
                oraCmd.CommandText = "cim_mgr.clear_null_license";
                oraCmd.ExecuteNonQuery();
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void DeleteAct(string vmdId)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.Parameters.Add("p_act_id", OracleDbType.Varchar2, vmdId, ParameterDirection.Input);
                oraCmd.CommandText = "cim_mgr.delete_act";
                oraCmd.ExecuteNonQuery();
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }
        public void HideDecl(string vmdId)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_vmd_id", OracleDbType.Varchar2, vmdId, ParameterDirection.Input);
                oraCmd.CommandText = "update customs_decl set cim_boundsum=null where cim_id=:p_vmd_id";
                oraCmd.ExecuteNonQuery();
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public string GetDocRels(decimal docRef, int docType)
        {
            var objJson = new Dictionary<string, object>();
            string strJson = string.Empty;
            InitConnection();
            int counter = 0;
            try
            {
                oraCmd = oraConn.CreateCommand();
                // платеж
                if (docType == 0)
                {
                    oraCmd.Parameters.Add("p_ref", OracleDbType.Decimal, docRef, ParameterDirection.Input);
                    oraCmd.CommandText = "select c.num, nvl(c.subnum,' '), cpb.s/100, to_char(c.open_date,'DD.MM.YYYY'), c.contr_id, to_char(cpb.delete_date,'DD.MM.YYYY'), to_char(cpb.create_date,'DD.MM.YYYY') from cim_payments_bound cpb, cim_contracts c where c.contr_id= cpb.contr_id and  cpb.contr_id is not null and cpb.contr_id>0 and cpb.ref=:p_ref";
                    oraRdr = oraCmd.ExecuteReader();
                    List<object> rows = new List<object>();
                    while (oraRdr.Read())
                    {
                        var row = new object[] { oraRdr.GetValue(0), oraRdr.GetValue(1), oraRdr.GetValue(2), oraRdr.GetValue(3), oraRdr.GetValue(4), oraRdr.GetValue(5), oraRdr.GetValue(6) };
                        rows.Add(row);
                    }
                    objJson.Add("tab", rows);
                    oraRdr.Close();

                    oraCmd.CommandText = "select count(*) from cim_payments_bound where contr_id is not null and contr_id=0 and ref=:p_ref";
                    objJson.Add("jpos", Convert.ToString(oraCmd.ExecuteScalar()));
                }
                else
                {
                    oraCmd.Parameters.Add("p_ref", OracleDbType.Decimal, docRef, ParameterDirection.Input);
                    oraCmd.CommandText = "select c.num, nvl(c.subnum,' '), cpb.s/100, to_char(c.open_date,'DD.MM.YYYY'), c.contr_id, to_char(cpb.delete_date,'DD.MM.YYYY'), to_char(cpb.create_date,'DD.MM.YYYY') from cim_fantoms_bound cpb, cim_contracts c where c.contr_id= cpb.contr_id and  cpb.contr_id is not null and cpb.contr_id>0 and cpb.fantom_id=:p_ref";
                    oraRdr = oraCmd.ExecuteReader();
                    List<object> rows = new List<object>();
                    while (oraRdr.Read())
                    {
                        var row = new object[] { oraRdr.GetValue(0), oraRdr.GetValue(1), oraRdr.GetValue(2), oraRdr.GetValue(3), oraRdr.GetValue(4), oraRdr.GetValue(5), oraRdr.GetValue(6) };
                        rows.Add(row);
                    }
                    objJson.Add("tab", rows);
                    oraRdr.Close();

                    objJson.Add("jpos", "0");
                }
                strJson = new JavaScriptSerializer().Serialize(objJson);
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return strJson;
        }
    }

    /// <summary>
    /// Класс контракта
    /// </summary>
    public class Contract : CimManager
    {
        #region Variables
        #endregion
        #region Constructors
        public Contract() { }
        public Contract(decimal? contrId)
        {
            this.ContrId = contrId;
            readContract();
        }
        #endregion

        #region Properties
        public decimal? ContrId { get; set; }
        public byte ContrType { get; set; }
        public string ContrTypeName { get; set; }
        public string Num { get; set; }
        public string SubNum { get; set; }
        public decimal? Rnk { get; set; }
        public decimal Kv { get; set; }
        public decimal? Sum { get; set; }
        public decimal BenefId { get; set; }
        public int StatusId { get; set; }
        public string StatusName { get; set; }
        public string Comments { get; set; }
        public string Branch { get; set; }
        public string BranchName { get; set; }

        public decimal? OwnerUid { get; set; }
        public string OwnerName { get; set; }

        public ClientClass ClientInfo;
        public BeneficiarClass BeneficiarInfo;
        public CreditContractClass CreditContractInfo;
        public TradeContractClass TradeContractInfo;
        public BeneficiarBankClass BeneficiarBankInfo = new BeneficiarBankClass();
        public DateTime? DateOpen;
        public DateTime? DateClose;
        public string DateOpenS
        {
            get { return (DateOpen.HasValue) ? (DateOpen.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { DateOpen = DateTime.Parse(value, cinfo); }
        }
        public string DateCloseS
        {
            get { return (DateClose.HasValue) ? (DateClose.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) DateClose = DateTime.Parse(value, cinfo); }
        }

        #endregion
        #region Private methods

        private void readContract()
        {
            InitConnection();
            if (this.ContrId.HasValue)
            {
                try
                {
                    oraCmd = oraConn.CreateCommand();
                    oraCmd.Parameters.Add("contrId", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                    oraCmd.CommandText = "select contr_id,contr_type, contr_type_name, num, subnum, rnk,open_date,close_date,kv,s,benef_id,status_id,status_name,comments, branch, branch_name, owner_uid, owner_name, bic, b010 from v_cim_all_contracts where contr_id=:contrId";

                    oraRdr = oraCmd.ExecuteReader();
                    if (oraRdr.Read())
                    {
                        this.ContrId = Convert.ToDecimal(oraRdr["contr_id"]);
                        this.ContrType = Convert.ToByte(oraRdr["contr_type"]);
                        this.ContrTypeName = Convert.ToString(oraRdr["contr_type_name"]);
                        this.Num = Convert.ToString(oraRdr["num"]);
                        this.SubNum = Convert.ToString(oraRdr["subnum"]);
                        this.Rnk = Convert.ToDecimal(oraRdr["rnk"]);
                        this.ClientInfo = new ClientClass(this.Rnk, null);
                        this.DateOpen = Convert.ToDateTime(oraRdr["open_date"]);
                        if (!oraRdr.IsDBNull(7))
                            this.DateClose = Convert.ToDateTime(oraRdr["close_date"]);
                        this.Kv = Convert.ToDecimal(oraRdr["kv"]);
                        if (!oraRdr.IsDBNull(9))
                            this.Sum = Convert.ToDecimal(oraRdr["s"]);
                        this.BenefId = Convert.ToDecimal(oraRdr["benef_id"]);
                        this.BeneficiarInfo = new BeneficiarClass(this.BenefId);
                        this.StatusId = Convert.ToInt32(oraRdr["status_id"]);
                        this.StatusName = Convert.ToString(oraRdr["status_name"]);
                        this.Comments = Convert.ToString(oraRdr["comments"]);
                        this.Branch = Convert.ToString(oraRdr["branch"]);
                        this.BranchName = Convert.ToString(oraRdr["branch_name"]);
                        if (oraRdr["owner_uid"] != DBNull.Value)
                            this.OwnerUid = Convert.ToDecimal(oraRdr["owner_uid"]);
                        this.OwnerName = Convert.ToString(oraRdr["owner_name"]);

                        if (oraRdr["bic"] != DBNull.Value)
                            this.BeneficiarBankInfo = new BeneficiarBankClass(Convert.ToString(oraRdr["bic"]), Convert.ToString(oraRdr["b010"]));

                        // Торговий
                        if (this.ContrType == 0 || this.ContrType == 1)
                            this.TradeContractInfo = new TradeContractClass(this.ContrId);
                        // Кредитний
                        else if (this.ContrType == 2)
                            this.CreditContractInfo = new CreditContractClass(this.ContrId);
                    }
                    else
                        this.ContrId = null;

                    oraRdr.Close();
                }
                catch (System.Exception ex)
                {
                    SaveException(ex);
                    throw ex;
                }
                finally
                {
                    oraCmd.Dispose();
                    oraConn.Close();
                    oraConn.Dispose();
                }
            }
        }

        #endregion
        #region Public methods

        public bool CloseContract(decimal? contrId)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                // Update 
                if (contrId.HasValue)
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, contrId, ParameterDirection.Input);
                    oraCmd.CommandType = CommandType.StoredProcedure;
                    oraCmd.CommandText = "cim_mgr.close_contract";
                    oraCmd.ExecuteNonQuery();
                    return true;
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return false;
        }

        public bool ResurrectContract(decimal? contrId)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                // Update 
                if (contrId.HasValue)
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, contrId, ParameterDirection.Input);
                    oraCmd.CommandType = CommandType.StoredProcedure;
                    oraCmd.CommandText = "cim_mgr.resurrect_contract";
                    oraCmd.ExecuteNonQuery();
                    return true;
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return false;
        }

        public decimal SaveContract()
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                if (this.DateClose.HasValue && this.DateOpen > this.DateClose)
                    throw new System.Exception("Дата закриття повинна бути більшою від дати відкриття!");

                // Update 
                if (this.ContrId.HasValue)
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_num", OracleDbType.Varchar2, this.Num, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_subnum", OracleDbType.Varchar2, this.SubNum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, this.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_benef_id", OracleDbType.Decimal, this.BenefId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_open_date", OracleDbType.Date, this.DateOpen, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_close_date", OracleDbType.Date, this.DateClose, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, this.Comments, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_bic", OracleDbType.Varchar2, this.BeneficiarBankInfo.BicCodeId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_b010", OracleDbType.Varchar2, this.BeneficiarBankInfo.BankB010, ParameterDirection.Input);
                    if (this.ContrType == 0 || this.ContrType == 1)
                    {
                        addParams = ",:p_spec_id, :p_subject_id, :p_without_acts, :p_deadline, :p_txt_subject";
                        oraCmd.Parameters.Add("p_spec_id", OracleDbType.Decimal, this.TradeContractInfo.SpecId, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_subject_id", OracleDbType.Decimal, this.TradeContractInfo.SubjectId, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_without_acts", OracleDbType.Decimal, this.TradeContractInfo.WithoutActs, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_deadline", OracleDbType.Decimal, this.TradeContractInfo.Deadline, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_txt_subject", OracleDbType.Varchar2, this.TradeContractInfo.SubjectText, ParameterDirection.Input);
                    }
                    else if (this.ContrType == 2)
                    {
                        addParams = ",NULL,NULL,NULL,NULL,NULL,:p_percent_nbu,:p_s_limit,:p_creditor_type,:p_credit_borrower,:p_credit_type,:p_credit_term,:p_credit_prepay," +
                        ":p_name,:p_add_agree,:p_percent_nbu_type,:p_percent_nbu_info,:p_r_agree_date,:p_r_agree_no,:p_prev_doc_key,:p_prev_reestr_attr,:p_ending_date_indiv,:p_parent_ch_data,:p_ending_date,:p_f503_reason,:p_f503_state,:p_f503_note, :p_f504_reason, :p_f504_note";//,:p_margin,:p_tranche_no,:p_tr_summa,:p_tr_currency,:p_tr_rate_name,:p_tr_rate,:p_credit_opertype,:p_credit_operdate";

                        oraCmd.Parameters.Add("p_percent_nbu", OracleDbType.Decimal, this.CreditContractInfo.NbuPercent, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_s_limit", OracleDbType.Decimal, this.CreditContractInfo.CrdLimit, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_creditor_type", OracleDbType.Decimal, this.CreditContractInfo.CreditorType, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_borrower", OracleDbType.Decimal, this.CreditContractInfo.CreditorBorrower, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_type", OracleDbType.Decimal, this.CreditContractInfo.CreditType, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_term", OracleDbType.Decimal, this.CreditContractInfo.CreditTerm, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_prepay", OracleDbType.Decimal, this.CreditContractInfo.CreditPrepay, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_name", OracleDbType.Varchar2, this.CreditContractInfo.CreditName, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_add_agree", OracleDbType.Varchar2, this.CreditContractInfo.CreditAddAgree, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_percent_nbu_type", OracleDbType.Decimal, this.CreditContractInfo.CreditPercent, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_percent_nbu_info", OracleDbType.Varchar2, this.CreditContractInfo.CreditNbuInfo, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_r_agree_date", OracleDbType.Date, this.CreditContractInfo.CreditAgreeDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_r_agree_no", OracleDbType.Varchar2, this.CreditContractInfo.CreditAgreeNum, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_prev_doc_key", OracleDbType.Decimal, this.CreditContractInfo.CreditDocKey, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_prev_reestr_attr", OracleDbType.Varchar2, this.CreditContractInfo.CreditPrevReestrAttr, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_ending_date_indiv", OracleDbType.Date, this.CreditContractInfo.CrdIndEndDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_parent_ch_data", OracleDbType.Varchar2, this.CreditContractInfo.CreditCrdParentChData, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_ending_date", OracleDbType.Date, this.CreditContractInfo.CreditEndingDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_f503_reason", OracleDbType.Decimal, this.CreditContractInfo.F503_Reason, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_f503_state", OracleDbType.Decimal, this.CreditContractInfo.F503_State, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_f503_note", OracleDbType.Varchar2, this.CreditContractInfo.F503_Note, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_f504_reason", OracleDbType.Decimal, this.CreditContractInfo.F504_Reason, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_f504_note", OracleDbType.Varchar2, this.CreditContractInfo.F504_Note, ParameterDirection.Input);
                    }

                    oraCmd.CommandText = @"begin cim_mgr.update_contract(:p_contr_id,
                                                                :p_num,
                                                                :p_subnum,
                                                                :p_s,
                                                                :p_benef_id,
                                                                :p_open_date,
                                                                :p_close_date,
                                                                :p_comments,
                                                                :p_bic,
                                                                :p_b010" + addParams + "); end;";
                    oraCmd.ExecuteNonQuery();
                }
                // Insert
                else
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, ParameterDirection.Output);

                    oraCmd.Parameters.Add("p_contr_type", OracleDbType.Decimal, this.ContrType, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_rnk", OracleDbType.Decimal, this.Rnk, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_num", OracleDbType.Varchar2, this.Num, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_subnum", OracleDbType.Varchar2, this.SubNum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, this.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, this.Kv, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_benef_id", OracleDbType.Decimal, this.BenefId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_open_date", OracleDbType.Date, this.DateOpen, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_close_date", OracleDbType.Date, this.DateClose, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, this.Comments, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_bic", OracleDbType.Varchar2, this.BeneficiarBankInfo.BicCodeId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_b010", OracleDbType.Varchar2, this.BeneficiarBankInfo.BankB010, ParameterDirection.Input);
                    if (this.ContrType == 0 || this.ContrType == 1)
                    {
                        addParams = ",:p_spec_id, :p_subject_id, :p_without_acts, :p_deadline, :p_txt_subject";
                        oraCmd.Parameters.Add("p_spec_id", OracleDbType.Decimal, this.TradeContractInfo.SpecId, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_subject_id", OracleDbType.Decimal, this.TradeContractInfo.SubjectId, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_without_acts", OracleDbType.Decimal, this.TradeContractInfo.WithoutActs, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_deadline", OracleDbType.Decimal, this.TradeContractInfo.Deadline, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_txt_subject", OracleDbType.Varchar2, this.TradeContractInfo.SubjectText, ParameterDirection.Input);
                    }

                    else if (this.ContrType == 2)
                    {
                        addParams = ",NULL,NULL,NULL,NULL,NULL,:p_percent_nbu,:p_s_limit,:p_creditor_type,:p_credit_borrower,:p_credit_type,:p_credit_term,:p_credit_prepay," +
                            ":p_name,:p_add_agree,:p_percent_nbu_type,:p_percent_nbu_info,:p_r_agree_date,:p_r_agree_no,:p_prev_doc_key,:p_prev_reestr_attr,:p_ending_date_indiv,:p_parent_ch_data,:p_ending_date,:p_f503_reason,:p_f503_state,:p_f503_note, :p_f504_reason, :p_f504_note";//,:p_margin,:p_tranche_no,:p_tr_summa,:p_tr_currency,:p_tr_rate_name,:p_tr_rate,:p_credit_opertype,:p_credit_operdate";
                        oraCmd.Parameters.Add("p_percent_nbu", OracleDbType.Decimal, this.CreditContractInfo.NbuPercent, ParameterDirection.Input);
                        //oraCmd.Parameters.Add("p_percent", OracleDbType.Decimal, this.CreditContractInfo.DefPercent, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_s_limit", OracleDbType.Decimal, this.CreditContractInfo.CrdLimit, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_creditor_type", OracleDbType.Decimal, this.CreditContractInfo.CreditorType, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_borrower", OracleDbType.Decimal, this.CreditContractInfo.CreditorBorrower, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_type", OracleDbType.Decimal, this.CreditContractInfo.CreditType, ParameterDirection.Input);
                        //oraCmd.Parameters.Add("p_credit_period", OracleDbType.Decimal, this.CreditContractInfo.CreditPeriod, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_term", OracleDbType.Decimal, this.CreditContractInfo.CreditTerm, ParameterDirection.Input);
                        //oraCmd.Parameters.Add("p_credit_method", OracleDbType.Decimal, this.CreditContractInfo.CreditMethod, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_prepay", OracleDbType.Decimal, this.CreditContractInfo.CreditPrepay, ParameterDirection.Input);

                        oraCmd.Parameters.Add("p_name", OracleDbType.Varchar2, this.CreditContractInfo.CreditName, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_add_agree", OracleDbType.Varchar2, this.CreditContractInfo.CreditAddAgree, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_percent_nbu_type", OracleDbType.Decimal, this.CreditContractInfo.CreditPercent, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_percent_nbu_info", OracleDbType.Varchar2, this.CreditContractInfo.CreditNbuInfo, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_r_agree_date", OracleDbType.Date, this.CreditContractInfo.CreditAgreeDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_r_agree_no", OracleDbType.Varchar2, this.CreditContractInfo.CreditAgreeNum, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_prev_doc_key", OracleDbType.Decimal, this.CreditContractInfo.CreditDocKey, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_prev_reestr_attr", OracleDbType.Varchar2, this.CreditContractInfo.CreditPrevReestrAttr, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_ending_date_indiv", OracleDbType.Date, this.CreditContractInfo.CrdIndEndDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_parent_ch_data", OracleDbType.Varchar2, this.CreditContractInfo.CreditCrdParentChData, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_ending_date", OracleDbType.Date, this.CreditContractInfo.CreditEndingDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_f503_reason", OracleDbType.Decimal, this.CreditContractInfo.F503_Reason, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_f503_state", OracleDbType.Decimal, this.CreditContractInfo.F503_State, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_f503_note", OracleDbType.Varchar2, this.CreditContractInfo.F503_Note, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_f504_reason", OracleDbType.Decimal, this.CreditContractInfo.F504_Reason, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_f504_note", OracleDbType.Varchar2, this.CreditContractInfo.F504_Note, ParameterDirection.Input);
                    }

                    oraCmd.CommandText = @"begin cim_mgr.create_contract (:p_contr_id,:p_contr_type,:p_rnk,:p_num,:p_subnum,:p_s,:p_kv,:p_benef_id,:p_open_date,:p_close_date,:p_comments,:p_bic,:p_b010 " + addParams + "); end;";
                    oraCmd.ExecuteNonQuery();
                    this.ContrId = Convert.ToDecimal(oraCmd.Parameters["p_contr_id"].Value.ToString());
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return this.ContrId.Value;
        }

        public ResultData CheckContractSanctions(decimal? contrId)
        {
            ResultData res = new ResultData();
            InitConnection();
            HttpContext.Current.Session.Remove(Constants.StateKeys.ContrTaxCode);
            HttpContext.Current.Session.Remove(Constants.StateKeys.ContrBenefName);
            try
            {
                oraCmd = oraConn.CreateCommand();
                if (contrId.HasValue)
                {
                    oraCmd.Parameters.Add("res", OracleDbType.Decimal, ParameterDirection.Output);
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, contrId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, "".PadRight(1000), ParameterDirection.InputOutput);
                    oraCmd.Parameters.Add("p_benef", OracleDbType.Varchar2, "".PadRight(1000), ParameterDirection.InputOutput);
                    oraCmd.CommandText = "declare res number; begin :res := cim_mgr.check_contract_sanction(:p_contr_id, bankdate, :p_okpo, :p_benef); end;";
                    oraCmd.ExecuteNonQuery();

                    res.Code = Convert.ToInt32(((OracleDecimal)oraCmd.Parameters["res"].Value).Value);
                    HttpContext.Current.Session[Constants.StateKeys.ContrTaxCode] = Convert.ToString(oraCmd.Parameters["p_okpo"].Value);
                    HttpContext.Current.Session[Constants.StateKeys.ContrBenefName] = Convert.ToString(oraCmd.Parameters["p_benef"].Value);
                    //res.DataObj = new string[2] { Convert.ToString(oraCmd.Parameters["p_okpo"].Value), Convert.ToString(oraCmd.Parameters["p_benef"].Value) };
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return res;
        }


        public decimal ApproveNbuContract()
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                if (this.ContrId.HasValue)
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_prev_doc_key", OracleDbType.Decimal, this.CreditContractInfo.CreditDocKey, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_r_agree_date", OracleDbType.Date, this.CreditContractInfo.CreditAgreeDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_r_agree_no", OracleDbType.Varchar2, this.CreditContractInfo.CreditAgreeNum, ParameterDirection.Input);
                    oraCmd.CommandText = "begin cim_mgr.confirm_nbu_registration(:p_contr_id, :p_prev_doc_key, :p_r_agree_date, :p_r_agree_no); end;";
                    oraCmd.ExecuteNonQuery();
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return this.ContrId.Value;
        }

        public decimal DiscardNbuContract()
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                if (this.ContrId.HasValue)
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                    oraCmd.CommandText = "begin cim_mgr.cancel_nbu_registration(:p_contr_id); end;";
                    oraCmd.ExecuteNonQuery();
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return this.ContrId.Value;
        }

        public string ContractToXml(decimal? contrId, string agreeFile, string letterFile, string old_mfo, string old_oblcode, string old_bank_code, string old_bank_oblcode, string old_prev_doc_key, string old_r_agree_date, string old_r_agree_no)
        {
            string result = string.Empty;
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();

                oraCmd.Parameters.Add("res", OracleDbType.Varchar2, "".PadRight(4000), ParameterDirection.InputOutput);

                oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, contrId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_agree_fname", OracleDbType.Varchar2, agreeFile, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_letter_fname", OracleDbType.Varchar2, letterFile, ParameterDirection.Input);

                oraCmd.Parameters.Add("p_old_mfo", OracleDbType.Varchar2, old_mfo, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_old_oblcode", OracleDbType.Varchar2, old_oblcode, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_old_bank_code", OracleDbType.Varchar2, old_bank_code, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_old_bank_oblcode", OracleDbType.Varchar2, old_bank_oblcode, ParameterDirection.Input);

                oraCmd.Parameters.Add("p_prev_doc_key", OracleDbType.Varchar2, old_prev_doc_key, ParameterDirection.Input);
                if (!string.IsNullOrEmpty(old_r_agree_date))
                    oraCmd.Parameters.Add("p_r_agree_date", OracleDbType.Date, Convert.ToDateTime(old_r_agree_date, cinfo), ParameterDirection.Input);
                else
                    oraCmd.Parameters.Add("p_r_agree_date", OracleDbType.Date, DBNull.Value, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_r_agree_no", OracleDbType.Varchar2, old_r_agree_no, ParameterDirection.Input);

                oraCmd.CommandText = "declare res varchar2(4000); begin :res := cim_mgr.nbu_registration(:p_contr_id, :p_agree_fname, :p_letter_fname,:p_old_mfo, :p_old_oblcode,:p_old_bank_code,:p_old_bank_oblcode, :p_prev_doc_key, :p_r_agree_date, :p_r_agree_no); end;";
                oraCmd.ExecuteNonQuery();
                result = Convert.ToString(oraCmd.Parameters["res"].Value);
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return result;
        }

        public ResultData CheckBind(BindClass bindInfo)
        {
            ResultData result = new ResultData();
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                if (this.ContrId.HasValue)
                {
                    oraCmd.Parameters.Add("res", OracleDbType.Varchar2, 4000, result, ParameterDirection.InputOutput);

                    oraCmd.Parameters.Add("p_doc_kind", OracleDbType.Decimal, bindInfo.DocKind, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_payment_type", OracleDbType.Decimal, bindInfo.PaymentType, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_pay_flag", OracleDbType.Decimal, bindInfo.PayFlag, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_direct", OracleDbType.Decimal, bindInfo.Direct, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_ref", OracleDbType.Decimal, bindInfo.DocRef, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, this.ContrId.Value, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s_vp", OracleDbType.Decimal, bindInfo.SumVP, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comiss", OracleDbType.Decimal, bindInfo.SumComm, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_rate", OracleDbType.Decimal, bindInfo.Rate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s_vc", OracleDbType.Decimal, bindInfo.SumVC, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_valdate", OracleDbType.Date, bindInfo.DocDateVal, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_subject", OracleDbType.Decimal, bindInfo.Subject, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_service_code", OracleDbType.Varchar2, bindInfo.ServiceCode, ParameterDirection.Input);

                    oraCmd.CommandText = "declare res varchar2(4000); begin :res := cim_mgr.check_bound(:p_doc_kind,:p_payment_type,:p_pay_flag,:p_direct,:p_ref,:p_contr_id,:p_s_vp,:p_comiss,:p_rate,:p_s_vc,:p_valdate,:p_subject,:p_service_code); end;";
                    oraCmd.ExecuteNonQuery();
                    result.CodeMajor = 0;
                    if (oraCmd.Parameters["res"].Value.ToString() != "null")
                    {
                        result.CodeMajor = 1;
                        result.Message = Convert.ToString(oraCmd.Parameters["res"].Value);
                    }

                    // перевірка необхідності привязки акта цінової експертизи
                    /*ape_requed(p_contr_id in number, --id контракту 
                    p_service_code in varchar2, --Код класифікатора послуг
                    p_val_date in date, --Дата валютування
                    p_kv in number, --Код валюти платежу
                    p_s_vp in number, --Сума у валюті платежу
                    p_s_vk in number --Сума у валюті контракту
                   ) return number --0 - акт не потрібний, 1 -  повідомлення про перевірку наявності актів, 2 - акт обов'язковий*/
                    result.CodeMinor = 0;
                    if (bindInfo.Direct == 1 && bindInfo.Subject == 1 && this.ContrType == 1)
                    {
                        oraCmd.Parameters.Clear();
                        oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, this.ContrId.Value,
                            ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_service_code", OracleDbType.Varchar2, bindInfo.ServiceCode,
                            ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_val_date", OracleDbType.Date, bindInfo.DocDateVal,
                            ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, bindInfo.DocKv, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_s_vp", OracleDbType.Decimal, bindInfo.SumVP, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_s_vk", OracleDbType.Decimal, bindInfo.SumVC, ParameterDirection.Input);
                        oraCmd.CommandText =
                            "select cim_mgr.ape_requed(:p_contr_id,:p_service_code, :p_val_date, :p_kv, :p_s_vp, :p_s_vk) from dual";
                    }
                    result.CodeMinor = Convert.ToInt32(oraCmd.ExecuteScalar());
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return result;
        }


        public decimal SaveBind(BindClass bindInfo)
        {
            decimal boundId = 0;
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                if (this.ContrId.HasValue)
                {
                    /*
                        p_payment_type in number, -- Тип платежу
                        p_pay_flag in number, -- Класифікатор платежу (0 ..6)
                        p_direct in number, -- Напрям платежу (0 - вхідні, 1 - вихідні)
                        p_ref in number, -- Референс документу
                        p_contr_id in number, -- Ідентифікатор контракту
                        p_s_vp in number, -- Сума прив'язки у валюті платежу
                        p_comiss in number, -- Комісія
                        p_rate in number, -- Курс
                        p_s_vc in number, -- Сума прив'язки у валюті контракту
                        p_top_id in number, -- Тип операції
                        p_comments in varchar2 :=null,-- Коментар
                        p_subject in number := null, -- Предмет оплати (0 - товари, 1 - послуги)
                        p_service_code in varchar2 :=null, -- Код класифікатора послуг 
                        ----------------------------------------------------------------------
                        p_kv in number :=null, -- Код валюти платежу
                        p_bank_date in date :=null, --  Банківська дата створення
                        p_val_date in date :=null, -- Дата валютування
                        p_details in varchar2 :=null, -- Призначення платежу
                        ----------------------------------------------------------------------
                        p_rnk in number :=null, -- RNK  резидента
                        p_benef_id in number :=null -- id нерезидента
                    */
                    oraCmd.Parameters.Add("boundId", OracleDbType.Decimal, boundId, ParameterDirection.InputOutput);

                    oraCmd.Parameters.Add("p_payment_type", OracleDbType.Decimal, bindInfo.PaymentType, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_pay_flag", OracleDbType.Decimal, bindInfo.PayFlag, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_direct", OracleDbType.Decimal, bindInfo.Direct, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_ref", OracleDbType.Decimal, bindInfo.DocRef, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, this.ContrId.Value, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s_vp", OracleDbType.Decimal, bindInfo.SumVP, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comiss", OracleDbType.Decimal, bindInfo.SumComm, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_rate", OracleDbType.Decimal, bindInfo.Rate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s_vc", OracleDbType.Decimal, bindInfo.SumVC, ParameterDirection.Input);

                    oraCmd.Parameters.Add("p_top_id", OracleDbType.Decimal, bindInfo.OpType, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, bindInfo.Comment, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_subject", OracleDbType.Decimal, bindInfo.Subject, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_service_code", OracleDbType.Varchar2, bindInfo.ServiceCode, ParameterDirection.Input);

                    string addPars = "";
                    if (bindInfo.IsFantom)
                    {
                        oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, bindInfo.DocKv, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_val_date", OracleDbType.Date, bindInfo.DocDateVal, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_details", OracleDbType.Varchar2, bindInfo.DocDetails, ParameterDirection.Input);
                        addPars = ", :p_kv, :p_val_date, :p_details";
                    }
                    else
                        addPars = ",null, null, null";

                    if (bindInfo.Rnk.HasValue && bindInfo.BenefId.HasValue)
                    {
                        addPars += ",:p_rnk, :p_benef_id, :p_c_num, :p_c_date";
                        oraCmd.Parameters.Add("p_rnk", OracleDbType.Decimal, bindInfo.Rnk, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_benef_id", OracleDbType.Decimal, bindInfo.BenefId, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_c_num", OracleDbType.Varchar2, bindInfo.JContrNum, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_c_date", OracleDbType.Date, bindInfo.JContrDate, ParameterDirection.Input);
                    }

                    oraCmd.CommandText = "declare boundId number; begin :boundId := cim_mgr.bound_payment(:p_payment_type,:p_pay_flag,:p_direct,:p_ref,:p_contr_id,:p_s_vp,:p_comiss,:p_rate,:p_s_vc,:p_top_id,:p_comments,:p_subject,:p_service_code" + addPars + "); end;";
                    oraCmd.ExecuteNonQuery();
                    if (oraCmd.Parameters["boundId"].Value != null)
                    {
                        boundId = Convert.ToDecimal(oraCmd.Parameters["boundId"].Value.ToString());
                        // все ок, помещаем в сессию документ для визирования
                        if (!bindInfo.IsFantom)
                            HttpContext.Current.Session[Constants.StateKeys.CurrRef] = bindInfo.DocRef;
                    }

                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                if (oraConn.State != ConnectionState.Closed)
                {
                    oraConn.Close();
                    oraConn.Dispose();
                }
            }
            return boundId;
        }

        public decimal SaveDeclBind(BindClass bindInfo)
        {
            decimal boundId = 0;
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                if (this.ContrId.HasValue)
                {
                    /*
                       p_vmd_type in number, -- Тип ВМД
                       p_ref in number, -- Референс ВМД
                       p_contr_id in number, -- Ідентифікатор контракту
                       p_s_vt in number, -- Сума прив'язки у валюті товару
                       p_rate in number, -- Курс
                       p_s_vc in number, -- Сума прив'язки у валюті контракту
                       p_doc_date in date :=null, -- Дата паперового носія
                       p_comments in varchar2 :=null,-- Коментар
                       ---------------------------------------------------------------------
                       p_num varchar2 :=null, --номер акта
                       p_kv in number :=null, -- Код валюти товару
                       p_allow_date in date :=null -- Дата дозволу
                    */
                    oraCmd.Parameters.Add("boundId", OracleDbType.Decimal, boundId, ParameterDirection.InputOutput);

                    oraCmd.Parameters.Add("p_vmd_type", OracleDbType.Decimal, bindInfo.PaymentType, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_ref", OracleDbType.Decimal, bindInfo.DocRef, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, this.ContrId.Value, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s_vt", OracleDbType.Decimal, bindInfo.SumVP, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_rate", OracleDbType.Decimal, bindInfo.Rate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s_vc", OracleDbType.Decimal, bindInfo.SumVC, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_doc_date", OracleDbType.Date, bindInfo.DocDateVal, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, bindInfo.Comment, ParameterDirection.Input);

                    string addPars = "";
                    if (bindInfo.IsFantom)
                    {
                        oraCmd.Parameters.Add("p_num", OracleDbType.Varchar2, bindInfo.DocNum, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, bindInfo.DocKv, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_allow_date", OracleDbType.Date, bindInfo.AllowDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_file_name", OracleDbType.Varchar2, bindInfo.FileName, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_file_date", OracleDbType.Date, bindInfo.FileDate, ParameterDirection.Input);
                        addPars = ", :p_num, :p_kv, :p_allow_date, null, null, null, null, :p_file_name, :p_file_date";
                    }
                    else
                        addPars = ",null, null, null";

                    oraCmd.CommandText = "declare boundId number; begin :boundId := cim_mgr.bound_vmd(:p_vmd_type,:p_ref,:p_contr_id,:p_s_vt,:p_rate,:p_s_vc,:p_doc_date,:p_comments" + addPars + "); end;";
                    oraCmd.ExecuteNonQuery();
                    if (oraCmd.Parameters["boundId"].Value != null)
                    {
                        boundId = Convert.ToDecimal(oraCmd.Parameters["boundId"].Value.ToString());
                    }

                    if (bindInfo.VmdId.HasValue)
                    {
                        oraCmd.Parameters.Clear();
                        oraCmd.Parameters.Add("p_vmd_id", OracleDbType.Decimal, bindInfo.VmdId, ParameterDirection.Input);
                        oraCmd.CommandText = "update customs_decl set cim_boundsum=null where cim_id=:p_vmd_id";
                        oraCmd.ExecuteNonQuery();
                    }
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                if (oraConn.State != ConnectionState.Closed)
                {
                    oraConn.Close();
                    oraConn.Dispose();
                }
            }
            return boundId;
        }


        public void UnboundPayment(decimal boundId, int typePayment, string comment)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_payment_type", OracleDbType.Decimal, typePayment, ParameterDirection.Input);
                oraCmd.Parameters.Add("boundId", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, comment, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.unbound_payment";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void UnboundDecl(decimal boundId, int typeDecl, string comment)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_vmd_type", OracleDbType.Decimal, typeDecl, ParameterDirection.Input);
                oraCmd.Parameters.Add("boundId", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, comment, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.unbound_vmd";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void LinkDecl(decimal typeId, decimal boundId, int typeDecl, decimal declId, decimal sum)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                /*
                   p_payment_type in number, --тип платежу
                   p_payment_id in number, --id платежу
                   p_vmd_type in number, --тип ВМД
                   p_vmd_id in number, --id ВМД
                   p_s in number -- Сума
                 */
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_payment_type", OracleDbType.Decimal, typeId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_payment_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_vmd_type", OracleDbType.Decimal, typeDecl, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_vmd_id", OracleDbType.Decimal, declId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, sum, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.vmd_link";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void UnLinkDecl(decimal typeId, decimal boundId, int typeDecl, decimal declId, string comment)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                /*
                   p_payment_type in number, --тип платежу
                   p_payment_id in number, --id платежу
                   p_vmd_type in number, --тип ВМД
                   p_vmd_id in number, --id ВМД
                   p_s in number -- Сума
                 */
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_payment_type", OracleDbType.Decimal, typeId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_payment_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_vmd_type", OracleDbType.Decimal, typeDecl, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_vmd_id", OracleDbType.Decimal, declId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_comm", OracleDbType.Varchar2, comment, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.vmd_unlink";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }


        public void LinkConclusion(decimal typeId, decimal boundId, decimal conclId, decimal sum)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_cnc_id", OracleDbType.Decimal, conclId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_type", OracleDbType.Decimal, typeId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, sum, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.conclusion_link";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void UnLinkConclusion(decimal typeId, decimal boundId, decimal conclId)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_cnc_id", OracleDbType.Decimal, conclId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_type", OracleDbType.Decimal, typeId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.conclusion_unlink";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void LinkLicense(decimal typeId, decimal boundId, decimal licenseId, decimal sum, decimal kv, decimal sumVP)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_license_id", OracleDbType.Decimal, licenseId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_type", OracleDbType.Decimal, typeId, ParameterDirection.Input);

                if (boundId < 0)
                {
                    oraCmd.Parameters.Add("p_doc_id", OracleDbType.Decimal, null, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, kv, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s_pl", OracleDbType.Decimal, sumVP, ParameterDirection.Input);
                }
                else
                {
                    oraCmd.Parameters.Add("p_doc_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, sum, ParameterDirection.Input);
                }
                //p_kv in number :=null, --Код валюти
                //p_s_pl in number :=null -- Сума платежу


                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.license_link";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void UnLinkLicense(decimal typeId, decimal boundId, decimal licenseId)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_cnc_id", OracleDbType.Decimal, licenseId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_type", OracleDbType.Decimal, typeId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.license_unlink";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void LinkApe(decimal typeId, decimal boundId, decimal apeId, decimal? sum, string serviceCode)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_license_id", OracleDbType.Decimal, apeId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_type", OracleDbType.Decimal, typeId, ParameterDirection.Input);
                if (boundId < 0)
                {
                    oraCmd.Parameters.Add("p_doc_id", OracleDbType.Decimal, DBNull.Value, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_service_code", OracleDbType.Varchar2, serviceCode, ParameterDirection.Input);
                }
                else
                    oraCmd.Parameters.Add("p_doc_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                //

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.ape_link";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void UnLinkApe(decimal typeId, decimal boundId, decimal apeId)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_ape_id", OracleDbType.Decimal, apeId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_type", OracleDbType.Decimal, typeId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.ape_unlink";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void UpdateConclusion(ConclusionClass cc)
        {
            InitConnection();
            try
            {
                /*
                             p_contr_id number, -- id контракту
                             p_org_id number, -- id органу, який дав висновок
                             p_out_num varchar2, -- Вихідний номер висньовку
                             p_out_date date, -- Вихідна дата висньовку
                             p_kv number, --Код валюти
                             p_s number, --Сума
                             p_begin_date date, --Початок строку
                             p_end_date date --Кінець строку
                 */
                oraCmd = oraConn.CreateCommand();
                if (string.IsNullOrEmpty(cc.RowId)) // insert
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, cc.ContrId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_org_id", OracleDbType.Decimal, cc.OrgId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_out_num", OracleDbType.Varchar2, cc.OutNum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_out_date", OracleDbType.Date, cc.OutDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, cc.Kv, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, cc.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_begin_date", OracleDbType.Date, cc.BeginDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_end_date", OracleDbType.Date, cc.EndDate, ParameterDirection.Input);

                    oraCmd.CommandType = CommandType.StoredProcedure;
                    oraCmd.CommandText = "cim_mgr.create_conclusion";
                    oraCmd.ExecuteNonQuery();
                }
                else
                {
                    oraCmd.Parameters.Add("p_conclusion_id", OracleDbType.Decimal, cc.RowId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_org_id", OracleDbType.Decimal, cc.OrgId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_out_num", OracleDbType.Varchar2, cc.OutNum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_out_date", OracleDbType.Date, cc.OutDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, cc.Kv, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, cc.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_begin_date", OracleDbType.Date, cc.BeginDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_end_date", OracleDbType.Date, cc.EndDate, ParameterDirection.Input);

                    oraCmd.CommandType = CommandType.StoredProcedure;
                    oraCmd.CommandText = "cim_mgr.update_conclusion";
                    oraCmd.ExecuteNonQuery();
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void UpdateApe(ApeClass ac)
        {
            InitConnection();
            try
            {
                /*
                         p_contr_id number, -- id контракту
                         p_num varchar2, -- Номер акту цінової експертизи
                         p_kv number, -- Код валюти
                         p_s number, -- Сума
                         p_rate number, --Курс
                         p_s_vk number, --Сума у валюті контракту
                         p_begin_date date, -- Дата акту цінової експертизи
                         p_end_date date, -- Дата, до якої дійсний акт
                         p_comments varchar2 -- Примітка
                 */
                oraCmd = oraConn.CreateCommand();
                if (string.IsNullOrEmpty(ac.RowId)) // insert
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, ac.ContrId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_num", OracleDbType.Varchar2, ac.Num, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, ac.Kv, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, ac.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_rate", OracleDbType.Decimal, ac.Rate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s_vk", OracleDbType.Decimal, ac.SumVK, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_begin_date", OracleDbType.Date, ac.BeginDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_end_date", OracleDbType.Date, ac.EndDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, ac.Comment, ParameterDirection.Input);

                    oraCmd.CommandType = CommandType.StoredProcedure;
                    oraCmd.CommandText = "cim_mgr.create_ape";
                    oraCmd.ExecuteNonQuery();
                }
                else
                {
                    oraCmd.Parameters.Add("p_ape_id", OracleDbType.Decimal, ac.RowId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_num", OracleDbType.Varchar2, ac.Num, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, ac.Kv, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, ac.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_rate", OracleDbType.Decimal, ac.Rate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s_vk", OracleDbType.Decimal, ac.SumVK, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_begin_date", OracleDbType.Date, ac.BeginDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_end_date", OracleDbType.Date, ac.EndDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, ac.Comment, ParameterDirection.Input);

                    oraCmd.CommandType = CommandType.StoredProcedure;
                    oraCmd.CommandText = "cim_mgr.update_ape";
                    oraCmd.ExecuteNonQuery();
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void DeleteConclusion(decimal ConclId)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_conclusion_id", OracleDbType.Decimal, ConclId, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.delete_conclusion";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }


        public void DeleteApe(decimal ApeId)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_ape_id", OracleDbType.Decimal, ApeId, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.delete_ape";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void SaveBorgReason(int boundType, decimal boundId, int docType, decimal borgReason)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_borgReason", OracleDbType.Decimal, borgReason, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_boundId", OracleDbType.Decimal, boundId, ParameterDirection.Input);

                string tabName = "cim_vmd_bound";

                if (boundType == 0)
                {
                    if (docType == 0)
                        tabName = "cim_payments_bound";
                    else
                        tabName = "cim_fantoms_bound";
                }
                else if (boundType == 1)
                {
                    if (docType == 0)
                        tabName = "cim_vmd_bound";
                    else
                        tabName = "cim_act_bound";
                }

                oraCmd.CommandText = "update " + tabName + " set borg_reason = :p_borgReason where bound_id=:p_boundId";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public string SaveRegDate(int contrType, int boundType, decimal boundId, int docType, int docId, string regDate)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("res", OracleDbType.Varchar2, "".PadRight(4000), ParameterDirection.InputOutput);
                oraCmd.Parameters.Add("p_contr_type", OracleDbType.Decimal, contrType, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_kind", OracleDbType.Decimal, boundType, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_type", OracleDbType.Decimal, docType, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_doc_id", OracleDbType.Decimal, boundId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_date", OracleDbType.Date, Convert.ToDateTime(regDate, cinfo), ParameterDirection.Input);

                oraCmd.CommandText = "cim_mgr.change_reg_date";
                oraCmd.CommandText = "declare res varchar2(4000); begin :res := cim_mgr.change_reg_date(:p_contr_type, :p_doc_kind, :p_doc_type,:p_doc_id, :p_date); end;";
                oraCmd.ExecuteNonQuery();
                return Convert.ToString(oraCmd.Parameters["res"].Value);
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public string SaveLinkRegDate(decimal paymentType, decimal paymentId, decimal vmdType, decimal vmdId, string regDate)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("res", OracleDbType.Varchar2, "".PadRight(4000), ParameterDirection.InputOutput);
                oraCmd.Parameters.Add("p_payment_type", OracleDbType.Decimal, paymentType, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_payment_id", OracleDbType.Decimal, paymentId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_vmd_type", OracleDbType.Decimal, vmdType, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_vmd_id", OracleDbType.Decimal, vmdId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_date", OracleDbType.Date, Convert.ToDateTime(regDate, cinfo), ParameterDirection.Input);

                oraCmd.CommandText = "declare res varchar2(4000); begin :res := cim_mgr.change_link_date(:p_payment_type, :p_payment_id, :p_vmd_type,:p_vmd_id, :p_date); end;";
                oraCmd.ExecuteNonQuery();
                return Convert.ToString(oraCmd.Parameters["res"].Value);
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void DeleteUnboundApe(decimal apeId)
        {
            InitConnection();
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_ape_id", OracleDbType.Decimal, apeId, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.Text;
                oraCmd.CommandText = "delete from cim_ape_link where ape_id=:p_ape_id and payment_id is null and fantom_id is null";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        #endregion
    }

    /// <summary>
    /// Класс торгового контракта
    /// </summary>
    public class TradeContractClass : CimManager
    {
        #region Constructors
        public TradeContractClass() { }
        public TradeContractClass(decimal? contrId)
        {
            this.ContrId = contrId;
            readTradeContract();
        }
        #endregion

        #region Properties
        public decimal? ContrId { get; set; }
        /// <summary>
        /// Спеціалізація контракту
        /// </summary>
        public decimal SpecId { get; set; }
        /// <summary>
        /// Предмет контракту
        /// </summary>
        public decimal SubjectId { get; set; }

        /// <summary>
        /// Робота без актів цінової експертизи
        /// </summary>
        public decimal WithoutActs { get; set; }
        /// <summary>
        /// Контрольний строк
        /// </summary>
        public decimal Deadline { get; set; }
        /// <summary>
        /// Уточнення предмету контракту
        /// </summary>
        public string SubjectText { get; set; }

        public decimal SumPl { get; set; }
        public decimal ZPl { get; set; }
        public decimal SumPLAfter { get; set; }
        public decimal SumVmd { get; set; }
        public decimal ZVmd { get; set; }
        public decimal SumVmdAfter { get; set; }

        public bool HasMultiValutsPayments { get; set; }
        public bool HasMultiValutsDecls { get; set; }
        #endregion

        #region Private methods
        private void readTradeContract()
        {
            InitConnection();
            if (this.ContrId.HasValue)
            {
                try
                {
                    oraCmd = oraConn.CreateCommand();
                    oraCmd.Parameters.Add("contrId", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                    oraCmd.CommandText = @"select contr_id, spec_id, subject_id, deadline, trade_desc, s_pl, z_pl, s_pl_after, s_vmd, z_vmd, s_vmd_after, 
                                                  (select 1 from dual where exists (select 1 from v_cim_trade_payments where v_pl != a.kv and contr_id=a.contr_id)) hmp,
                                                  (select 1 from dual where exists (select 1 from v_cim_bound_vmd      where vt != a.kv   and contr_id=a.contr_id)) hmd, without_acts from v_cim_trade_contracts a where contr_id=:contrId";

                    oraRdr = oraCmd.ExecuteReader();
                    if (oraRdr.Read())
                    {
                        this.ContrId = Convert.ToDecimal(oraRdr.GetValue(0));
                        if (!oraRdr.IsDBNull(1))
                            this.SpecId = Convert.ToDecimal(oraRdr.GetValue(1));
                        if (!oraRdr.IsDBNull(2))
                            this.SubjectId = Convert.ToDecimal(oraRdr.GetValue(2));
                        if (!oraRdr.IsDBNull(3))
                            this.Deadline = Convert.ToDecimal(oraRdr.GetValue(3));
                        this.SubjectText = Convert.ToString(oraRdr.GetValue(4));

                        if (!oraRdr.IsDBNull(5))
                            this.SumPl = Convert.ToDecimal(oraRdr.GetValue(5));
                        if (!oraRdr.IsDBNull(6))
                            this.ZPl = Convert.ToDecimal(oraRdr.GetValue(6));
                        if (!oraRdr.IsDBNull(7))
                            this.SumPLAfter = Convert.ToDecimal(oraRdr.GetValue(7));
                        if (!oraRdr.IsDBNull(8))
                            this.SumVmd = Convert.ToDecimal(oraRdr.GetValue(8));
                        if (!oraRdr.IsDBNull(9))
                            this.ZVmd = Convert.ToDecimal(oraRdr.GetValue(9));
                        if (!oraRdr.IsDBNull(10))
                            this.SumVmdAfter = Convert.ToDecimal(oraRdr.GetValue(10));

                        // проверка на мультивалютность платежей и деклараций
                        this.HasMultiValutsPayments = !oraRdr.IsDBNull(11);
                        this.HasMultiValutsDecls = !oraRdr.IsDBNull(12);
                        if (!oraRdr.IsDBNull(13))
                            this.WithoutActs = Convert.ToDecimal(oraRdr.GetValue(13));
                    }
                    else
                        this.ContrId = null;

                    oraRdr.Close();
                }
                catch (System.Exception ex)
                {
                    SaveException(ex);
                    throw ex;
                }
                finally
                {
                    oraCmd.Dispose();
                    oraConn.Close();
                    oraConn.Dispose();
                }
            }
        }
        #endregion
    }


    /// <summary>
    /// Класс кредитного контракта
    /// </summary>
    public class CreditContractClass : CimManager
    {
        #region Constructors
        public CreditContractClass() { }
        public CreditContractClass(decimal? contrId)
        {
            this.ContrId = contrId;
            readCreditContract(false);
        }
        public CreditContractClass(decimal? contrId, bool buildCredGraph)
        {
            this.ContrId = contrId;
            readCreditContract(buildCredGraph);
        }

        #endregion

        #region Properties
        public decimal? ContrId { get; set; }
        public decimal NbuPercent { get; set; }

        /// <summary>
        /// Ліміт заборгованості
        /// </summary>
        public decimal? CrdLimit { get; set; }
        public decimal? CreditorType { get; set; }
        public decimal? CreditType { get; set; }
        //public decimal CreditPeriod { get; set; }
        public decimal? CreditorBorrower { get; set; }

        public decimal CreditTerm { get; set; }
        //public decimal CreditMethod { get; set; }
        public decimal? CreditPrepay { get; set; }
        public string CreditName { get; set; }
        public string CreditAddAgree { get; set; }
        public decimal CreditPercent { get; set; }
        public string CreditNbuInfo { get; set; }
        public DateTime? CreditAgreeDate;
        public string CreditAgreeDateS
        {
            get { return (CreditAgreeDate.HasValue) ? (CreditAgreeDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) CreditAgreeDate = DateTime.Parse(value, cinfo); }
        }
        public string CreditAgreeNum { get; set; }
        public decimal? CreditDocKey { get; set; }
        public string CreditPrevReestrAttr { get; set; }
        public DateTime? CrdIndEndDate;
        public string CrdIndEndDateS
        {
            get { return (CrdIndEndDate.HasValue) ? (CrdIndEndDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) CrdIndEndDate = DateTime.Parse(value, cinfo); }
        }
        public string CreditCrdParentChData { get; set; }
        public DateTime? CreditEndingDate;
        public string CreditEndingDateS
        {
            get { return (CreditEndingDate.HasValue) ? (CreditEndingDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) CreditEndingDate = DateTime.Parse(value, cinfo); }
        }
        public decimal? CreditMargin { get; set; }
        public string CreditTranshNum { get; set; }
        public decimal? CreditTranshSum { get; set; }
        public decimal? CreditTranshCurr { get; set; }
        public string CreditTranshRatName { get; set; }
        public decimal? CreditTranshRat { get; set; }
        public decimal? CreditOperType { get; set; }
        public DateTime? CreditOperDate;
        public string CreditOperDateS
        {
            get { return (CreditOperDate.HasValue) ? (CreditOperDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) CreditOperDate = DateTime.Parse(value, cinfo); }
        }

        /// <summary>
        /// Загальна сума надходжень
        /// </summary>
        public decimal? TotalRevenue { get; set; }
        public decimal? TotalOutlay { get; set; }
        public decimal? FutureRevenue { get; set; }
        /// <summary>
        /// Прострочена заборгованість по тілу 
        /// </summary>
        public decimal? DelayScoreBody { get; set; }
        /// <summary>
        /// Прострочена заборгованість по відсотках  
        /// </summary>
        public decimal? DelayScoreInterest { get; set; }
        /// <summary>
        /// Заборгованість по тілу кредиту
        /// </summary>
        public decimal? CreditDueBody { get; set; }
        /// <summary>
        /// Виплачені відсотки
        /// </summary>
        public decimal? CreditInterestPaid { get; set; }
        /// <summary>
        /// Заборгованість по відсотках
        /// </summary>
        public decimal? CreditIntArrears { get; set; }
        /// <summary>
        /// Нараховані відсотки
        /// </summary>
        public decimal? AccruedInterest { get; set; }
        /// <summary>
        /// Розраховані відсотки за ставкою НБУ
        /// </summary>
        public decimal? CalcRateNbu { get; set; }
        /// <summary>
        /// Сума дод. платежів
        /// </summary>
        public decimal? AddPaymentsSum { get; set; }

        public decimal? F503_Reason { get; set; }
        public decimal? F503_State { get; set; }
        public string F503_Note { get; set; }

        public decimal? F504_Reason { get; set; }

        public string F504_Note { get; set; }

        public DataTable CredGraphTable { get; set; }

        #endregion

        #region Private methods
        private void readCreditContract(bool buildCredGraph)
        {
            InitConnection();
            if (this.ContrId.HasValue)
            {
                try
                {
                    if (buildCredGraph)
                    {
                        oraCmd = oraConn.CreateCommand();
                        oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                        oraCmd.CommandText = "begin cim_mgr.create_credgraph(:p_contr_id); end;";
                        oraCmd.ExecuteNonQuery();

                        oraCmd.Parameters.Clear();
                        //oraCmd.CommandText = "select dat,psvt/100 psvt,pspt/100 pspt,pzt/100 pzt,psp/100 psp,pzp/100 pzp,psd/100 psd,rsvt/100 rsvt,rspt/100 rspt,rzt/100 rzt,rsp/100 rsp,rzp/100 rzp,rsvp/100 rsvp,rsd/100 rsd, rzpnbu/100 rzpnbu from cim_credgraph_tmp order by dat";
                        oraCmd.CommandText = "select dat, sign(bankdate-dat) flag, rsnt/100 rsnt, psnt/100 psnt, rspt/100 rspt, pspt/100 pspt, zt/100 zt, dt/100 dt, dp/100 dp, svp/100 svp, sd/100 sd, smp/100 smp,smps/100 smps, zp/100 zp,	sp/100 sp, zpnbu/100 zpnbu from cim_credgraph_tmp order by dat";
                        OracleDataAdapter da = new OracleDataAdapter(oraCmd);
                        this.CredGraphTable = new DataTable();
                        da.Fill(this.CredGraphTable);
                    }

                    oraCmd = oraConn.CreateCommand();
                    oraCmd.Parameters.Add("contrId", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                    oraCmd.CommandText = @"select contr_id,percent_nbu, s_limit, creditor_type, credit_type, credit_term, credit_prepay, name, add_agree, percent_nbu_type, percent_nbu_info, r_agree_date, r_agree_no, prev_ddoc_key, prev_reestr_attr, ending_date_indiv, parent_ch_data, ending_date, s_in_pl, s_out_pl, s_in_pl-s_out_pl, s_v_pr, z_pr, s_v_pr+z_pr,s_pr_nbu,s_dod_pl, f503_reason, f503_state, f503_note, s-s_in_pl, borrower_id, f504_reason, f504_note from v_cim_credit_contracts where contr_id=:contrId";

                    oraRdr = oraCmd.ExecuteReader();
                    if (oraRdr.Read())
                    {
                        this.ContrId = Convert.ToDecimal(oraRdr.GetValue(0));
                        this.NbuPercent = Convert.ToDecimal(oraRdr.GetValue(1));
                        if (!oraRdr.IsDBNull(2))
                            this.CrdLimit = Convert.ToDecimal(oraRdr.GetValue(2));
                        if (!oraRdr.IsDBNull(3))
                            this.CreditorType = Convert.ToDecimal(oraRdr.GetValue(3));
                        if (!oraRdr.IsDBNull(4))
                            this.CreditType = Convert.ToDecimal(oraRdr.GetValue(4));
                        this.CreditTerm = Convert.ToDecimal(oraRdr.GetValue(5));
                        if (!oraRdr.IsDBNull(6))
                            this.CreditPrepay = Convert.ToDecimal(oraRdr.GetValue(6));

                        this.CreditName = Convert.ToString(oraRdr.GetValue(7));
                        this.CreditAddAgree = Convert.ToString(oraRdr.GetValue(8));
                        this.CreditPercent = Convert.ToDecimal(oraRdr.GetValue(9));
                        this.CreditNbuInfo = Convert.ToString(oraRdr.GetValue(10));
                        if (!oraRdr.IsDBNull(11))
                            CreditAgreeDate = Convert.ToDateTime(oraRdr.GetValue(11));
                        CreditAgreeNum = Convert.ToString(oraRdr.GetValue(12));
                        if (!oraRdr.IsDBNull(13))
                            CreditDocKey = Convert.ToDecimal(oraRdr.GetValue(13));
                        CreditPrevReestrAttr = Convert.ToString(oraRdr.GetValue(14));
                        if (!oraRdr.IsDBNull(15))
                            CrdIndEndDate = Convert.ToDateTime(oraRdr.GetValue(15));
                        CreditCrdParentChData = Convert.ToString(oraRdr.GetValue(16));
                        if (!oraRdr.IsDBNull(17))
                            CreditEndingDate = Convert.ToDateTime(oraRdr.GetValue(17));
                        if (!oraRdr.IsDBNull(18))
                            TotalRevenue = Convert.ToDecimal(oraRdr.GetValue(18)); // s_in_pl
                        if (!oraRdr.IsDBNull(19))
                            TotalOutlay = Convert.ToDecimal(oraRdr.GetValue(19)); // s_out_pl
                        if (!oraRdr.IsDBNull(20))
                            CreditDueBody = Convert.ToDecimal(oraRdr.GetValue(20)); // s_in_pl-s_out_pl
                        if (!oraRdr.IsDBNull(21))
                            CreditInterestPaid = Convert.ToDecimal(oraRdr.GetValue(21)); // s_v_pr
                        if (!oraRdr.IsDBNull(22))
                            CreditIntArrears = Convert.ToDecimal(oraRdr.GetValue(22));  // z_pr
                        if (!oraRdr.IsDBNull(23))
                            AccruedInterest = Convert.ToDecimal(oraRdr.GetValue(23)); // s_v_pr+z_pr
                        if (!oraRdr.IsDBNull(24))
                            CalcRateNbu = Convert.ToDecimal(oraRdr.GetValue(24)); //  s_pr_nbu
                        if (!oraRdr.IsDBNull(25))
                            AddPaymentsSum = Convert.ToDecimal(oraRdr.GetValue(25)); // s_dod_pl
                        if (!oraRdr.IsDBNull(26))
                            F503_Reason = Convert.ToDecimal(oraRdr.GetValue(26)); // 
                        if (!oraRdr.IsDBNull(27))
                            F503_State = Convert.ToDecimal(oraRdr.GetValue(27));
                        if (!oraRdr.IsDBNull(28))
                            F503_Note = Convert.ToString(oraRdr.GetValue(28));
                        if (!oraRdr.IsDBNull(29))
                            FutureRevenue = Convert.ToDecimal(oraRdr.GetValue(29)); // s - s_in_pl
                        if (!oraRdr.IsDBNull(30))
                            CreditorBorrower = Convert.ToDecimal(oraRdr.GetValue(30)); // borrower
                        if (!oraRdr.IsDBNull(31))
                            F504_Reason = Convert.ToDecimal(oraRdr.GetValue(31)); // f504_reason
                        if (!oraRdr.IsDBNull(32))
                            F504_Note = Convert.ToString(oraRdr.GetValue(32)); // f504_note
                    }
                    else
                        this.ContrId = null;

                    if (buildCredGraph)
                    {
                        oraCmd.Parameters.Clear();
                        oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, ContrId, ParameterDirection.Input);

                        oraCmd.Parameters.Add("p_percent", OracleDbType.Decimal, 0, ParameterDirection.InputOutput);
                        oraCmd.Parameters.Add("p_percent_nbu", OracleDbType.Decimal, 0, ParameterDirection.InputOutput);
                        oraCmd.Parameters.Add("p_percent_over", OracleDbType.Decimal, 0, ParameterDirection.InputOutput);
                        oraCmd.Parameters.Add("p_credit_over", OracleDbType.Decimal, 0, ParameterDirection.InputOutput);

                        oraCmd.CommandText =
                            "begin cim_mgr.get_credcontract_info(:p_contr_id, bankdate, :p_percent,:p_percent_nbu,:p_percent_over,:p_credit_over); end;";
                        oraCmd.ExecuteNonQuery();

                        AccruedInterest = Convert.ToDecimal(((OracleDecimal)oraCmd.Parameters["p_percent"].Value).Value);
                        CalcRateNbu = Convert.ToDecimal(((OracleDecimal)oraCmd.Parameters["p_percent_nbu"].Value).Value);
                        DelayScoreInterest = Convert.ToDecimal(((OracleDecimal)oraCmd.Parameters["p_percent_over"].Value).Value);
                        DelayScoreBody = Convert.ToDecimal(((OracleDecimal)oraCmd.Parameters["p_credit_over"].Value).Value);
                    }

                    oraRdr.Close();
                }
                catch (System.Exception ex)
                {
                    SaveException(ex);
                    throw ex;
                }
                finally
                {
                    oraCmd.Dispose();
                    oraConn.Close();
                    oraConn.Dispose();
                }
            }
        }
        #endregion
        #region Public methods
        public void UpdatePayment(CreditPaymentClass cpc)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                if (string.IsNullOrEmpty(cpc.RowId)) // insert
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, cpc.ContrId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_dat", OracleDbType.Date, Convert.ToDateTime(cpc.Date, cinfo), ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, cpc.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_pay_flag", OracleDbType.Decimal, cpc.PayFlag, ParameterDirection.Input);
                    oraCmd.CommandText = "begin cim_mgr.create_credgraph_payment(:p_contr_id, :p_dat, :p_s, :p_pay_flag); end;";
                    oraCmd.ExecuteNonQuery();
                }
                else // update
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, cpc.ContrId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_row_id", OracleDbType.Varchar2, cpc.RowId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_dat", OracleDbType.Date, Convert.ToDateTime(cpc.Date, cinfo), ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, cpc.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_pay_flag", OracleDbType.Decimal, cpc.PayFlag, ParameterDirection.Input);
                    oraCmd.CommandText = "begin cim_mgr.update_credgraph_payment(:p_contr_id, :p_row_id, :p_dat, :p_s, :p_pay_flag); end;";
                    oraCmd.ExecuteNonQuery();
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void DeletePayment(decimal? contrId, string rowId)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, contrId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_row_id", OracleDbType.Varchar2, rowId, ParameterDirection.Input);
                oraCmd.CommandText = "begin cim_mgr.delete_credgraph_payment(:p_contr_id, :p_row_id); end;";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }


        public void UpdatePeriod(CreditPeriodClass cpc)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                if (string.IsNullOrEmpty(cpc.RowId)) // insert
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, cpc.ContrId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_end_date", OracleDbType.Date, Convert.ToDateTime(cpc.EndDate, cinfo), ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_cr_method", OracleDbType.Decimal, cpc.CrMethodId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_payment_period", OracleDbType.Decimal, cpc.CrPaymentPeriodId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_z", OracleDbType.Decimal, cpc.Z, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_adaptive", OracleDbType.Decimal, cpc.AdaptiveId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_percent", OracleDbType.Decimal, cpc.Percent, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_percent_nbu", OracleDbType.Decimal, cpc.PercentNbu, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_percent_base", OracleDbType.Decimal, cpc.PercentBaseId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_percent_period", OracleDbType.Decimal, cpc.PercentPeriodId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_payment_delay", OracleDbType.Decimal, cpc.PaymentDelay, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_percent_delay", OracleDbType.Decimal, cpc.PercentDelay, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_get_day", OracleDbType.Decimal, cpc.GetDayId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_pay_day", OracleDbType.Decimal, cpc.PayDayId, ParameterDirection.Input);

                    oraCmd.CommandText = "begin cim_mgr.create_credgraph_period(:p_contr_id, :p_end_date, :p_cr_method, :p_payment_period,:p_z,:p_adaptive, :p_percent,:p_percent_nbu,:p_percent_base,:p_percent_period,:p_payment_delay,:p_percent_delay,:p_get_day,:p_pay_day); end;";
                    oraCmd.ExecuteNonQuery();
                }
                else // update
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, cpc.ContrId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_row_id", OracleDbType.Varchar2, cpc.RowId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_end_date", OracleDbType.Date, Convert.ToDateTime(cpc.EndDate, cinfo), ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_cr_method", OracleDbType.Decimal, cpc.CrMethodId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_payment_period", OracleDbType.Decimal, cpc.CrPaymentPeriodId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_z", OracleDbType.Decimal, cpc.Z, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_adaptive", OracleDbType.Decimal, cpc.AdaptiveId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_percent", OracleDbType.Decimal, cpc.Percent, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_percent_nbu", OracleDbType.Decimal, cpc.PercentNbu, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_percent_base", OracleDbType.Decimal, cpc.PercentBaseId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_percent_period", OracleDbType.Decimal, cpc.PercentPeriodId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_payment_delay", OracleDbType.Decimal, cpc.PaymentDelay, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_percent_delay", OracleDbType.Decimal, cpc.PercentDelay, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_get_day", OracleDbType.Decimal, cpc.GetDayId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_pay_day", OracleDbType.Decimal, cpc.PayDayId, ParameterDirection.Input);

                    oraCmd.CommandText = "begin cim_mgr.update_credgraph_period(:p_contr_id, :p_row_id, :p_end_date, :p_cr_method, :p_payment_period,:p_z,:p_adaptive, :p_percent,:p_percent_nbu,:p_percent_base,:p_percent_period,:p_payment_delay,:p_percent_delay,:p_get_day,:p_pay_day); end;";
                    oraCmd.ExecuteNonQuery();
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void DeletePeriod(decimal? contrId, string rowId)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, contrId, ParameterDirection.Input);
                oraCmd.Parameters.Add("p_row_id", OracleDbType.Varchar2, rowId, ParameterDirection.Input);
                oraCmd.CommandText = "begin cim_mgr.delete_credgraph_period(:p_contr_id, :p_row_id); end;";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public DataTable BuildCredGraph(decimal? contrId)
        {
            DataTable data = new DataTable();
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, contrId, ParameterDirection.Input);
                oraCmd.CommandText = "begin cim_mgr.create_credgraph(:p_contr_id); end;";
                oraCmd.ExecuteNonQuery();

                oraCmd.Parameters.Clear();
                oraCmd.CommandText = "select dat,psvt/100 psvt,pspt/100 pspt,pzt/100 pzt,psp/100 psp,pzp/100 pzp,psd/100 psd,rsvt/100 rsvt,rspt/100 rspt,rzt/100 rzt,rsp/100 rsp,rzp/100 rzp,rsvp/100 rsvp,rsd/100 rsd, rzpnbu/100 rzpnbu from cim_credgraph_tmp order by dat";
                OracleDataAdapter da = new OracleDataAdapter(oraCmd);
                da.Fill(data);
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return data;
        }

        #endregion
    }


    /// <summary>
    /// Класс кредитного контракта
    /// </summary>
    public class OtherContractClass : CimManager
    {
        #region Constructors
        public OtherContractClass() { }
        public OtherContractClass(decimal? contrId)
        {
            this.ContrId = contrId;
            readOtherContract();
        }
        #endregion

        #region Properties
        public decimal? ContrId { get; set; }
        public decimal? SumIn { get; set; }
        public decimal? SumOut { get; set; }
        public decimal? SumAddIn { get; set; }
        public decimal? SumAddOut { get; set; }

        #endregion

        #region Private methods
        private void readOtherContract()
        {
            InitConnection();
            if (this.ContrId.HasValue)
            {
                try
                {
                    oraCmd = oraConn.CreateCommand();
                    oraCmd.Parameters.Add("contrId", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                    oraCmd.CommandText = @"select nvl(sum(case when direct=0 and pay_flag=0 then s_vk else 0 end),0) as s_in, nvl(sum(case when direct=1 and pay_flag=0 then s_vk else 0 end),0) as s_out, nvl(sum(case when direct=0 and pay_flag=1 then s_vk else 0 end),0) as s_dod_in, nvl(sum(case when direct=1 and pay_flag=1 then s_vk else 0 end),0) as s_dod_out from v_cim_bound_payments where contr_id=:contrId";

                    oraRdr = oraCmd.ExecuteReader();
                    if (oraRdr.Read())
                    {
                        if (!oraRdr.IsDBNull(0))
                            this.SumIn = Convert.ToDecimal(oraRdr.GetValue(0));
                        if (!oraRdr.IsDBNull(1))
                            this.SumOut = Convert.ToDecimal(oraRdr.GetValue(1));
                        if (!oraRdr.IsDBNull(2))
                            this.SumAddIn = Convert.ToDecimal(oraRdr.GetValue(2));
                        if (!oraRdr.IsDBNull(3))
                            this.SumAddOut = Convert.ToDecimal(oraRdr.GetValue(3));
                    }
                    oraRdr.Close();
                }
                catch (System.Exception ex)
                {
                    SaveException(ex);
                    throw ex;
                }
                finally
                {
                    oraCmd.Dispose();
                    oraConn.Close();
                    oraConn.Dispose();
                }
            }
        }
        #endregion
    }

    /// <summary>
    /// Класс контрагента
    /// </summary>
    public class ClientClass : CimManager
    {
        #region Variables


        #endregion
        #region Constructors
        public ClientClass() { }
        public ClientClass(decimal? rnk, string okpo)
        {
            this.Rnk = rnk;
            this.Okpo = okpo;
            readClient();
        }
        #endregion

        #region Properties
        public decimal? Rnk { get; set; }
        public byte CustType { get; set; }
        public string Okpo { get; set; }
        public string Nd { get; set; }
        public string Nmk { get; set; }
        public string NmkK { get; set; }
        public string Ved { get; set; }
        public string VedName { get; set; }
        #endregion
        #region Private methods

        private void readClient()
        {
            InitConnection();
            if (this.Rnk.HasValue || !string.IsNullOrEmpty(this.Okpo))
            {
                try
                {
                    oraCmd = oraConn.CreateCommand();
                    oraCmd.CommandText = "select c.rnk, c.okpo, c.nmk, c.nmkk, c.custtype, c.nd, c.ved, v.name from customer c, ved v where c.ved=v.ved(+) and";
                    if (this.Rnk.HasValue)
                    {
                        oraCmd.Parameters.Add("rnk", OracleDbType.Decimal, this.Rnk, ParameterDirection.Input);
                        oraCmd.CommandText += " c.rnk=:rnk";
                    }
                    else
                    {
                        oraCmd.Parameters.Add("okpo", OracleDbType.Varchar2, this.Okpo, ParameterDirection.Input);
                        oraCmd.CommandText += " c.okpo like '%'||:okpo||'%'";
                    }

                    oraRdr = oraCmd.ExecuteReader();
                    if (oraRdr.Read())
                    {
                        this.Rnk = Convert.ToDecimal(oraRdr.GetValue(0));
                        this.Okpo = Convert.ToString(oraRdr.GetValue(1));
                        this.Nmk = Convert.ToString(oraRdr.GetValue(2));
                        this.NmkK = Convert.ToString(oraRdr.GetValue(3));
                        this.CustType = Convert.ToByte(oraRdr.GetValue(4));
                        this.Nd = Convert.ToString(oraRdr.GetValue(5));
                        this.Ved = Convert.ToString(oraRdr.GetValue(6));
                        this.VedName = Convert.ToString(oraRdr.GetValue(7));
                        // если больше 1 строки
                        if (oraRdr.Read())
                            this.Rnk = -1;
                    }
                    else
                        this.Rnk = null;
                    oraRdr.Close();
                }
                catch (System.Exception ex)
                {
                    SaveException(ex);
                    throw ex;
                }
                finally
                {
                    oraCmd.Dispose();
                    oraConn.Close();
                    oraConn.Dispose();
                }
            }
        }

        #endregion
        #region Public methods
        #endregion
    }

    /// <summary>
    /// Класс бенефициара
    /// </summary>
    public class BeneficiarClass : CimManager
    {
        #region Variables


        #endregion
        #region Constructors
        public BeneficiarClass() { }
        public BeneficiarClass(decimal id)
        {
            this.BenefId = id;
            readBeneficiare();
        }
        #endregion

        #region Properties
        public decimal? BenefId { get; set; }
        public decimal? CountryId { get; set; }
        public string CountryName { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Comment { get; set; }
        #endregion
        #region Private methods

        private void readBeneficiare()
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "select benef_id, benef_name, country_id, country_name, benef_adr, comments, delete_date from v_cim_beneficiaries where benef_id=:benef_id";
                oraCmd.Parameters.Add("benef_id", OracleDbType.Decimal, this.BenefId, ParameterDirection.Input);

                oraRdr = oraCmd.ExecuteReader();
                if (oraRdr.Read())
                {
                    this.BenefId = Convert.ToDecimal(oraRdr.GetValue(0));
                    this.Name = Convert.ToString(oraRdr.GetValue(1));
                    if (!oraRdr.IsDBNull(2))
                        this.CountryId = Convert.ToDecimal(oraRdr.GetValue(2));
                    this.CountryName = Convert.ToString(oraRdr.GetValue(3));
                    this.Address = Convert.ToString(oraRdr.GetValue(4));
                    this.Comment = Convert.ToString(oraRdr.GetValue(5));
                }
                else
                    this.BenefId = null;
                oraRdr.Close();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        #endregion
        #region Public methods

        public List<BeneficiarClass> GetBeneficiares()
        {
            List<BeneficiarClass> list = new List<BeneficiarClass>();
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "select b.benef_id, b.benef_name, b.country_id, c.name, b.benef_adr, b.comments from cim_beneficiaries b, country c where b.country_id=c.country";

                oraRdr = oraCmd.ExecuteReader();
                while (oraRdr.Read())
                {
                    BeneficiarClass bi = new BeneficiarClass();
                    bi.BenefId = Convert.ToDecimal(oraRdr.GetValue(0));
                    bi.Name = Convert.ToString(oraRdr.GetValue(1));
                    bi.CountryId = Convert.ToDecimal(oraRdr.GetValue(2));
                    bi.CountryName = Convert.ToString(oraRdr.GetValue(3));
                    bi.Address = Convert.ToString(oraRdr.GetValue(4));
                    bi.Comment = Convert.ToString(oraRdr.GetValue(5));
                    list.Add(bi);
                }
                oraRdr.Close();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }

            return list;
        }

        #endregion
    }

    /// <summary>
    /// Класс банка бенефициара
    /// </summary>
    public class BeneficiarBankClass : CimManager
    {
        #region Constructors

        public BeneficiarBankClass()
        {
            BicCodeId = string.Empty;
            BankName = string.Empty;
            BankB010 = string.Empty;
            FetchMoreRows = false;
        }
        public BeneficiarBankClass(string bicCodeId, string bankB010)
        {
            this.BicCodeId = bicCodeId;
            this.BankB010 = bankB010;
            readBeneficiareBank();
        }
        #endregion

        #region Properties
        public string BicCodeId { get; set; }
        public string BankB010 { get; set; }
        public string BankName { get; set; }
        public bool FetchMoreRows { get; set; }
        #endregion

        #region Private methods

        private void readBeneficiareBank()
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "select bic,  b010, bank_name from v_cim_bank_code where bic=:BicCodeId";
                oraCmd.Parameters.Add("BicCodeId", OracleDbType.Varchar2, this.BicCodeId, ParameterDirection.Input);
                if (!string.IsNullOrEmpty(this.BankB010))
                {
                    oraCmd.CommandText += " and b010=:BankB010";
                    oraCmd.Parameters.Add("BankB010", OracleDbType.Varchar2, this.BankB010, ParameterDirection.Input);
                }
                else
                    oraCmd.CommandText += " and b010 is null";

                oraRdr = oraCmd.ExecuteReader();
                if (oraRdr.Read())
                {
                    BicCodeId = Convert.ToString(oraRdr.GetValue(0));
                    BankName = Convert.ToString(oraRdr.GetValue(2));
                    BankB010 = Convert.ToString(oraRdr.GetValue(1));
                    if (oraRdr.Read())
                        this.FetchMoreRows = true;
                }
                else
                {
                    BicCodeId = null;
                    BankName = string.Empty;
                    BankB010 = string.Empty;
                }

                oraRdr.Close();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        #endregion
        #region Public methods

        #endregion
    }


    /// <summary>
    /// Класс лицензий
    /// </summary>
    public class LicenseClass : CimManager
    {
        #region Variables

        #endregion
        #region Constructors
        public LicenseClass() { }
        public LicenseClass(decimal id)
        {
            this.LicenseId = id;
            readLicense();
        }
        #endregion

        #region Properties
        public decimal? LicenseId { get; set; }
        public decimal? LicType { get; set; }
        public decimal Kv { get; set; }
        public decimal Sum { get; set; }
        public string Num { get; set; }
        public string Okpo { get; set; }
        public DateTime? BeginDate;
        public string BeginDateS
        {
            get { return (BeginDate.HasValue) ? (BeginDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) BeginDate = DateTime.Parse(value, cinfo); }
        }
        public DateTime? EndDate;
        public string EndDateS
        {
            get { return (EndDate.HasValue) ? (EndDate.Value.ToString("dd/MM/yyyy")) : (string.Empty); }
            set { if (!string.IsNullOrEmpty(value)) EndDate = DateTime.Parse(value, cinfo); }
        }

        public string Comment { get; set; }
        #endregion
        #region Private methods

        private void readLicense()
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.CommandText = "select license_id, okpo, num, type, kv, s, begin_date, end_date, comments from v_cim_license where license_id=:license_id";
                oraCmd.Parameters.Add("license_id", OracleDbType.Decimal, this.LicenseId, ParameterDirection.Input);

                oraRdr = oraCmd.ExecuteReader();
                if (oraRdr.Read())
                {
                    this.LicenseId = Convert.ToDecimal(oraRdr.GetValue(0));
                    this.Okpo = Convert.ToString(oraRdr.GetValue(1));
                    this.Num = Convert.ToString(oraRdr.GetValue(2));
                    if (!oraRdr.IsDBNull(3))
                        this.LicType = Convert.ToDecimal(oraRdr.GetValue(3));
                    this.Kv = Convert.ToDecimal(oraRdr.GetValue(4));
                    this.Sum = Convert.ToDecimal(oraRdr.GetValue(5));
                    if (!oraRdr.IsDBNull(6))
                        BeginDate = Convert.ToDateTime(oraRdr.GetValue(6));
                    if (!oraRdr.IsDBNull(7))
                        EndDate = Convert.ToDateTime(oraRdr.GetValue(7));
                    this.Comment = Convert.ToString(oraRdr.GetValue(8));
                }
                else
                    this.LicenseId = null;
                oraRdr.Close();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        #endregion
        #region Public methods

        public void UpdateLicense()
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                if (!this.LicenseId.HasValue) // insert
                {
                    /*
                     create_license 
                            (p_okpo varchar2, -- id контракту
                             p_num varchar2, -- Номер ліцензії
                             p_type number, -- Тип ліцензії
                             p_kv number, -- Код валюти
                             p_s number, -- Сума
                             p_begin_date date, -- Дата ліцензії
                             p_end_date date, -- Дата, до якої дійсна ліцензія
                             p_comments varchar2 -- Примітка
                            );
                    */
                    oraCmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, this.Okpo, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_num", OracleDbType.Varchar2, this.Num, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_type", OracleDbType.Decimal, this.LicType, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, this.Kv, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, this.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_begin_date", OracleDbType.Date, this.BeginDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_end_date", OracleDbType.Date, this.EndDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, this.Comment, ParameterDirection.Input);

                    oraCmd.CommandType = CommandType.StoredProcedure;
                    oraCmd.CommandText = "cim_mgr.create_license";
                    oraCmd.ExecuteNonQuery();
                }
                else // update
                {
                    oraCmd.Parameters.Add("p_license_id", OracleDbType.Decimal, this.LicenseId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_num", OracleDbType.Varchar2, this.Num, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_type", OracleDbType.Decimal, this.LicType, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, this.Kv, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, this.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_begin_date", OracleDbType.Date, this.BeginDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_end_date", OracleDbType.Date, this.EndDate, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, this.Comment, ParameterDirection.Input);

                    oraCmd.CommandType = CommandType.StoredProcedure;
                    oraCmd.CommandText = "cim_mgr.update_license";
                    oraCmd.ExecuteNonQuery();
                }
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        public void DeleteLicense(decimal? LicenseId)
        {
            InitConnection();
            try
            {
                oraCmd = oraConn.CreateCommand();
                oraCmd.Parameters.Add("p_license_id", OracleDbType.Decimal, LicenseId, ParameterDirection.Input);

                oraCmd.CommandType = CommandType.StoredProcedure;
                oraCmd.CommandText = "cim_mgr.delete_license";
                oraCmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                SaveException(ex);
                throw ex;
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
        }

        #endregion
    }
}