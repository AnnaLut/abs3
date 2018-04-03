using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace ibank.objlayer
{

    public class DataImport : BbPackage
    {
        public DataImport(BbConnection Connection) : base(Connection) {}
        public void ADD_INDIVIDUAL ( String P_KF,  Decimal? P_RNK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_KF", OracleDbType.Varchar2,P_KF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Int32,P_RNK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.ADD_INDIVIDUAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ADD_COMPANY ( String P_KF,  Decimal? P_RNK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_KF", OracleDbType.Varchar2,P_KF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Int32,P_RNK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.ADD_COMPANY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ADD_ACCOUNT ( Decimal? P_ACC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Int32,P_ACC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.ADD_ACCOUNT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void ADD_ACCOUNT_AND_SYNC ( Decimal? P_ACC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Int32,P_ACC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.ADD_ACCOUNT_AND_SYNC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IMPORT_CUST_ACCOUNTS_AND_SYNC ( String P_KF,  Decimal? P_RNK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_KF", OracleDbType.Varchar2,P_KF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Int32,P_RNK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.IMPORT_CUST_ACCOUNTS_AND_SYNC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MARK_TURNOVERS ( Decimal? P_ACC,  DateTime? P_BANKDATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Int32,P_ACC, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BANKDATE", OracleDbType.Date,P_BANKDATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.MARK_TURNOVERS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MARK_TURNOVERS ( Decimal? P_ACC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Int32,P_ACC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.MARK_TURNOVERS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MARK_TRANSACTIONS ( Decimal? P_ACC,  DateTime? P_BANKDATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Int32,P_ACC, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BANKDATE", OracleDbType.Date,P_BANKDATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.MARK_TRANSACTIONS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void MARK_TRANSACTIONS ( Decimal? P_ACC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Int32,P_ACC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.MARK_TRANSACTIONS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_SW_BANKS ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_SW_BANKS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_BANKS ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_BANKS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_HOLIDAY ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_HOLIDAY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_CUR_RATES ( DateTime? P_BANKDATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BANKDATE", OracleDbType.Date,P_BANKDATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_CUR_RATES", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_CUR_RATES ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_CUR_RATES", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_ACCOUNT_STMT ( Decimal? P_ACC,  DateTime? P_BANKDATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Int32,P_ACC, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BANKDATE", OracleDbType.Date,P_BANKDATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_ACCOUNT_STMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_ACCOUNT_STMT ( Decimal? P_ACC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Int32,P_ACC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_ACCOUNT_STMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_ALL_ACCOUNT_STMT ( DateTime? P_BANKDATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BANKDATE", OracleDbType.Date,P_BANKDATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_ALL_ACCOUNT_STMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_ALL_ACCOUNT_STMT ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_ALL_ACCOUNT_STMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void JOB_SYNC_ACCOUNT_STMT ( Decimal? P_ACC,  DateTime? P_BANKDATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Int32,P_ACC, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BANKDATE", OracleDbType.Date,P_BANKDATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.JOB_SYNC_ACCOUNT_STMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void JOB_SYNC_ACCOUNT_STMT ( Decimal? P_ACC)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_ACC", OracleDbType.Int32,P_ACC, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.JOB_SYNC_ACCOUNT_STMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void JOB_SYNC_ALL_ACCOUNT_STMT ( DateTime? P_BANKDATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BANKDATE", OracleDbType.Date,P_BANKDATE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.JOB_SYNC_ALL_ACCOUNT_STMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void JOB_SYNC_ALL_ACCOUNT_STMT ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.JOB_SYNC_ALL_ACCOUNT_STMT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IMPORT_DOCUMENTS ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.IMPORT_DOCUMENTS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IMPORT_DOCUMENT ( Decimal? P_DOCID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DOCID", OracleDbType.Decimal,P_DOCID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.IMPORT_DOCUMENT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SWITCH_LOGFILE ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SWITCH_LOGFILE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void NOTIFY_IBANK ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.NOTIFY_IBANK", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void FULL_IMPORT ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.FULL_IMPORT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_CONTRACTS ( String P_KF,  Decimal? P_RNK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_KF", OracleDbType.Varchar2,P_KF, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RNK", OracleDbType.Int32,P_RNK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_CONTRACTS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_ALL_CONTRACTS ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_ALL_CONTRACTS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_BANKDATES ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_BANKDATES", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SYNC_BRANCHES ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.SYNC_BRANCHES", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public String HEADER_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_DOC_XML ( Decimal? P_DOCID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DOCID", OracleDbType.Decimal,P_DOCID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.XmlType, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("DATA_IMPORT.GET_DOC_XML", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleXmlType res = (OracleXmlType)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
    }
}