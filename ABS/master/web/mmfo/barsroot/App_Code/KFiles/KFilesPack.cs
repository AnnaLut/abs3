using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
using Bars.Classes;

namespace Bars.KFiles
{

    public class KFilesPack : BbPackage
    {
        public KFilesPack(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public KFilesPack(BbConnection Connection) : base(Connection, AutoCommit.Enabled) { } 

        public Int64 GET_SYNC_ID()
        {
             List<OracleParameter> parameters = new List<OracleParameter>();
             parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
             object ReturnValue = null;
             ExecuteNonQuery("bars.kfile_sync.get_sync_id", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal p_SessionID = (OracleDecimal)ReturnValue;
            return p_SessionID.ToInt64() ;
            
        }
        public Int64 GET_SYNC_ID(Int32 p_MFO, String p_corporationId, String p_syncDate, String p_syncType)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("p_MFO", OracleDbType.Decimal, p_MFO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("p_CORPORATION_ID", OracleDbType.Varchar2, p_corporationId, ParameterDirection.Input));
            parameters.Add(new OracleParameter("p_SYNC_DATE", OracleDbType.Varchar2, p_syncDate, ParameterDirection.Input));
            parameters.Add(new OracleParameter("p_SYNC_TYPE", OracleDbType.Varchar2, p_syncType, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("bars.kfile_sync.get_sync_id", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal p_SessionID = (OracleDecimal)ReturnValue;
            return p_SessionID.ToInt64();

        }
        public void SET_SYNC_ID(Int64 p_sync_id)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SYNC_ID", OracleDbType.Decimal, p_sync_id, ParameterDirection.Input));
           // parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("bars.kfile_sync.set_sync_id", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            
        }

        public void SYNC_OB_CORPORATION_DICTIONARY( Decimal p_ID ,
                                                    String p_CORPORATION_CODE,
                                                    String p_CORPORATION_NAME,
                                                    Decimal? p_PARENT_ID,
                                                    Decimal p_STATE_ID,
                                                    string p_EXTERNAL_ID)
       {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("p_ID", OracleDbType.Decimal, p_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("p_CORPORATION_CODE", OracleDbType.Varchar2, p_CORPORATION_CODE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("p_CORPORATION_NAME", OracleDbType.Varchar2, p_CORPORATION_NAME, ParameterDirection.Input));
            parameters.Add(new OracleParameter("p_PARENT_ID", OracleDbType.Decimal, p_PARENT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("p_STATE_ID", OracleDbType.Decimal,  p_STATE_ID , ParameterDirection.Input));
            parameters.Add(new OracleParameter("p_EXTERNAL_ID", OracleDbType.Varchar2,  p_EXTERNAL_ID , ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("bars.kfile_sync.SYNC_OB_CORPORATION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);

        }

        public void ADD_CORPORATION_OR_SUB_CORPORATION(string CORPORATION_NAME, string CORPORATION_CODE, string EXTERNAL_ID, decimal PARENT_ID )
        {
            var connection = OraConnector.Handler.UserConnection;

            try
            {               

                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "bars.kfile_pack.ADD_CORPORATION";
                cmd.Parameters.Add("P_CORPORATION_NAME", CORPORATION_NAME);
                cmd.Parameters.Add("P_CORPORATION_CODE", CORPORATION_CODE);
                cmd.Parameters.Add("P_EXTERNAL_ID", EXTERNAL_ID);
                if (PARENT_ID != 0)
                {
                    cmd.Parameters.Add("P_PARENT_ID", PARENT_ID);
                }

                cmd.ExecuteNonQuery();
            }
            catch(System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }

            
        }

        public void EDIT_CORPORATION(decimal ID, string CORPORATION_CODE, string CORPORATION_NAME, string EXTERNAL_ID)           
        {

            var connection = OraConnector.Handler.UserConnection;
            try
            {

                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "bars.kfile_pack.EDIT_CORPORATION";
                cmd.Parameters.Add("P_ID", ID);
                cmd.Parameters.Add("P_CORPORATION_CODE", CORPORATION_CODE);
                cmd.Parameters.Add("P_CORPORATION_NAME", CORPORATION_NAME);
                cmd.Parameters.Add("P_EXTERNAL_ID", EXTERNAL_ID);

                cmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }

        }

        public void LOCK_CORPORATION(decimal ID)
        {

            var connection = OraConnector.Handler.UserConnection;
            try
            {

                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "bars.kfile_pack.LOCK_CORPORATION_ITEM";
                cmd.Parameters.Add("P_UNIT_ID", ID);

                cmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }

        }

        public void UNLOCK_CORPORATION(decimal ID)
        {
            var connection = OraConnector.Handler.UserConnection;
            try
            {

                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "bars.kfile_pack.UNLOCK_CORPORATION_ITEM";
                cmd.Parameters.Add("P_UNIT_ID", ID);

                cmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }

        }

        public void CLOSE_CORPORATION(decimal ID)
        {

            var connection = OraConnector.Handler.UserConnection;
            try
            {

                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "bars.kfile_pack.CLOSE_CORPORATION_ITEM";
                cmd.Parameters.Add("P_UNIT_ID", ID);

                cmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }

        }

        public void CHANGE_HIERARCHY(decimal ID, decimal PARENT_ID)
        {
            var connection = OraConnector.Handler.UserConnection;
            try
            {

                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;

                cmd.CommandText = "bars.kfile_pack.CHANGE_HIERARCHY";
                cmd.Parameters.Add("P_ID_UNIT", ID);
                cmd.Parameters.Add("P_PARENT_ID", PARENT_ID);

                cmd.ExecuteNonQuery();
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
                connection.Dispose();
            }

        }

        public Int64 GET_LAST_ID(Int64 p_LAST_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("p_LAST_ID", OracleDbType.Decimal, p_LAST_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("bars.kfile_sync.get_last_id", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal p_SessionID = (OracleDecimal)ReturnValue;
            return p_SessionID.ToInt64();

        }

        public void FILL_TODAY_DATA()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            // parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("bars.kfile_sync.FILL_TODAY_DATA", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);

        }

        public void FILL_DATA(String p_DATE, String p_CORPORATION_CODE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("p_date", OracleDbType.Varchar2, p_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("p_corp_code", OracleDbType.Varchar2, p_CORPORATION_CODE, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("bars.kfile_sync.fill_temporary_data", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);

        }
    }
}