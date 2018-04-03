using System;
using System.Globalization;
using System.Collections;
using System.Web.Script.Serialization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;
using System.Data;
using System.Collections.Generic;
using System.Web;

namespace barsroot.cim
{
    public struct JqGridResults
    {
        public int page;
        public int total;
        public int records;
        public List<string[]> rows;
    }

    public class CimManager
    {
        protected CimManager()
        {
            cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cinfo.DateTimeFormat.DateSeparator = "/";

        }
        protected CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");

        protected OracleConnection oraConn;
        protected OracleCommand oraCmd;
        protected OracleDataReader oraRdr;
    }
    /// <summary>
    /// Класс контрагента
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
        public string Num { get; set; }
        public decimal? Rnk { get; set; }
        public decimal Kv { get; set; }
        public decimal? Sum { get; set; }
        public decimal BenefId { get; set; }
        public int StatusId { get; set; }
        public string StatusName { get; set; }
        public string Comments { get; set; }
        public string Branch { get; set; }
        public string BranchName { get; set; }
        public ClientClass ClientInfo;
        public BeneficiarClass BeneficiarInfo;
        public CreditContractClass CreditContractInfo;
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
            oraConn = OraConnector.Handler.UserConnection;
            if (this.ContrId.HasValue)
            {
                try
                {
                    oraCmd = oraConn.CreateCommand();
                    oraCmd.Parameters.Add("contrId", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                    oraCmd.CommandText = "select contr_id,contr_type,num,rnk,open_date,close_date,kv,s,benef_id,status_id,status_name,comments, branch, branch_name from v_cim_all_contracts where contr_id=:contrId";

                    oraRdr = oraCmd.ExecuteReader();
                    if (oraRdr.Read())
                    {
                        this.ContrId = Convert.ToDecimal(oraRdr.GetValue(0));
                        this.ContrType = Convert.ToByte(oraRdr.GetValue(1));
                        this.Num = Convert.ToString(oraRdr.GetValue(2));
                        this.Rnk = Convert.ToDecimal(oraRdr.GetValue(3));
                        this.ClientInfo = new ClientClass(this.Rnk, null);
                        this.DateOpen = Convert.ToDateTime(oraRdr.GetValue(4));
                        if (!oraRdr.IsDBNull(5))
                            this.DateClose = Convert.ToDateTime(oraRdr.GetValue(5));
                        this.Kv = Convert.ToDecimal(oraRdr.GetValue(6));
                        this.Sum = Convert.ToDecimal(oraRdr.GetValue(7));
                        this.BenefId = Convert.ToDecimal(oraRdr.GetValue(8));
                        this.BeneficiarInfo = new BeneficiarClass(this.BenefId);
                        this.StatusId = Convert.ToInt32(oraRdr.GetValue(9));
                        this.StatusName = Convert.ToString(oraRdr.GetValue(10));
                        this.Comments = Convert.ToString(oraRdr.GetValue(11));
                        this.Branch = Convert.ToString(oraRdr.GetValue(12));
                        this.BranchName = Convert.ToString(oraRdr.GetValue(13));

                        // Кредитний
                        if (this.ContrType == 2)
                            this.CreditContractInfo = new CreditContractClass(this.ContrId);
                    }
                    else
                        this.ContrId = null;

                    oraRdr.Close();
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
            oraConn = OraConnector.Handler.UserConnection;
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
            oraConn = OraConnector.Handler.UserConnection;
            string addParams = string.Empty;
            try
            {
                oraCmd = oraConn.CreateCommand();
                // Update 
                if (this.ContrId.HasValue)
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_num", OracleDbType.Varchar2, this.Num, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, this.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_benef_id", OracleDbType.Decimal, this.BenefId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_open_date", OracleDbType.Date, this.DateOpen, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_close_date", OracleDbType.Date, this.DateClose, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, this.Comments, ParameterDirection.Input);
                    if (this.ContrType == 2)
                    {
                        addParams = ",NULL,NULL,NULL,NULL,:p_percent_nbu,:p_percent,:p_s_limit,:p_creditor_type,:p_credit_type,:p_credit_period,:p_credit_term,:p_credit_method,:p_credit_prepay," +
                        ":p_name,:p_add_agree,:p_percent_nbu_type,:p_percent_nbu_info,:p_r_agree_date,:p_r_agree_no,:p_prev_doc_key,:p_ending_date_indiv,:p_parent_ch_data,:p_ending_date,:p_margin,:p_tranche_no,:p_tr_summa,:p_tr_currency,:p_tr_rate_name,:p_tr_rate,:p_credit_opertype,:p_credit_operdate";

                        oraCmd.Parameters.Add("p_percent_nbu", OracleDbType.Decimal, this.CreditContractInfo.NbuPercent, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_percent", OracleDbType.Decimal, this.CreditContractInfo.DefPercent, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_s_limit", OracleDbType.Decimal, this.CreditContractInfo.CrdLimit, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_creditor_type", OracleDbType.Decimal, this.CreditContractInfo.CreditorType, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_type", OracleDbType.Decimal, this.CreditContractInfo.CreditType, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_period", OracleDbType.Decimal, this.CreditContractInfo.CreditPeriod, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_term", OracleDbType.Decimal, this.CreditContractInfo.CreditTerm, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_method", OracleDbType.Decimal, this.CreditContractInfo.CreditMethod, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_prepay", OracleDbType.Decimal, this.CreditContractInfo.CreditPrepay, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_name", OracleDbType.Varchar2, this.CreditContractInfo.CreditName, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_add_agree", OracleDbType.Varchar2, this.CreditContractInfo.CreditAddAgree, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_percent_nbu_type", OracleDbType.Decimal, this.CreditContractInfo.CreditPercent, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_percent_nbu_info", OracleDbType.Varchar2, this.CreditContractInfo.CreditNbuInfo, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_r_agree_date", OracleDbType.Date, this.CreditContractInfo.CreditAgreeDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_r_agree_no", OracleDbType.Varchar2, this.CreditContractInfo.CreditAgreeNum, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_prev_doc_key", OracleDbType.Decimal, this.CreditContractInfo.CreditDocKey, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_ending_date_indiv", OracleDbType.Date, this.CreditContractInfo.CrdIndEndDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_parent_ch_data", OracleDbType.Varchar2, this.CreditContractInfo.CreditCrdParentChData, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_ending_date", OracleDbType.Date, this.CreditContractInfo.CreditEndingDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_margin", OracleDbType.Decimal, this.CreditContractInfo.CreditMargin, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_tranche_no", OracleDbType.Varchar2, this.CreditContractInfo.CreditTranshNum, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_tr_summa", OracleDbType.Decimal, this.CreditContractInfo.CreditTranshSum, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_tr_currency", OracleDbType.Decimal, this.CreditContractInfo.CreditTranshCurr, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_tr_rate_name", OracleDbType.Varchar2, this.CreditContractInfo.CreditTranshRatName, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_tr_rate", OracleDbType.Decimal, this.CreditContractInfo.CreditTranshRat, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_opertype", OracleDbType.Decimal, this.CreditContractInfo.CreditOperType, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_operdate", OracleDbType.Date, this.CreditContractInfo.CreditOperDate, ParameterDirection.Input);
                    }

                    oraCmd.CommandText = @"begin cim_mgr.update_contract(:p_contr_id,
                                                                :p_num,
                                                                :p_s,
                                                                :p_benef_id,
                                                                :p_open_date,
                                                                :p_close_date,
                                                                :p_comments " + addParams + "); end;";
                    oraCmd.ExecuteNonQuery();
                }
                // Insert
                else
                {
                    oraCmd.Parameters.Add("p_contr_id", OracleDbType.Decimal, ParameterDirection.Output);

                    oraCmd.Parameters.Add("p_contr_type", OracleDbType.Decimal, this.ContrType, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_rnk", OracleDbType.Decimal, this.Rnk, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_num", OracleDbType.Varchar2, this.Num, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_s", OracleDbType.Decimal, this.Sum, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_kv", OracleDbType.Decimal, this.Kv, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_benef_id", OracleDbType.Decimal, this.BenefId, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_open_date", OracleDbType.Date, this.DateOpen, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_close_date", OracleDbType.Date, this.DateClose, ParameterDirection.Input);
                    oraCmd.Parameters.Add("p_comments", OracleDbType.Varchar2, this.Comments, ParameterDirection.Input);
                    if (this.ContrType == 2)
                    {
                        addParams = ",NULL,NULL,NULL,NULL,:p_percent_nbu,:p_percent,:p_s_limit,:p_creditor_type,:p_credit_type,:p_credit_period,:p_credit_term,:p_credit_method,:p_credit_prepay," +
                            ":p_name,:p_add_agree,:p_percent_nbu_type,:p_percent_nbu_info,:p_r_agree_date,:p_r_agree_no,:p_prev_doc_key,:p_ending_date_indiv,:p_parent_ch_data,:p_ending_date,:p_margin,:p_tranche_no,:p_tr_summa,:p_tr_currency,:p_tr_rate_name,:p_tr_rate,:p_credit_opertype,:p_credit_operdate";
                        oraCmd.Parameters.Add("p_percent_nbu", OracleDbType.Decimal, this.CreditContractInfo.NbuPercent, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_percent", OracleDbType.Decimal, this.CreditContractInfo.DefPercent, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_s_limit", OracleDbType.Decimal, this.CreditContractInfo.CrdLimit, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_creditor_type", OracleDbType.Decimal, this.CreditContractInfo.CreditorType, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_type", OracleDbType.Decimal, this.CreditContractInfo.CreditType, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_period", OracleDbType.Decimal, this.CreditContractInfo.CreditPeriod, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_term", OracleDbType.Decimal, this.CreditContractInfo.CreditTerm, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_method", OracleDbType.Decimal, this.CreditContractInfo.CreditMethod, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_prepay", OracleDbType.Decimal, this.CreditContractInfo.CreditPrepay, ParameterDirection.Input);

                        oraCmd.Parameters.Add("p_name", OracleDbType.Varchar2, this.CreditContractInfo.CreditName, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_add_agree", OracleDbType.Varchar2, this.CreditContractInfo.CreditAddAgree, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_percent_nbu_type", OracleDbType.Decimal, this.CreditContractInfo.CreditPercent, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_percent_nbu_info", OracleDbType.Varchar2, this.CreditContractInfo.CreditNbuInfo, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_r_agree_date", OracleDbType.Date, this.CreditContractInfo.CreditAgreeDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_r_agree_no", OracleDbType.Varchar2, this.CreditContractInfo.CreditAgreeNum, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_prev_doc_key", OracleDbType.Decimal, this.CreditContractInfo.CreditDocKey, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_ending_date_indiv", OracleDbType.Date, this.CreditContractInfo.CrdIndEndDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_parent_ch_data", OracleDbType.Varchar2, this.CreditContractInfo.CreditCrdParentChData, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_ending_date", OracleDbType.Date, this.CreditContractInfo.CreditEndingDate, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_margin", OracleDbType.Decimal, this.CreditContractInfo.CreditMargin, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_tranche_no", OracleDbType.Varchar2, this.CreditContractInfo.CreditTranshNum, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_tr_summa", OracleDbType.Decimal, this.CreditContractInfo.CreditTranshSum, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_tr_currency", OracleDbType.Decimal, this.CreditContractInfo.CreditTranshCurr, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_tr_rate_name", OracleDbType.Varchar2, this.CreditContractInfo.CreditTranshRatName, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_tr_rate", OracleDbType.Decimal, this.CreditContractInfo.CreditTranshRat, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_opertype", OracleDbType.Decimal, this.CreditContractInfo.CreditOperType, ParameterDirection.Input);
                        oraCmd.Parameters.Add("p_credit_operdate", OracleDbType.Date, this.CreditContractInfo.CreditOperDate, ParameterDirection.Input);
                    }

                    oraCmd.CommandText = @"begin cim_mgr.create_contract (:p_contr_id,:p_contr_type,:p_rnk,:p_num,:p_s,:p_kv,:p_benef_id,:p_open_date,:p_close_date,:p_comments " + addParams + "); end;";
                    oraCmd.ExecuteNonQuery();
                    this.ContrId = Convert.ToDecimal(oraCmd.Parameters["p_contr_id"].Value.ToString());
                }
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return this.ContrId.Value;
        }


        public decimal ApproveNbuContract()
        {
            oraConn = OraConnector.Handler.UserConnection;
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
            oraConn = OraConnector.Handler.UserConnection;
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
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return this.ContrId.Value;
        }


        public string ContractToXml(decimal? contrId, string agreeFile, string letterFile, string old_mfo, string old_oblcode, string old_bank_code, string old_bank_oblcode)
        {
            string result = string.Empty;
            oraConn = OraConnector.Handler.UserConnection;
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

                //oraCmd.CommandType = CommandType.StoredProcedure;

                oraCmd.CommandText = "declare res varchar2(4000); begin :res := cim_mgr.nbu_registration(:p_contr_id, :p_agree_fname, :p_letter_fname,:p_old_mfo, :p_old_oblcode,:p_old_bank_code,:p_old_bank_oblcode); end;";
                oraCmd.ExecuteNonQuery();
                //oraCmd.CommandText = "select cim_mgr.nbu_registration(:p_contr_id, :p_agree_fname, :p_letter_fname,:p_old_mfo, :p_old_oblcode,:p_old_bank_code,:p_old_bank_oblcode) from dual";
                result = Convert.ToString(oraCmd.Parameters["res"].Value); //Convert.ToString(oraCmd.ExecuteScalar());
            }
            finally
            {
                oraCmd.Dispose();
                oraConn.Close();
                oraConn.Dispose();
            }
            return result;
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
            readCreditContract();
        }
        #endregion

        #region Properties
        public decimal? ContrId { get; set; }
        public decimal NbuPercent { get; set; }
        public decimal DefPercent { get; set; }
        public decimal? CrdLimit { get; set; }
        public decimal? CreditorType { get; set; }
        public decimal? CreditType { get; set; }
        public decimal CreditPeriod { get; set; }
        public decimal CreditTerm { get; set; }
        public decimal CreditMethod { get; set; }
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

        #endregion

        #region Private methods
        private void readCreditContract()
        {
            oraConn = OraConnector.Handler.UserConnection;
            if (this.ContrId.HasValue)
            {
                try
                {
                    oraCmd = oraConn.CreateCommand();
                    oraCmd.Parameters.Add("contrId", OracleDbType.Decimal, this.ContrId, ParameterDirection.Input);
                    oraCmd.CommandText = @"select contr_id,percent_nbu, percent, s_limit, creditor_type, credit_type, credit_period, credit_term, credit_method, credit_prepay, name, add_agree, percent_nbu_type, percent_nbu_info, r_agree_date, r_agree_no, prev_ddoc_key, ending_date_indiv, parent_ch_data, ending_date, margin, tranche_no, tr_summa,tr_currency, tr_rate_name, tr_rate, credit_opertype, credit_operdate from v_cim_credit_contracts where contr_id=:contrId";

                    oraRdr = oraCmd.ExecuteReader();
                    if (oraRdr.Read())
                    {
                        this.ContrId = Convert.ToDecimal(oraRdr.GetValue(0));
                        this.NbuPercent = Convert.ToDecimal(oraRdr.GetValue(1));
                        this.DefPercent = Convert.ToDecimal(oraRdr.GetValue(2));
                        if (!oraRdr.IsDBNull(3))
                            this.CrdLimit = Convert.ToDecimal(oraRdr.GetValue(3));
                        if (!oraRdr.IsDBNull(4))
                            this.CreditorType = Convert.ToDecimal(oraRdr.GetValue(4));
                        if (!oraRdr.IsDBNull(5))
                            this.CreditType = Convert.ToDecimal(oraRdr.GetValue(5));
                        this.CreditPeriod = Convert.ToDecimal(oraRdr.GetValue(6));
                        this.CreditTerm = Convert.ToDecimal(oraRdr.GetValue(7));
                        this.CreditMethod = Convert.ToDecimal(oraRdr.GetValue(8));
                        if (!oraRdr.IsDBNull(9))
                            this.CreditPrepay = Convert.ToDecimal(oraRdr.GetValue(9));

                        this.CreditName = Convert.ToString(oraRdr.GetValue(10));
                        this.CreditAddAgree = Convert.ToString(oraRdr.GetValue(11));
                        this.CreditPercent = Convert.ToDecimal(oraRdr.GetValue(12));
                        this.CreditNbuInfo = Convert.ToString(oraRdr.GetValue(13));
                        if (!oraRdr.IsDBNull(14))
                            CreditAgreeDate = Convert.ToDateTime(oraRdr.GetValue(14));
                        CreditAgreeNum = Convert.ToString(oraRdr.GetValue(15));
                        if (!oraRdr.IsDBNull(16))
                            CreditDocKey = Convert.ToDecimal(oraRdr.GetValue(16));
                        if (!oraRdr.IsDBNull(17))
                            CrdIndEndDate = Convert.ToDateTime(oraRdr.GetValue(17));
                        CreditCrdParentChData = Convert.ToString(oraRdr.GetValue(18));
                        if (!oraRdr.IsDBNull(19))
                            CreditEndingDate = Convert.ToDateTime(oraRdr.GetValue(19));
                        if (!oraRdr.IsDBNull(20))
                            CreditMargin = Convert.ToDecimal(oraRdr.GetValue(20));
                        CreditTranshNum = Convert.ToString(oraRdr.GetValue(21));
                        if (!oraRdr.IsDBNull(22))
                            CreditTranshSum = Convert.ToDecimal(oraRdr.GetValue(22));
                        if (!oraRdr.IsDBNull(23))
                            CreditTranshCurr = Convert.ToDecimal(oraRdr.GetValue(23));
                        CreditTranshRatName = Convert.ToString(oraRdr.GetValue(24));
                        if (!oraRdr.IsDBNull(25))
                            CreditTranshRat = Convert.ToDecimal(oraRdr.GetValue(25));
                        if (!oraRdr.IsDBNull(26))
                            CreditOperType = Convert.ToDecimal(oraRdr.GetValue(26));
                        if (!oraRdr.IsDBNull(27))
                            CreditOperDate = Convert.ToDateTime(oraRdr.GetValue(27));
                    }
                    else
                        this.ContrId = null;

                    oraRdr.Close();
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
            oraConn = OraConnector.Handler.UserConnection;
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
                        oraCmd.CommandText += " c.okpo like :okpo||'%'";
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
            oraConn = OraConnector.Handler.UserConnection;
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
            oraConn = OraConnector.Handler.UserConnection;
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
}