using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace ibank.objlayer
{

    public class DynamicLayoutUi : BbPackage
    {
        public DynamicLayoutUi(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public DynamicLayoutUi(BbConnection Connection) : base(Connection, AutoCommit.Enabled) {}
        public void CLEAR_DYNAMIC_LAYOUT ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.CLEAR_DYNAMIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CREATE_DYNAMIC_LAYOUT ( Decimal? P_MODE,  Decimal? P_DK,  String P_NLS,  String P_BS,  String P_OB,  Decimal? P_GRP)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_MODE", OracleDbType.Decimal,P_MODE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DK", OracleDbType.Decimal,P_DK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLS", OracleDbType.Varchar2,P_NLS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BS", OracleDbType.Char,P_BS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OB", OracleDbType.Char,P_OB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_GRP", OracleDbType.Decimal,P_GRP, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.CREATE_DYNAMIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DYNAMIC_LAYOUT ( String P_ND,  DateTime? P_DATD,  DateTime? P_DAT_FROM,  DateTime? P_DAT_TO,  Decimal? P_DATES_TO_NAZN,  String P_NAZN,  Decimal? P_SUMM,  Decimal? P_CORR)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Varchar2,P_ND, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DATD", OracleDbType.Date,P_DATD, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DAT_FROM", OracleDbType.Date,P_DAT_FROM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DAT_TO", OracleDbType.Date,P_DAT_TO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DATES_TO_NAZN", OracleDbType.Decimal,P_DATES_TO_NAZN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAZN", OracleDbType.Varchar2,P_NAZN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUMM", OracleDbType.Decimal,P_SUMM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CORR", OracleDbType.Decimal,P_CORR, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.UPDATE_DYNAMIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_DYNAMIC_LAYOUT_DETAIL ( Decimal? P_ID,  Decimal? P_PERSENTS,  Decimal? P_SUMM_A,  Decimal? P_TOTAL_SUM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PERSENTS", OracleDbType.Decimal,P_PERSENTS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUMM_A", OracleDbType.Decimal,P_SUMM_A, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TOTAL_SUM", OracleDbType.Decimal,P_TOTAL_SUM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.UPDATE_DYNAMIC_LAYOUT_DETAIL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_KV_B ( Decimal? P_KVB)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_KVB", OracleDbType.Decimal,P_KVB, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.UPDATE_KV_B", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CALCULATE_DYNAMIC_LAYOUT ( Decimal? P_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.CALCULATE_DYNAMIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CALCULATE_STATIC_LAYOUT ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.CALCULATE_STATIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ADD_STATIC_LAYOUT ( Decimal? P_ID,  Decimal? P_DK,  String P_ND,  Decimal? P_KV,  String P_NLSA,  String P_NAM_A,  String P_OKPO_A,  String P_MFO_B,  String P_NLS_B,  String P_NAM_B,  String P_OKPO_B,  Decimal? P_PERCENT,  Decimal? P_SUM_A,  Decimal? P_SUM_B,  Decimal? P_DELTA,  String P_TT,  Decimal? P_VOB,  String P_NAZN,  Decimal? P_ORD)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DK", OracleDbType.Decimal,P_DK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Varchar2,P_ND, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KV", OracleDbType.Decimal,P_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLSA", OracleDbType.Varchar2,P_NLSA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAM_A", OracleDbType.Varchar2,P_NAM_A, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OKPO_A", OracleDbType.Varchar2,P_OKPO_A, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MFO_B", OracleDbType.Varchar2,P_MFO_B, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NLS_B", OracleDbType.Varchar2,P_NLS_B, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAM_B", OracleDbType.Varchar2,P_NAM_B, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OKPO_B", OracleDbType.Varchar2,P_OKPO_B, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PERCENT", OracleDbType.Decimal,P_PERCENT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM_A", OracleDbType.Decimal,P_SUM_A, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SUM_B", OracleDbType.Decimal,P_SUM_B, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DELTA", OracleDbType.Decimal,P_DELTA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TT", OracleDbType.Varchar2,P_TT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VOB", OracleDbType.Decimal,P_VOB, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAZN", OracleDbType.Varchar2,P_NAZN, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ORD", OracleDbType.Decimal,P_ORD, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.ADD_STATIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DELETE_STATIC_LAYOUT ( Decimal? P_GRP,  Decimal? P_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_GRP", OracleDbType.Decimal,P_GRP, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.DELETE_STATIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PAY_DYNAMIC_LAYOUT ( Decimal? P_MAK,  String P_ND)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_MAK", OracleDbType.Decimal,P_MAK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ND", OracleDbType.Varchar2,P_ND, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.PAY_DYNAMIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PAY_STATIC_LAYOUT ( Decimal? P_MAK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_MAK", OracleDbType.Decimal,P_MAK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.PAY_STATIC_LAYOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public String HEADER_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("DYNAMIC_LAYOUT_UI.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
    }
}