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
    public class SchedulersRepository : ISchedulersRepository
    {
        readonly AsyncEntities _entities;
        private readonly IUtils _utils;
        public SchedulersRepository(IAsyncModel model,IUtils utils)
        {
		    _entities = model.AsyncEntities;
            _utils = utils;
        }

        public IQueryable<Scheduler> GetAll()
        {
            return _entities.ASYNC_ACTION.Select(i => new Scheduler
            {
                Id = (int)i.ACTION_ID,
                Code = i.ACTION_CODE,
                Type = i.ACTION_TYPE,
                SqlId = (int?)i.SQL_ID,
                SqlText = i.ASYNC_SQL.SQL_TEXT,
                WebUiId = (int?)i.WEBUI_ID,
                IsBarsLogin = (i.BARS_LOGIN == "Y"),
                ExclusionMode = i.EXCLUSION_MODE,
                MaxExecutionTime = (int?)i.MAX_RUN_SECS
            });
        }

        public Scheduler Get(int id)
        {
            var result = GetAll().FirstOrDefault(i => i.Id == id);
            if (result != null)
            {
                result.ParametersList = GetParameters(result.Code);
            }
            return result;
        }

        public Scheduler GetByCode(string code)
        {
            var result = GetAll().FirstOrDefault(i=>i.Code == code);
            if (result != null)
            {
                result.ParametersList = GetParameters(result.Code);
            }
            return result;
        }

        public Scheduler Add(Scheduler scheduler)
        {
            const string sql = @"begin bars_async_adm.add_sql(:p_sql_code,:p_sql_text,:p_exclusion_mode,:p_max_run_secs);end;";
            object[] parameters =
                {
                    new OracleParameter("p_sql_code", OracleDbType.Varchar2){Value = scheduler.Code},
                    new OracleParameter("p_sql_text", OracleDbType.Varchar2){Value = scheduler.SqlText},
                    new OracleParameter("p_exclusion_mode", OracleDbType.Varchar2){Value = scheduler.ExclusionMode},
                    new OracleParameter("p_max_run_secs", OracleDbType.Decimal){Value = scheduler.MaxExecutionTime}
                };
            _entities.ExecuteStoreCommand(sql, parameters);


            const string sqlAddRunObj = @"begin bars_async_adm.add_run_object(
                                                :p_obj_type_code,
                                                :p_action_code,
                                                :p_pre_action_code,
                                                :p_post_action_code,
                                                :p_scheduler_id,
                                                :p_trace_level_id,
                                                :p_user_message
                                            );end;";
            object[] parametersAddRunObj =
                {
                    new OracleParameter("p_obj_type_code", OracleDbType.Varchar2){Value = null},
                    new OracleParameter("p_action_code", OracleDbType.Varchar2){Value = scheduler.Code},
                    new OracleParameter("p_pre_action_code", OracleDbType.Varchar2){Value = null},
                    new OracleParameter("p_post_action_code", OracleDbType.Varchar2){Value = null},
                    new OracleParameter("p_scheduler_id", OracleDbType.Varchar2){Value = null},
                    new OracleParameter("p_trace_level_id", OracleDbType.Varchar2){Value = null},
                    new OracleParameter("p_user_message", OracleDbType.Varchar2){Value = scheduler.UserMessages}
                };
            _entities.ExecuteStoreCommand(sqlAddRunObj, parametersAddRunObj);

            if (scheduler.ParametersList != null)
            {
                foreach (var item in scheduler.ParametersList)
                {
                    string type = _utils.TypeCodeToParamTypeCode(item.Type);
                    _entities.BARS_ASYNC_ADM_ADD_PARAM(item.Name, type, Convert.ToString(item.Value), item.Description);
                    _entities.BARS_ASYNC_ADM_APPEND_SQL_PARAM(scheduler.Code, item.Name, type);
                }
                _entities.SaveChanges();
            }
            
            return GetByCode(scheduler.Code);
        }

        public Scheduler Update(Scheduler scheduler)
        {
            const string sql = @"begin bars_async_adm.add_sql(:p_sql_code,:p_sql_text,:p_exclusion_mode,:p_max_run_secs);end;";
            object[] parameters =
                {
                    new OracleParameter("p_sql_code", OracleDbType.Varchar2){Value = scheduler.Code},
                    new OracleParameter("p_sql_text", OracleDbType.Varchar2){Value = scheduler.SqlText},
                    new OracleParameter("p_exclusion_mode", OracleDbType.Varchar2){Value = scheduler.ExclusionMode},
                    new OracleParameter("p_max_run_secs", OracleDbType.Decimal){Value = scheduler.MaxExecutionTime}
                };
            _entities.ExecuteStoreCommand(sql, parameters);

            //todo: update message

            DeleteParams(scheduler.Code);

            if (scheduler.ParametersList != null)
            {
                foreach (var item in scheduler.ParametersList)
                {
                    string type = _utils.TypeCodeToParamTypeCode(item.Type);
                    _entities.BARS_ASYNC_ADM_ADD_PARAM(item.Name, type, Convert.ToString(item.Value), item.Description);
                    _entities.BARS_ASYNC_ADM_APPEND_SQL_PARAM(scheduler.Code, item.Name, type);
                }
                _entities.SaveChanges();
            }
            return GetByCode(scheduler.Code);
        }

        public bool Delete(int id)
        {
            var scheduler = _entities.ASYNC_ACTION.FirstOrDefault(i=>i.ACTION_ID == id);
            if (scheduler == null)
            {
                return false;
            }
            _entities.ASYNC_ACTION.DeleteObject(scheduler); 
            _entities.SaveChanges();
            if (scheduler.SQL_ID != null)
            {
                DeleteSql((int)scheduler.SQL_ID);
            }

            return true;
        }

        public bool DeleteByCode(string code)
        {
            var scheduler = _entities.ASYNC_ACTION.FirstOrDefault(i => i.ACTION_CODE == code);
            if (scheduler == null)
            {
                return false;
            }
            var actionCode = (int) scheduler.ACTION_ID;
            Delete(actionCode);
            return true;
        }

        public bool DeleteSql(int id)
        {
            var sql = _entities.ASYNC_SQL.FirstOrDefault(i => i.SQL_ID == id);
            if (sql == null)
            {
                return false;
            }

            var param = _entities.ASYNC_SQL_PARAM.Where(i => i.SQL_ID == id);
            if (param.Count() != 0)
            {
                DeleteParams("");
            }

            _entities.ASYNC_SQL.DeleteObject(sql);
            _entities.SaveChanges();
            return true;
        }

        public void DeleteParams(string code)
        {
            object[] parameters =
                {
                    new OracleParameter("p_sql_code", OracleDbType.Varchar2){Value = code},
                    new OracleParameter("p_param_name", OracleDbType.Varchar2){Value = null}
                };
            const string sql = @"begin bars_async_adm.del_param(:p_sql_code,:p_param_name);end;";
            _entities.ExecuteStoreCommand(sql, parameters);
        }

        public List<TaskParameter> GetParameters(string schedulerCode)
        {
            const string sql = @"select 
                                    param_pos,
                                    param_name,
                                    param_type, 
                                    default_value,
                                    user_prompt,
                                    action_code
                                from
                                    v_async_action_param
                                where
                                    action_code = :p_action_code";
            var connection = OraConnector.Handler.IOraConnection.GetUserConnection();
            var command = connection.CreateCommand();
            command.CommandText = sql;
            command.CommandType = CommandType.Text;
            command.Parameters.Add("p_action_code", OracleDbType.Varchar2, schedulerCode, ParameterDirection.Input);
            var resultList = new List<TaskParameter>();

            try
            {
                if (command.Connection.State != ConnectionState.Open) 
                    command.Connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        resultList.Add(new TaskParameter
                        {
                            Name = Convert.ToString(reader["param_name"]),
                            Type = _utils.ParamTypeCodeToTypeCode(Convert.ToString(reader["param_type"])),
                            Value =reader["default_value"],
                            Description = Convert.ToString(reader["user_prompt"]),
                            Position = Convert.ToInt32(reader["param_pos"]),
                            SchedulerCode = Convert.ToString(reader["action_code"])
                        });
                    }
                }
            }
            finally
            {
                if (command.Connection.State != ConnectionState.Open) command.Connection.Close();
                command.Dispose();
                if (connection.State != ConnectionState.Open) connection.Close();
                connection.Dispose();
            }

            return resultList;
        }
    }
}