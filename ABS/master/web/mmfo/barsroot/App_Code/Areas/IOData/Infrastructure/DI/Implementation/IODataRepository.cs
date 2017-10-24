using System;
using System.Linq;
using System.Collections.Generic;
using System.Data;
using Areas.IOData.Models;
using Bars.Classes;
using BarsWeb.Areas.IOData.Infrastructure.DI.Abstract;
using BarsWeb.Areas.IOData.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using Dapper;

namespace BarsWeb.Areas.IOData.Infrastructure.DI.Implementation
{
    public class IODataRepository : IIODataRepository
    {
        private readonly IODataModel _entities;
        public IODataRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("IODataModel", "IOData");
            _entities = new IODataModel(connectionStr);
        }

        public IEnumerable<ActiveJob> ActiveJobs()
        {
            const string query = @"Select substr(JOB_NAME,1,50) JobName, substr(DESCRIPT,1,100) Description From V_UPL_ACTIVEJOBS ORDER BY JOB_NAME";
            return _entities.ExecuteStoreQuery<ActiveJob>(query);
        }

        public IEnumerable<FileModel> Files(string jobName)
        {
            var query = @"select FILE_CODE as FileCode, SubStr(lpad(FILE_ID, 3, '0') || ' - ' || FILE_NAME, 1, 200) as FileName from V_UPL_FILE_GROUPS where JOB_NAME=:jobName ORDER BY 2";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<FileModel>(query, new { jobName});                
            }

        }

        public StatusResult CheckJob(Job item)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                StatusResult sr = new StatusResult();
                string eCode = "";
                string eMsg = "";

                OracleCommand command = new OracleCommand("barsupl.bars_upload_usr.check_job_status", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_bankdate", OracleDbType.Date, item.JobDate.Date, ParameterDirection.Input);
                command.Parameters.Add("p_jobname", OracleDbType.Varchar2, item.JobName, ParameterDirection.Input);
                command.Parameters.Add("p_errcode", OracleDbType.Varchar2, 300, eCode, ParameterDirection.InputOutput);
                command.Parameters.Add("p_errmsg", OracleDbType.Varchar2, 300, eMsg, ParameterDirection.InputOutput);

                command.ExecuteNonQuery();

                sr.ErrCode = Convert.ToString(command.Parameters["p_errcode"].Value);
                sr.ErrMsg = Convert.ToString(command.Parameters["p_errmsg"].Value);

                return sr;
            }
            finally
            {
                connection.Close();
            }
        }

        public void UpdateJob(Job item)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("barsupl.bars_upload_usr.create_interface_job", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_jobname", OracleDbType.Varchar2, item.JobName, ParameterDirection.Input);
                command.Parameters.Add("p_enabled", OracleDbType.Decimal, 1, ParameterDirection.Input);
                command.Parameters.Add("p_sheduled", OracleDbType.Decimal, 0, ParameterDirection.Input);
                command.Parameters.Add("p_bankdate", OracleDbType.Date, item.JobDate, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }
        
        public void RemoveJob(Job item)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("barsupl.bars_upload_usr.delete_jobinfo", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_bankdate", OracleDbType.Date, item.JobDate.Date, ParameterDirection.Input);
                command.Parameters.Add("p_jobname", OracleDbType.Varchar2, item.JobName, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        public void UploadOneFile(UploadRequestModel data)
        {
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                var sqlId = GetSqlId(connection, data.JobName, data.FileCode);
                var date = data.JobDate.ToString("dd/MM/yyyy");

                OracleCommand command = new OracleCommand("barsupl.bars_upload_usr.upload_file", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_filecode", OracleDbType.Varchar2, data.FileCode, ParameterDirection.Input);
                command.Parameters.Add("p_sqlid", OracleDbType.Decimal, sqlId, ParameterDirection.Input);                
                command.Parameters.Add("p_param1", OracleDbType.Varchar2, date, ParameterDirection.Input);
                command.Parameters.Add("p_param2", OracleDbType.Varchar2, null, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
        }

        private int GetSqlId(OracleConnection connection, string jobName, string fileCode)
        {            
            var query = @"select SQL_ID from V_UPL_FILE_GROUPS where JOB_NAME=:jobName and FILE_CODE=:fileCode";
            return connection.Query<int>(query, new {jobName, fileCode}).FirstOrDefault();
        }
    }
}
