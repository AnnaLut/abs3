using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;

namespace Bars.CoinInvoice
{

    public class CoinInvoiceMgr : BbPackage
    {
        public CoinInvoiceMgr(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public CoinInvoiceMgr(BbConnection Connection) : base(Connection, AutoCommit.Enabled) {}
        public void CLEAR_INVOICE ( String P_ND)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Varchar2,P_ND, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("COIN_INVOICE_MGR.CLEAR_INVOICE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CREATE_INVOICE ( Decimal? P_TYPE_ID,  String P_ND,  DateTime? P_DAT,  String P_REASON,  String P_BAILEE,  String P_PROXY,  Decimal? P_TOTAL_COUNT,  Decimal? P_TOTAL_NOMINAL,  Decimal? P_TOTAL_SUM,  Decimal? P_TOTAL_WITHOUT_VAT,  Decimal? P_VAT_PERCENT,  Decimal? P_VAT_SUM,  Decimal? P_TOTAL_NOMINAL_PRICE,  Decimal? P_TOTAL_WITH_VAT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Varchar2,P_ND, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DAT", OracleDbType.Date,P_DAT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_REASON", OracleDbType.Varchar2,P_REASON, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BAILEE", OracleDbType.Varchar2,P_BAILEE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PROXY", OracleDbType.Varchar2,P_PROXY, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TOTAL_COUNT", OracleDbType.Decimal,P_TOTAL_COUNT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TOTAL_NOMINAL", OracleDbType.Decimal,P_TOTAL_NOMINAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TOTAL_SUM", OracleDbType.Decimal,P_TOTAL_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TOTAL_WITHOUT_VAT", OracleDbType.Decimal,P_TOTAL_WITHOUT_VAT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAT_PERCENT", OracleDbType.Decimal,P_VAT_PERCENT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAT_SUM", OracleDbType.Decimal,P_VAT_SUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TOTAL_NOMINAL_PRICE", OracleDbType.Decimal,P_TOTAL_NOMINAL_PRICE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TOTAL_WITH_VAT", OracleDbType.Decimal,P_TOTAL_WITH_VAT, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("COIN_INVOICE_MGR.CREATE_INVOICE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PAY_INVOICE ( String P_ND)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Varchar2,P_ND, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("COIN_INVOICE_MGR.PAY_INVOICE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ADD_INVOICE_DETAIL ( Decimal? P_TYPE_ID,  String P_ND,  String P_CODE,  Decimal? P_COUNT,  Decimal? P_PRICE,  Decimal? P_RN)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Decimal,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Varchar2,P_ND, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CODE", OracleDbType.Varchar2,P_CODE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COUNT", OracleDbType.Decimal,P_COUNT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PRICE", OracleDbType.Decimal,P_PRICE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RN", OracleDbType.Decimal,P_RN, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("COIN_INVOICE_MGR.ADD_INVOICE_DETAIL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void REMOVE_INVOICE_DETAIL ( Decimal? P_RN,  String P_CODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_RN", OracleDbType.Decimal,P_RN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CODE", OracleDbType.Varchar2,P_CODE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("COIN_INVOICE_MGR.REMOVE_INVOICE_DETAIL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public String HEADER_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("COIN_INVOICE_MGR.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("COIN_INVOICE_MGR.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
    }
}