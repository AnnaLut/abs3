using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace cim
{

    public class CimMgr : BbPackage
    {
        public CimMgr(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public CimMgr(BbConnection Connection) : base(Connection, AutoCommit.Enabled) {}
        public void VISA_PAYMENT ( Decimal? P_REF,  String P_SIGN1,  String P_SIGN2)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal,P_REF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SIGN1", OracleDbType.Varchar2,P_SIGN1, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SIGN2", OracleDbType.Varchar2,P_SIGN2, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.VISA_PAYMENT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void VISA_PAYMENT ( Decimal? P_REF,  String P_SIGN1)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal,P_REF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SIGN1", OracleDbType.Varchar2,P_SIGN1, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.VISA_PAYMENT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void VISA_PAYMENT ( Decimal? P_REF)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal,P_REF, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.VISA_PAYMENT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void BACK_PAYMENT ( Decimal? P_REF)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal,P_REF, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.BACK_PAYMENT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SEARCH_PAYMENTS ( DateTime? P_DATE,  Decimal? P_MODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DATE", OracleDbType.Date,P_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MODE", OracleDbType.Decimal,P_MODE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.SEARCH_PAYMENTS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SEARCH_PAYMENTS ( DateTime? P_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DATE", OracleDbType.Date,P_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.SEARCH_PAYMENTS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SEARCH_PAYMENTS ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.SEARCH_PAYMENTS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CREATE_APE ( Decimal? P_CONTR_ID,  String P_NUM,  Decimal? P_KV,  Decimal? P_S,  DateTime? P_BEGIN_DATE,  DateTime? P_END_DATE,  String P_COMMENTS)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_CONTR_ID", OracleDbType.Decimal,P_CONTR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KV", OracleDbType.Decimal,P_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_S", OracleDbType.Decimal,P_S, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BEGIN_DATE", OracleDbType.Date,P_BEGIN_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_END_DATE", OracleDbType.Date,P_END_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMMENTS", OracleDbType.Varchar2,P_COMMENTS, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.CREATE_APE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DELETE_APE ( Decimal? P_APE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_APE_ID", OracleDbType.Decimal,P_APE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.DELETE_APE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_APE ( Decimal? P_APE_ID,  String P_NUM,  Decimal? P_KV,  Decimal? P_S,  DateTime? P_BEGIN_DATE,  DateTime? P_END_DATE,  String P_COMMENTS)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_APE_ID", OracleDbType.Decimal,P_APE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KV", OracleDbType.Decimal,P_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_S", OracleDbType.Decimal,P_S, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BEGIN_DATE", OracleDbType.Date,P_BEGIN_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_END_DATE", OracleDbType.Date,P_END_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMMENTS", OracleDbType.Varchar2,P_COMMENTS, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.UPDATE_APE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CREATE_LICENSE ( Decimal? P_CONTR_ID,  String P_NUM,  Decimal? P_TYPE,  Decimal? P_KV,  Decimal? P_S,  DateTime? P_BEGIN_DATE,  DateTime? P_END_DATE,  String P_COMMENTS)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_CONTR_ID", OracleDbType.Decimal,P_CONTR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Decimal,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KV", OracleDbType.Decimal,P_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_S", OracleDbType.Decimal,P_S, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BEGIN_DATE", OracleDbType.Date,P_BEGIN_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_END_DATE", OracleDbType.Date,P_END_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMMENTS", OracleDbType.Varchar2,P_COMMENTS, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.CREATE_LICENSE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void DELETE_LICENSE ( Decimal? P_LICENSE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_LICENSE_ID", OracleDbType.Decimal,P_LICENSE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.DELETE_LICENSE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void UPDATE_LICENSE ( Decimal? P_LICENSE_ID,  String P_NUM,  Decimal? P_TYPE,  Decimal? P_KV,  Decimal? P_S,  DateTime? P_BEGIN_DATE,  DateTime? P_END_DATE,  String P_COMMENTS)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_LICENSE_ID", OracleDbType.Decimal,P_LICENSE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_NUM", OracleDbType.Varchar2,P_NUM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Decimal,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_KV", OracleDbType.Decimal,P_KV, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_S", OracleDbType.Decimal,P_S, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BEGIN_DATE", OracleDbType.Date,P_BEGIN_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_END_DATE", OracleDbType.Date,P_END_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMMENTS", OracleDbType.Varchar2,P_COMMENTS, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.UPDATE_LICENSE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_SELECTED_DOC ( Decimal? P_REF)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal,P_REF, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.SET_SELECTED_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public String HEADER_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? GET_PAYMENTS_BOUND_SUM ( Decimal? P_REF)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal,P_REF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.GET_PAYMENTS_BOUND_SUM", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public String GET_PAYMENT_OPER_TYPE ( Decimal? P_REF)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_REF", OracleDbType.Decimal,P_REF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.GET_PAYMENT_OPER_TYPE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? GET_SELECTED_DOC ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("CIM_MGR.GET_SELECTED_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
    }
}