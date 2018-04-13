using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace Bars.Ins
{

    public class InsPack : BbPackage
    {
        public InsPack(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public InsPack(BbConnection Connection) : base(Connection, AutoCommit.Enabled) {}
        public void SET_FEE ( String P_FEE_ID,  String P_NAME,  Decimal? P_MIN_VALUE,  Decimal? P_PERC_VALUE,  Decimal? P_MAX_VALUE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FEE_ID", OracleDbType.Varchar2,P_FEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_VALUE", OracleDbType.Decimal,P_MIN_VALUE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PERC_VALUE", OracleDbType.Decimal,P_PERC_VALUE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_VALUE", OracleDbType.Decimal,P_MAX_VALUE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_FEE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_FEE ( String P_FEE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FEE_ID", OracleDbType.Varchar2,P_FEE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_FEE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_FEE_PERIOD ( String P_FEE_ID,  Decimal? P_PERIOD_ID,  Decimal? P_MIN_VALUE,  Decimal? P_PERC_VALUE,  Decimal? P_MAX_VALUE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FEE_ID", OracleDbType.Varchar2,P_FEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PERIOD_ID", OracleDbType.Decimal,P_PERIOD_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_VALUE", OracleDbType.Decimal,P_MIN_VALUE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PERC_VALUE", OracleDbType.Decimal,P_PERC_VALUE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_VALUE", OracleDbType.Decimal,P_MAX_VALUE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_FEE_PERIOD", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_FEE_PERIOD ( String P_FEE_ID,  Decimal? P_PERIOD_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_FEE_ID", OracleDbType.Varchar2,P_FEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PERIOD_ID", OracleDbType.Decimal,P_PERIOD_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_FEE_PERIOD", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_TARIFF ( String P_TARIFF_ID,  String P_NAME,  Decimal? P_MIN_VALUE,  Decimal? P_MIN_PERC,  Decimal? P_MAX_VALUE,  Decimal? P_MAX_PERC,  Decimal? P_AMORT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TARIFF_ID", OracleDbType.Varchar2,P_TARIFF_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_VALUE", OracleDbType.Decimal,P_MIN_VALUE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_PERC", OracleDbType.Decimal,P_MIN_PERC, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_VALUE", OracleDbType.Decimal,P_MAX_VALUE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_PERC", OracleDbType.Decimal,P_MAX_PERC, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_AMORT", OracleDbType.Decimal,P_AMORT, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_TARIFF", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_TARIFF ( String P_TARIFF_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TARIFF_ID", OracleDbType.Varchar2,P_TARIFF_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_TARIFF", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_TARIFF_PERIOD ( String P_TARIFF_ID,  Decimal? P_PERIOD_ID,  Decimal? P_MIN_VALUE,  Decimal? P_MIN_PERC,  Decimal? P_MAX_VALUE,  Decimal? P_MAX_PERC,  Decimal? P_AMORT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TARIFF_ID", OracleDbType.Varchar2,P_TARIFF_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PERIOD_ID", OracleDbType.Decimal,P_PERIOD_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_VALUE", OracleDbType.Decimal,P_MIN_VALUE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MIN_PERC", OracleDbType.Decimal,P_MIN_PERC, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_VALUE", OracleDbType.Decimal,P_MAX_VALUE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAX_PERC", OracleDbType.Decimal,P_MAX_PERC, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_AMORT", OracleDbType.Decimal,P_AMORT, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_TARIFF_PERIOD", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_TARIFF_PERIOD ( String P_TARIFF_ID,  Decimal? P_PERIOD_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TARIFF_ID", OracleDbType.Varchar2,P_TARIFF_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PERIOD_ID", OracleDbType.Decimal,P_PERIOD_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_TARIFF_PERIOD", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_LIMIT ( String P_LIMIT_ID,  String P_NAME,  Decimal? P_SUM_VALUE,  Decimal? P_PERC_VALUE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_LIMIT_ID", OracleDbType.Varchar2,P_LIMIT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM_VALUE", OracleDbType.Decimal,P_SUM_VALUE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PERC_VALUE", OracleDbType.Decimal,P_PERC_VALUE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_LIMIT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_LIMIT ( String P_LIMIT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_LIMIT_ID", OracleDbType.Varchar2,P_LIMIT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_LIMIT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_ATTR ( String P_ATTR_ID,  String P_NAME,  String P_TYPE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ATTR_ID", OracleDbType.Varchar2,P_ATTR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Varchar2,P_TYPE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_ATTR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_ATTR ( String P_ATTR_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ATTR_ID", OracleDbType.Varchar2,P_ATTR_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_ATTR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_SCAN ( String P_SCAN_ID,  String P_NAME)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCAN_ID", OracleDbType.Varchar2,P_SCAN_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_SCAN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_SCAN ( String P_SCAN_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SCAN_ID", OracleDbType.Varchar2,P_SCAN_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_SCAN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_PARTNER ( Decimal? P_PARTNER_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_PARTNER", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_PARTNER_BRANCH_RNK ( Decimal? P_PARTNER_ID,  String P_BRANCH,  Decimal? P_RNK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_PARTNER_BRANCH_RNK", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_PARTNER_BRANCH_RNK ( Decimal? P_PARTNER_ID,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_PARTNER_BRANCH_RNK", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_PARTNER_TYPE ( Decimal? P_PARTNER_ID,  Decimal? P_TYPE_ID,  String P_TARIFF_ID,  String P_FEE_ID,  String P_LIMIT_ID,  Decimal? P_ACTIVE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TARIFF_ID", OracleDbType.Varchar2,P_TARIFF_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FEE_ID", OracleDbType.Varchar2,P_FEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_LIMIT_ID", OracleDbType.Varchar2,P_LIMIT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ACTIVE", OracleDbType.Decimal,P_ACTIVE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_PARTNER_TYPE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_PARTNER_TYPE ( Decimal? P_PARTNER_ID,  Decimal? P_TYPE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_PARTNER_TYPE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_PARTNER_TYPE_ATTR ( Decimal? P_ID,  Decimal? P_APPLY_HIER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_HIER", OracleDbType.Decimal,P_APPLY_HIER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_PARTNER_TYPE_ATTR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_PARTNER_TYPE_BRANCH ( Decimal? P_ID,  Decimal? P_APPLY_HIER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_HIER", OracleDbType.Decimal,P_APPLY_HIER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_PARTNER_TYPE_BRANCH", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_PARTNER_TYPE_PRODUCT ( Decimal? P_ID,  Decimal? P_APPLY_HIER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_HIER", OracleDbType.Decimal,P_APPLY_HIER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_PARTNER_TYPE_PRODUCT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_PARTNER_TYPE_SCAN ( Decimal? P_ID,  Decimal? P_APPLY_HIER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_HIER", OracleDbType.Decimal,P_APPLY_HIER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_PARTNER_TYPE_SCAN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_PARTNER_TYPE_TEMPLATE ( Decimal? P_ID,  Decimal? P_APPLY_HIER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_HIER", OracleDbType.Decimal,P_APPLY_HIER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_PARTNER_TYPE_TEMPLATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_DEAL_PMT ( Decimal? P_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_DEAL_PMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PAY_DEAL_PMT ( Decimal? P_ID,  DateTime? P_FACT_DATE,  Decimal? P_FACT_SUM,  String P_PMT_NUM,  String P_PMT_COMM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FACT_DATE", OracleDbType.Date,P_FACT_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FACT_SUM", OracleDbType.Decimal,P_FACT_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PMT_NUM", OracleDbType.Varchar2,P_PMT_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PMT_COMM", OracleDbType.Varchar2,P_PMT_COMM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.PAY_DEAL_PMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_ADDAGR_PARAMS ( Decimal? P_DEAL_ID,  Decimal? P_ID,  DateTime? P_NEW_EDATE,  Decimal? P_NEW_SUM,  Decimal? P_NEW_SUM_KV,  Decimal? P_NEW_INSU_TARIFF,  Decimal? P_NEW_INSU_SUM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NEW_EDATE", OracleDbType.Date,P_NEW_EDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NEW_SUM", OracleDbType.Decimal,P_NEW_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NEW_SUM_KV", OracleDbType.Decimal,P_NEW_SUM_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NEW_INSU_TARIFF", OracleDbType.Decimal,P_NEW_INSU_TARIFF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NEW_INSU_SUM", OracleDbType.Decimal,P_NEW_INSU_SUM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_ADDAGR_PARAMS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_ADDAGR_PMT ( Decimal? P_DEAL_ID,  Decimal? P_ID,  Decimal? P_PMT_ID,  String P_ACTION,  DateTime? P_PLAN_DATE,  Decimal? P_PLAN_SUM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PMT_ID", OracleDbType.Decimal,P_PMT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ACTION", OracleDbType.Varchar2,P_ACTION, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PLAN_DATE", OracleDbType.Date,P_PLAN_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PLAN_SUM", OracleDbType.Decimal,P_PLAN_SUM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_ADDAGR_PMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DEAL ( Decimal? P_DEAL_ID, String P_BRANCH, Decimal? P_PARTNER_ID, Decimal? P_TYPE_ID,  Decimal? P_INS_RNK,  String P_SER,  String P_NUM,  DateTime? P_SDATE,  DateTime? P_EDATE,  Decimal? P_SUM,  Decimal? P_SUM_KV,  Decimal? P_INSU_TARIFF,  Decimal? P_INSU_SUM,  Decimal? P_RNK,  Decimal? P_GRT_ID,  Decimal? P_ND,  Decimal? P_RENEW_NEED)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2, P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal, P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal, P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INS_RNK", OracleDbType.Decimal,P_INS_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SER", OracleDbType.Varchar2,P_SER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SDATE", OracleDbType.Date,P_SDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EDATE", OracleDbType.Date,P_EDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM", OracleDbType.Decimal,P_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM_KV", OracleDbType.Decimal,P_SUM_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_TARIFF", OracleDbType.Decimal,P_INSU_TARIFF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_SUM", OracleDbType.Decimal,P_INSU_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GRT_ID", OracleDbType.Decimal,P_GRT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Decimal,P_ND, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RENEW_NEED", OracleDbType.Decimal,P_RENEW_NEED, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.UPDATE_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DEAL ( Decimal? P_DEAL_ID,  Decimal? P_INS_RNK,  String P_SER,  String P_NUM,  DateTime? P_SDATE,  DateTime? P_EDATE,  Decimal? P_SUM,  Decimal? P_SUM_KV,  Decimal? P_INSU_TARIFF,  Decimal? P_INSU_SUM,  Decimal? P_RNK,  Decimal? P_GRT_ID,  Decimal? P_ND)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INS_RNK", OracleDbType.Decimal,P_INS_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SER", OracleDbType.Varchar2,P_SER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SDATE", OracleDbType.Date,P_SDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EDATE", OracleDbType.Date,P_EDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM", OracleDbType.Decimal,P_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM_KV", OracleDbType.Decimal,P_SUM_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_TARIFF", OracleDbType.Decimal,P_INSU_TARIFF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_SUM", OracleDbType.Decimal,P_INSU_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GRT_ID", OracleDbType.Decimal,P_GRT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Decimal,P_ND, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.UPDATE_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DEAL ( Decimal? P_DEAL_ID,  Decimal? P_INS_RNK,  String P_SER,  String P_NUM,  DateTime? P_SDATE,  DateTime? P_EDATE,  Decimal? P_SUM,  Decimal? P_SUM_KV,  Decimal? P_INSU_TARIFF,  Decimal? P_INSU_SUM,  Decimal? P_RNK,  Decimal? P_GRT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INS_RNK", OracleDbType.Decimal,P_INS_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SER", OracleDbType.Varchar2,P_SER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SDATE", OracleDbType.Date,P_SDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EDATE", OracleDbType.Date,P_EDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM", OracleDbType.Decimal,P_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM_KV", OracleDbType.Decimal,P_SUM_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_TARIFF", OracleDbType.Decimal,P_INSU_TARIFF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_SUM", OracleDbType.Decimal,P_INSU_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GRT_ID", OracleDbType.Decimal,P_GRT_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.UPDATE_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void FINISH_DATAINPUT ( Decimal? P_DEAL_ID,  String P_STATUS_COMM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_COMM", OracleDbType.Varchar2,P_STATUS_COMM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.FINISH_DATAINPUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void FINISH_DATAINPUT ( Decimal? P_DEAL_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.FINISH_DATAINPUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BACK2MANAGER ( Decimal? P_DEAL_ID,  String P_STATUS_COMM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_COMM", OracleDbType.Varchar2,P_STATUS_COMM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.BACK2MANAGER", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void VISA_DEAL ( Decimal? P_DEAL_ID,  String P_STATUS_COMM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_COMM", OracleDbType.Varchar2,P_STATUS_COMM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.VISA_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void VISA_DEAL ( Decimal? P_DEAL_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.VISA_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void STORNO_DEAL ( Decimal? P_DEAL_ID,  String P_STATUS_COMM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_COMM", OracleDbType.Varchar2,P_STATUS_COMM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.STORNO_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CLOSE_DEAL ( Decimal? P_DEAL_ID,  Decimal? P_RENEW_NEWID,  String P_STATUS_COMM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RENEW_NEWID", OracleDbType.Decimal,P_RENEW_NEWID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_COMM", OracleDbType.Varchar2,P_STATUS_COMM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.CLOSE_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CLOSE_DEAL ( Decimal? P_DEAL_ID,  Decimal? P_RENEW_NEWID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RENEW_NEWID", OracleDbType.Decimal,P_RENEW_NEWID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.CLOSE_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CLOSE_DEAL ( Decimal? P_DEAL_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.CLOSE_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_DEAL_ATTR_S ( Decimal? P_DEAL_ID,  String P_ATTR_ID,  String P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ATTR_ID", OracleDbType.Varchar2,P_ATTR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_DEAL_ATTR_S", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_DEAL_ATTR_N ( Decimal? P_DEAL_ID,  String P_ATTR_ID,  Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ATTR_ID", OracleDbType.Varchar2,P_ATTR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_DEAL_ATTR_N", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_DEAL_ATTR_D ( Decimal? P_DEAL_ID,  String P_ATTR_ID,  DateTime? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ATTR_ID", OracleDbType.Varchar2,P_ATTR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Date,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_DEAL_ATTR_D", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_DEAL_ATTR ( Decimal? P_DEAL_ID,  String P_ATTR_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ATTR_ID", OracleDbType.Varchar2,P_ATTR_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_DEAL_ATTR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_DEAL_SCAN ( Decimal? P_DEAL_ID,  String P_SCAN_ID,  Byte[] P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCAN_ID", OracleDbType.Varchar2,P_SCAN_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Blob,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_DEAL_SCAN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DEL_DEAL_SCAN ( Decimal? P_DEAL_ID,  String P_SCAN_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCAN_ID", OracleDbType.Varchar2,P_SCAN_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.DEL_DEAL_SCAN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BUILD_DEAL_PMTS_SCHEDULE ( Decimal? P_DEAL_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.BUILD_DEAL_PMTS_SCHEDULE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public String HEADER_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? G_ALERTDAYS ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.G_ALERTDAYS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? SET_PARTNER ( Decimal? P_PARTNER_ID,  String P_NAME,  Decimal? P_RNK,  String P_AGR_NO,  DateTime? P_AGR_SDATE,  DateTime? P_AGR_EDATE,  String P_TARIFF_ID,  String P_FEE_ID,  String P_LIMIT_ID,  Decimal? P_ACTIVE, Decimal? P_CUSTID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_AGR_NO", OracleDbType.Varchar2,P_AGR_NO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_AGR_SDATE", OracleDbType.Date,P_AGR_SDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_AGR_EDATE", OracleDbType.Date,P_AGR_EDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TARIFF_ID", OracleDbType.Varchar2,P_TARIFF_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FEE_ID", OracleDbType.Varchar2,P_FEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_LIMIT_ID", OracleDbType.Varchar2,P_LIMIT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ACTIVE", OracleDbType.Decimal,P_ACTIVE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CUSTID", OracleDbType.Decimal, P_CUSTID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_PARTNER", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? SET_PARTNER_TYPE_ATTR ( Decimal? P_ID,  String P_ATTR_ID,  Decimal? P_PARTNER_ID,  Decimal? P_TYPE_ID,  Decimal? P_IS_REQUIRED)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ATTR_ID", OracleDbType.Varchar2,P_ATTR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REQUIRED", OracleDbType.Decimal,P_IS_REQUIRED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_PARTNER_TYPE_ATTR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? SET_PARTNER_TYPE_BRANCH ( Decimal? P_ID,  String P_BRANCH,  Decimal? P_PARTNER_ID,  Decimal? P_TYPE_ID,  String P_TARIFF_ID,  String P_FEE_ID,  String P_LIMIT_ID,  Decimal? P_APPLY_HIER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TARIFF_ID", OracleDbType.Varchar2,P_TARIFF_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FEE_ID", OracleDbType.Varchar2,P_FEE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_LIMIT_ID", OracleDbType.Varchar2,P_LIMIT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_HIER", OracleDbType.Decimal,P_APPLY_HIER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_PARTNER_TYPE_BRANCH", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? SET_PARTNER_TYPE_PRODUCT ( Decimal? P_ID,  String P_PRODUCT_ID,  Decimal? P_PARTNER_ID,  Decimal? P_TYPE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PRODUCT_ID", OracleDbType.Varchar2,P_PRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_PARTNER_TYPE_PRODUCT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? SET_PARTNER_TYPE_SCAN ( Decimal? P_ID,  String P_SCAN_ID,  Decimal? P_PARTNER_ID,  Decimal? P_TYPE_ID,  Decimal? P_IS_REQUIRED)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCAN_ID", OracleDbType.Varchar2,P_SCAN_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_REQUIRED", OracleDbType.Decimal,P_IS_REQUIRED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_PARTNER_TYPE_SCAN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? SET_PARTNER_TYPE_TEMPLATE ( Decimal? P_ID,  String P_TEMPLATE_ID,  Decimal? P_PARTNER_ID,  Decimal? P_TYPE_ID,  String P_PRT_FORMAT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEMPLATE_ID", OracleDbType.Varchar2,P_TEMPLATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PRT_FORMAT", OracleDbType.Varchar2,P_PRT_FORMAT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_PARTNER_TYPE_TEMPLATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? SET_DEAL_PMT ( Decimal? P_ID,  Decimal? P_DEAL_ID,  DateTime? P_PLAN_DATE,  Decimal? P_PLAN_SUM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PLAN_DATE", OracleDbType.Date,P_PLAN_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PLAN_SUM", OracleDbType.Decimal,P_PLAN_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.SET_DEAL_PMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? CREATE_DEAL ( Decimal? P_PARTNER_ID,  Decimal? P_TYPE_ID,  Decimal? P_INS_RNK,  String P_SER,  String P_NUM,  DateTime? P_SDATE,  DateTime? P_EDATE,  Decimal? P_SUM,  Decimal? P_SUM_KV,  Decimal? P_INSU_TARIFF,  Decimal? P_INSU_SUM,  String P_OBJECT_TYPE,  Decimal? P_RNK,  Decimal? P_GRT_ID,  Decimal? P_ND,  Decimal? P_PAY_FREQ,  Decimal? P_RENEW_NEED)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INS_RNK", OracleDbType.Decimal,P_INS_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SER", OracleDbType.Varchar2,P_SER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SDATE", OracleDbType.Date,P_SDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EDATE", OracleDbType.Date,P_EDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM", OracleDbType.Decimal,P_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM_KV", OracleDbType.Decimal,P_SUM_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_TARIFF", OracleDbType.Decimal,P_INSU_TARIFF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_SUM", OracleDbType.Decimal,P_INSU_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OBJECT_TYPE", OracleDbType.Varchar2,P_OBJECT_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GRT_ID", OracleDbType.Decimal,P_GRT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Decimal,P_ND, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PAY_FREQ", OracleDbType.Decimal,P_PAY_FREQ, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RENEW_NEED", OracleDbType.Decimal,P_RENEW_NEED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.CREATE_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? CREATE_DEAL ( Decimal? P_PARTNER_ID,  Decimal? P_TYPE_ID,  Decimal? P_INS_RNK,  String P_SER,  String P_NUM,  DateTime? P_SDATE,  DateTime? P_EDATE,  Decimal? P_SUM,  Decimal? P_SUM_KV,  Decimal? P_INSU_TARIFF,  Decimal? P_INSU_SUM,  String P_OBJECT_TYPE,  Decimal? P_RNK,  Decimal? P_GRT_ID,  Decimal? P_ND,  Decimal? P_PAY_FREQ)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INS_RNK", OracleDbType.Decimal,P_INS_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SER", OracleDbType.Varchar2,P_SER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SDATE", OracleDbType.Date,P_SDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EDATE", OracleDbType.Date,P_EDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM", OracleDbType.Decimal,P_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM_KV", OracleDbType.Decimal,P_SUM_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_TARIFF", OracleDbType.Decimal,P_INSU_TARIFF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_SUM", OracleDbType.Decimal,P_INSU_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OBJECT_TYPE", OracleDbType.Varchar2,P_OBJECT_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GRT_ID", OracleDbType.Decimal,P_GRT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Decimal,P_ND, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PAY_FREQ", OracleDbType.Decimal,P_PAY_FREQ, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.CREATE_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? CREATE_DEAL ( Decimal? P_PARTNER_ID,  Decimal? P_TYPE_ID,  Decimal? P_INS_RNK,  String P_SER,  String P_NUM,  DateTime? P_SDATE,  DateTime? P_EDATE,  Decimal? P_SUM,  Decimal? P_SUM_KV,  Decimal? P_INSU_TARIFF,  Decimal? P_INSU_SUM,  String P_OBJECT_TYPE,  Decimal? P_RNK,  Decimal? P_GRT_ID,  Decimal? P_ND)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PARTNER_ID", OracleDbType.Decimal,P_PARTNER_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INS_RNK", OracleDbType.Decimal,P_INS_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SER", OracleDbType.Varchar2,P_SER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SDATE", OracleDbType.Date,P_SDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EDATE", OracleDbType.Date,P_EDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM", OracleDbType.Decimal,P_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM_KV", OracleDbType.Decimal,P_SUM_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_TARIFF", OracleDbType.Decimal,P_INSU_TARIFF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INSU_SUM", OracleDbType.Decimal,P_INSU_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OBJECT_TYPE", OracleDbType.Varchar2,P_OBJECT_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GRT_ID", OracleDbType.Decimal,P_GRT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Decimal,P_ND, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.CREATE_DEAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? CREATE_ADDAGR ( Decimal? P_DEAL_ID,  String P_SER,  String P_NUM,  DateTime? P_SDATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SER", OracleDbType.Varchar2,P_SER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SDATE", OracleDbType.Date,P_SDATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.CREATE_ADDAGR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public String GET_ADDAGR_COMM ( Decimal? P_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.GET_ADDAGR_COMM", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_DEAL_ATTR_S ( Decimal? P_DEAL_ID,  String P_ATTR_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ATTR_ID", OracleDbType.Varchar2,P_ATTR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.GET_DEAL_ATTR_S", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? GET_DEAL_ATTR_N ( Decimal? P_DEAL_ID,  String P_ATTR_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ATTR_ID", OracleDbType.Varchar2,P_ATTR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.GET_DEAL_ATTR_N", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public DateTime? GET_DEAL_ATTR_D ( Decimal? P_DEAL_ID,  String P_ATTR_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ATTR_ID", OracleDbType.Varchar2,P_ATTR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Date, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.GET_DEAL_ATTR_D", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDate res = (OracleDate)ReturnValue;
            return res.IsNull ? (DateTime?)null : res.Value;
        }
        public Byte[] GET_DEAL_SCAN ( Decimal? P_DEAL_ID,  String P_SCAN_ID)
        {
            this.InitConnection();
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal, P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCAN_ID", OracleDbType.Varchar2, P_SCAN_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Blob, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.GET_DEAL_SCAN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleBlob res = (OracleBlob)ReturnValue;
            Byte[] resByte = res.IsNull ? (Byte[])null : res.Value;
            res.Close();
            res.Dispose();
            return resByte;
        }
        public Decimal? CREATE_ACCIDENT ( Decimal? P_ID,  Decimal? P_DEAL_ID,  DateTime? P_ACDT_DATE,  String P_COMM,  Decimal? P_REFUND_SUM,  DateTime? P_REFUND_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEAL_ID", OracleDbType.Decimal,P_DEAL_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ACDT_DATE", OracleDbType.Date,P_ACDT_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMM", OracleDbType.Varchar2,P_COMM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_REFUND_SUM", OracleDbType.Decimal,P_REFUND_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_REFUND_DATE", OracleDbType.Date,P_REFUND_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("INS_PACK.CREATE_ACCIDENT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
    }
}