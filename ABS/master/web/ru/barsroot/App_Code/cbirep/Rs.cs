using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace Bars.ObjLayer.CbiRep
{

    public class Rs : BbPackage
    {
        public Rs(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) { }
        public Rs(BbConnection Connection) : base(Connection, AutoCommit.Enabled) { }
        public void SET_STATUS(Decimal? P_QUERY_ID, String P_STATUS_ID, String P_COMM)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUERY_ID", OracleDbType.Decimal, P_QUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_ID", OracleDbType.Varchar2, P_STATUS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_COMM", OracleDbType.Varchar2, P_COMM, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("RS.SET_STATUS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_STATUS(Decimal? P_QUERY_ID, String P_STATUS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUERY_ID", OracleDbType.Decimal, P_QUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_ID", OracleDbType.Varchar2, P_STATUS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("RS.SET_STATUS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void EXEC_REPORT_QUERY(Decimal? P_QUERY_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUERY_ID", OracleDbType.Decimal, P_QUERY_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("RS.EXEC_REPORT_QUERY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CLEAR_REPORT_QUERY(Decimal? P_QUERY_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUERY_ID", OracleDbType.Decimal, P_QUERY_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("RS.CLEAR_REPORT_QUERY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CLEAN_TMP_DATA()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("RS.CLEAN_TMP_DATA", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void JOB_TIMEOUT_MONITOR()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("RS.JOB_TIMEOUT_MONITOR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public Decimal? G_JOB_TIMEOUT()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("RS.G_JOB_TIMEOUT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public String HEADER_VERSION()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("RS.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("RS.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GENERATE_KEY_PARAMS(String P_XML_PARAMS)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_XML_PARAMS", OracleDbType.Varchar2, P_XML_PARAMS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("RS.GENERATE_KEY_PARAMS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? CREATE_REPORT_QUERY(Decimal? P_REP_ID, String P_XML_PARAMS)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_REP_ID", OracleDbType.Decimal, P_REP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_XML_PARAMS", OracleDbType.Varchar2, P_XML_PARAMS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("RS.CREATE_REPORT_QUERY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
    }
}