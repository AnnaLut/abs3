using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Bars.Classes;
using BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract;
using Areas.Async.Models;
using BarsWeb.Areas.Async.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Async.Infrastructure.Repository.DI.Implementation
{
    public class TasksRepository : ITasksRepository
    {
        readonly AsyncEntities _entities;
        private readonly IUtils _utils;
        private readonly ISchedulersRepository _schedulersRepository;
        public TasksRepository(IAsyncModel model , IUtils utils, ISchedulersRepository schedulersRepository)
        {
		    _entities = model.AsyncEntities;
            _utils = utils;
            _schedulersRepository = schedulersRepository;
        }

        public IQueryable<Task> GetAllTasks()
        {
            return _entities.ASYNC_RUN.Select(i=>new Task
            {
                Id = (int)i.RUN_ID,
                SchedulerId = (int)i.ACTION_ID,
                SchedulerName = i.ASYNC_ACTION.NAME,
                SchedulerDescription = i.ASYNC_ACTION.DESCRIPTION,
                JobName = i.JOB_NAME,
                JobSql = i.JOB_SQL,
                StartDate = i.START_DATE,
                EndDate = i.END_DATE,
                DbmshpRunId = i.DBMSHP_RUNID,
                ExclusionMode = i.EXCLMODE_VALUE,
                State = i.STATE,
                ErrorMessage = i.ERROR_MESSAGE,
                UserId = (int?)i.USER_ID,
                ProgressPercent = i.PROGRESS_BAR,
                ProgressText = i.PROGRESS_TEXT
            });
        }

        public string StartTask(string schedulerCode, List<TaskParameter> parameters)
        {
            var taskId = CreateTask(schedulerCode);

            SetTaskParamValue(taskId, parameters);
            StartTask(taskId);
            return taskId;
        }

        public List<TaskParameter> GetSсhedulerParameters(string schedulerCode)
        {
            return _schedulersRepository.GetParameters(schedulerCode);
        }
        public string CreateTask(string schedulerCode)
        {
            OracleConnection conn = OraConnector.Handler.IOraConnection.GetUserConnection();
            
            try
            {
                var cmd = new OracleCommand("bars_async.create_job", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.Add("l_job_name", OracleDbType.Varchar2, 30, "", ParameterDirection.ReturnValue);
                cmd.Parameters.Add("p_action_code", OracleDbType.Varchar2,40, schedulerCode, ParameterDirection.Input);

                cmd.ExecuteNonQuery();

                return Convert.ToString(cmd.Parameters["l_job_name"].Value);
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
                conn.Dispose();
            }
        }

        public void DropTask(string taskName)
        {
            object[] param =         
                { 
                    new OracleParameter("p_job_name",OracleDbType.Varchar2,taskName,ParameterDirection.Input)
                };
            const string sql = @"begin bars_async_adm.drop_job(:p_job_name);end;";
            _entities.ExecuteStoreCommand(sql, param);
        }
        public void SetTaskParamValue(string taskId, string param, int value)
        {
            var paramsList = new List<TaskParameter>
            {
                new TaskParameter
                {
                    Name = param,
                    Type = TypeCode.Decimal,
                    Value = value
                }
            };
            SetTaskParamValue(taskId, paramsList);
        }

        public void SetTaskParamValue(string taskId, string param, DateTime value)
        {
            var paramsList = new List<TaskParameter>
            {
                new TaskParameter
                {
                    Name = param,
                    Type = TypeCode.DateTime,
                    Value = value
                }
            };
            SetTaskParamValue(taskId, paramsList);
        }

        public void SetTaskParamValue(string taskId, string param, string value)
        {
            var paramsList = new List<TaskParameter>
            {
                new TaskParameter
                {
                    Name = param,
                    Type = TypeCode.String,
                    Value = value
                }
            };
            SetTaskParamValue(taskId, paramsList);
        }

        public void SetTaskParamValue(string taskId, List<TaskParameter> parameters)
        {
            foreach (var item in parameters)
            {
                object[] array =         
                { 
                    new OracleParameter("p_action_code",OracleDbType.Varchar2,taskId,ParameterDirection.Input),
                    new OracleParameter("p_param", OracleDbType.Varchar2,item.Name,ParameterDirection.Input),
                    new OracleParameter("p_value", _utils.TypeCodeToOracleDbType(item.Type),item.Value,ParameterDirection.Input)
                };

                SetTaskParamValue(array);
            }
        }


        private void SetTaskParamValue(object[] parameters)
        {
            const string sql = @"begin 
                                    bars_async.set_job_param_val(:p_job_name,:p_param,:p_value);
                                end;";

            _entities.ExecuteStoreCommand(sql, parameters);
        }

        public int StartTask(string taskId)
        {
            return _entities.BARS_ASYNC_RUN_JOB(taskId);
        }
    }
}