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
    public class StatisticRepozitory : IStatisticRepozitory
    {
        private readonly IODataModel _entities;

        public StatisticRepozitory()
        {
            var connectionStr = EntitiesConnection.ConnectionString("IODataModel", "IOData");
            _entities = new IODataModel(connectionStr);
        }



        public IEnumerable<ShedulerJob> ShedulerJobs()
        {
            const string query = @"select job_name as JobName,
                                          state as State,enabled as Enabled,
                                          last_start_date as LastStartDate,
                                          next_run_date as NextRunDate,
                                          comments as Description,
                                          job_action as JobAction 
                                          from barsupl.v_upl_scheduler_jobs";
            return _entities.ExecuteStoreQuery<ShedulerJob>(query);
        }
        public IEnumerable<JobLogRecord> JobLogRecords()
        {
            const string query = @"select log_id as LogId, log_date as LogDate, job_name as JobName, status as Status,
                                            ACTUAL_START_DATE as ActualStartDate, RUN_DURATION as RunDuration, info as Info, mess_info as MessInfo
                                            from barsupl.v_upl_JOB_RUN_DETAILS order by log_id desc";
            return _entities.ExecuteStoreQuery<JobLogRecord>(query);
        }

        public IEnumerable<EnableJob> EnabledJobs()
        {
            const string query = @"select job_name as JobName, descript as Description, is_active as IsActive
                                        from barsupl.v_upl_all_jobs where is_exists = 0 order by job_name";
            return _entities.ExecuteStoreQuery<EnableJob>(query);
        }

        public void ChangeJobState(string jobName, string jobEnabled)
        {
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                string commandText = jobEnabled == "FALSE" ? "barsupl.bars_upload_usr.enable_interface_job" : "barsupl.bars_upload_usr.disable_interface_job";
                OracleCommand command = new OracleCommand(commandText, connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_jobname", OracleDbType.Varchar2, jobName, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
        }

        public void RecreateJob(string jobName)
        {
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {                
                OracleCommand command = new OracleCommand("barsupl.bars_upload_usr.recreate_interface_job", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("p_jobname", OracleDbType.Varchar2, jobName, ParameterDirection.Input);

                command.ExecuteNonQuery();
            }
        }

        public IEnumerable<JobParameter> JobParams(string jobName)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var sql = @"select v.param as ParamName, substr(v.value,1,200) Value, p.descript as Description
                                            from barsupl.upl_autojob_param_values v, barsupl.upl_autojob_params p
                                            where lower(job_name) = lower(:jobName) and v.param = p.param";
                return connection.Query<JobParameter>(sql, new { jobName }).ToList();                
            }            
        }

        public IEnumerable<JobParameter> AvailableJobParams(string jobName)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var sql = @"select param as ParamName, descript as Description, substr(default_val ,1,200) Value
                                from barsupl.v_upl_autojob_param_values 
                                where lower(job_name) = lower(:jobName)  
                                and isdefault = 1";
                return connection.Query<JobParameter>(sql, new { jobName }).ToList();
            }
        }


        public void UpdateJobParams(string jobName, IEnumerable<JobParameter> jobParams)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {                
                var updateCommand = connection.CreateCommand();
                updateCommand.CommandText = "update barsupl.upl_autojob_param_values set value = :paramValue where upper(job_name) = upper(:jobName) and upper(param) = upper(:paramName)";
                foreach (var jobParam in jobParams)
                {
                    updateCommand.Parameters.Clear();
                    updateCommand.Parameters.Add("paramValue", OracleDbType.Varchar2, jobParam.Value, ParameterDirection.Input);
                    updateCommand.Parameters.Add("jobName", OracleDbType.Varchar2, jobName, ParameterDirection.Input);
                    updateCommand.Parameters.Add("paramName", OracleDbType.Varchar2, jobParam.ParamName, ParameterDirection.Input);
                    updateCommand.ExecuteNonQuery();
                }
            }
        }

        public void DeleteJobParams(string jobName, IEnumerable<JobParameter> jobParams)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var deleteCommand = connection.CreateCommand();
               
                deleteCommand.CommandText = " delete from barsupl.upl_autojob_param_values where upper(job_name) = upper(:jobName) and upper(param) = upper(:paramName)";
                foreach (var jobParam in jobParams)
                {
                    deleteCommand.Parameters.Clear();                    
                    deleteCommand.Parameters.Add("jobName", OracleDbType.Varchar2, jobName, ParameterDirection.Input);
                    deleteCommand.Parameters.Add("paramName", OracleDbType.Varchar2, jobParam.ParamName, ParameterDirection.Input);
                    deleteCommand.ExecuteNonQuery();
                }
            }
        }

        public void InsertJobParams(string jobName, IEnumerable<JobParameter> jobParams)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var insertCommand = connection.CreateCommand();

                insertCommand.CommandText = "insert into barsupl.upl_autojob_param_values(job_name,param, value) values(upper(:jobName), :paramName, :paramValue)";
                foreach (var jobParam in jobParams)
                {
                    insertCommand.Parameters.Clear();
                    insertCommand.Parameters.Add("jobName", OracleDbType.Varchar2, jobName, ParameterDirection.Input);
                    insertCommand.Parameters.Add("paramName", OracleDbType.Varchar2, jobParam.ParamName, ParameterDirection.Input);
                    insertCommand.Parameters.Add("paramValue", OracleDbType.Varchar2, jobParam.Value, ParameterDirection.Input);
                    insertCommand.ExecuteNonQuery();
                }
            }
        }
    }
}
