using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace Bars.EAD
{

    public class EadPack : BbPackage
    {
        public EadPack(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public EadPack(BbConnection Connection) : base(Connection, AutoCommit.Enabled) {}
        public void DOC_SIGN ( Decimal? P_DOC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DOC_ID", OracleDbType.Decimal,P_DOC_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.DOC_SIGN", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MSG_SET_STATUS_SEND ( Decimal? P_SYNC_ID,  String P_MESSAGE_ID,  DateTime? P_MESSAGE_DATE,  String P_MESSAGE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SYNC_ID", OracleDbType.Decimal,P_SYNC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MESSAGE_ID", OracleDbType.Varchar2,P_MESSAGE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MESSAGE_DATE", OracleDbType.Date,P_MESSAGE_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MESSAGE", OracleDbType.Clob,P_MESSAGE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.MSG_SET_STATUS_SEND", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MSG_SET_STATUS_RECEIVED ( Decimal? P_SYNC_ID,  String P_RESPONCE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SYNC_ID", OracleDbType.Decimal,P_SYNC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RESPONCE", OracleDbType.Clob,P_RESPONCE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.MSG_SET_STATUS_RECEIVED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MSG_SET_STATUS_PARSED ( Decimal? P_SYNC_ID,  String P_RESPONCE_ID,  DateTime? P_RESPONCE_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SYNC_ID", OracleDbType.Decimal,P_SYNC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RESPONCE_ID", OracleDbType.Varchar2,P_RESPONCE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RESPONCE_DATE", OracleDbType.Date,P_RESPONCE_DATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.MSG_SET_STATUS_PARSED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MSG_SET_STATUS_DONE ( Decimal? P_SYNC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SYNC_ID", OracleDbType.Decimal,P_SYNC_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.MSG_SET_STATUS_DONE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MSG_SET_STATUS_ERROR ( Decimal? P_SYNC_ID,  String P_ERR_TEXT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SYNC_ID", OracleDbType.Decimal,P_SYNC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ERR_TEXT", OracleDbType.Varchar2,P_ERR_TEXT, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.MSG_SET_STATUS_ERROR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MSG_PROCESS ( Decimal? P_SYNC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SYNC_ID", OracleDbType.Decimal,P_SYNC_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.MSG_PROCESS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MSG_DELETE ( Decimal? P_SYNC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SYNC_ID", OracleDbType.Decimal,P_SYNC_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.MSG_DELETE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CDC_CLIENT ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.CDC_CLIENT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CDC_ACT ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.CDC_ACT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CDC_AGR ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.CDC_AGR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CDC_DOC ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.CDC_DOC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void TYPE_PROCESS ( String P_TYPE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Varchar2,P_TYPE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.TYPE_PROCESS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public Decimal? G_PROCESS_ACTUAL_TIME ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.G_PROCESS_ACTUAL_TIME", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? DOC_CREATE ( String P_TYPE_ID,  String P_TEMPLATE_ID,  Byte[] P_SCAN_DATA,  Decimal? P_EA_STRUCT_ID,  Decimal? P_RNK,  Decimal? P_AGR_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Varchar2,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEMPLATE_ID", OracleDbType.Varchar2,P_TEMPLATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCAN_DATA", OracleDbType.Blob,P_SCAN_DATA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EA_STRUCT_ID", OracleDbType.Decimal,P_EA_STRUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_AGR_ID", OracleDbType.Decimal,P_AGR_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.DOC_CREATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? DOC_CREATE ( String P_TYPE_ID,  String P_TEMPLATE_ID,  Byte[] P_SCAN_DATA,  Decimal? P_EA_STRUCT_ID,  Decimal? P_RNK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Varchar2,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEMPLATE_ID", OracleDbType.Varchar2,P_TEMPLATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCAN_DATA", OracleDbType.Blob,P_SCAN_DATA, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_EA_STRUCT_ID", OracleDbType.Decimal,P_EA_STRUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Decimal,P_RNK, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.DOC_CREATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? MSG_CREATE ( String P_TYPE_ID,  String P_OBJ_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_TYPE_ID", OracleDbType.Varchar2,P_TYPE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_OBJ_ID", OracleDbType.Varchar2,P_OBJ_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.MSG_CREATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? MSG_DELETE_OLDER ( DateTime? P_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DATE", OracleDbType.Date,P_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("EAD_PACK.MSG_DELETE_OLDER", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
    }
}