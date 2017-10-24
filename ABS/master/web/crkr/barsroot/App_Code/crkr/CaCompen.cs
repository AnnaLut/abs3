using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace ibank.objlayer
{

    public class CaCompen : BbPackage
    {
        public CaCompen(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public CaCompen(BbConnection Connection) : base(Connection, AutoCommit.Enabled) {}
        public void ACTUALIZATION_COMPEN ( Decimal? P_RNK,  Decimal? P_COMPENID,  String P_OPERCODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMPENID", OracleDbType.Decimal,P_COMPENID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OPERCODE", OracleDbType.Varchar2,P_OPERCODE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.ACTUALIZATION_COMPEN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ACTUALIZATION_COMPEN ( Decimal? P_RNK,  Decimal? P_COMPENID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMPENID", OracleDbType.Decimal,P_COMPENID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.ACTUALIZATION_COMPEN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CREATE_PAYMENTS_REGISTRY ( String P_MFO,  String P_BRANCH,  String P_OPERCODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_MFO", OracleDbType.Varchar2,P_MFO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OPERCODE", OracleDbType.Varchar2,P_OPERCODE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.CREATE_PAYMENTS_REGISTRY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CREATE_PAYMENTS_REGISTRY ( String P_MFO,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_MFO", OracleDbType.Varchar2,P_MFO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.CREATE_PAYMENTS_REGISTRY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SEND_PAYMENTS_COMPEN_XML ( String P_MFO,  String P_BRANCH,  String P_REGCODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_MFO", OracleDbType.Varchar2,P_MFO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_REGCODE", OracleDbType.Varchar2,P_REGCODE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.SEND_PAYMENTS_COMPEN_XML", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SEND_BATCH_REBRANCH_FOR_JOB ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("CA_COMPEN.SEND_BATCH_REBRANCH_FOR_JOB", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void OPEN_NEW_COMPEN ( Decimal? P_RNK,  String P_OB22,  String P_NAME, out Decimal? P_COMPEN_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OB22", OracleDbType.Varchar2,P_OB22, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2,P_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMPEN_ID", OracleDbType.Decimal,null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.OPEN_NEW_COMPEN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_COMPEN_ID = parameters[3].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[3].Value).Value;
        }
        public void COMPEN_WRITE_DOWN ( Decimal? P_COMPEN_FROM,  Decimal? P_COMPEN_TO,  Decimal? P_RNK,  Decimal? P_AMOUNT,  String P_PURPOSE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_COMPEN_FROM", OracleDbType.Decimal,P_COMPEN_FROM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMPEN_TO", OracleDbType.Decimal,P_COMPEN_TO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_AMOUNT", OracleDbType.Decimal,P_AMOUNT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PURPOSE", OracleDbType.Varchar2,P_PURPOSE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.COMPEN_WRITE_DOWN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_COMPEN_STATUS ( Decimal? P_COMPEN_ID,  Decimal? P_STATUS_ID,  String P_REASON_CHANGE_STATUS)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_COMPEN_ID", OracleDbType.Decimal,P_COMPEN_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_ID", OracleDbType.Decimal,P_STATUS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_REASON_CHANGE_STATUS", OracleDbType.Varchar2,P_REASON_CHANGE_STATUS, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.SET_COMPEN_STATUS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_COMPEN_STATUS ( Decimal? P_COMPEN_ID,  Decimal? P_STATUS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_COMPEN_ID", OracleDbType.Decimal,P_COMPEN_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_ID", OracleDbType.Decimal,P_STATUS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.SET_COMPEN_STATUS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DELETE_BENEF ( Decimal? P_IDB)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IDB", OracleDbType.Int32,P_IDB, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.DELETE_BENEF", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_COMPEN_PARAM_VALUE ( String P_PARAM,  Decimal? P_TYPE,  Decimal? P_ID,  String P_VAL,  String P_KF,  String P_BRANCH,  Decimal? P_ALL,  DateTime? P_DATE_FROM,  DateTime? P_DATE_TO,  Decimal? P_IS_ENABLE, out Decimal? P_ERR_CODE, out String P_ERR_TEXT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_PARAM", OracleDbType.Varchar2,P_PARAM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Decimal,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ID", OracleDbType.Decimal,P_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KF", OracleDbType.Varchar2,P_KF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ALL", OracleDbType.Decimal,P_ALL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DATE_FROM", OracleDbType.Date,P_DATE_FROM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DATE_TO", OracleDbType.Date,P_DATE_TO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IS_ENABLE", OracleDbType.Decimal,P_IS_ENABLE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ERR_CODE", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_ERR_TEXT", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.SET_COMPEN_PARAM_VALUE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_ERR_CODE = parameters[10].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[10].Value).Value;
            P_ERR_TEXT = parameters[11].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[11].Value).Value;
        }
        public String HEADER_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? GET_PAYMENT_AMOUNT ( Decimal? P_RNK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("crkr_compen_web.GET_PAYMENT_AMOUNT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
    }
}