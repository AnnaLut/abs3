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
                MaxExecutionTime = (int?)i.MAX_RUN_SECS,
                Name = i.NAME,
                Description = i.DESCRIPTION
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
            UpdateSql(scheduler);

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

            AddParametersList(scheduler.ParametersList, scheduler.Code);

            return GetByCode(scheduler.Code);
        }

        public Scheduler Update(Scheduler scheduler)
        {
            UpdateSql(scheduler);

            //todo: update message

            DeleteParams(scheduler.Code);
            AddParametersList(scheduler.ParametersList, scheduler.Code);

            return GetByCode(scheduler.Code);
        }

        public void AddParametersList(List<TaskParameter> paramsList, string schedulerCode)
        {
            if (paramsList != null)
            {
                foreach (var item in paramsList)
                {
                    decimal paramId = AddParameter(item);
                    AppendSqlParam(schedulerCode, paramId);
                    //string type = _utils.TypeCodeToParamTypeCode(item.Type);
                    //_entities.BARS_ASYNC_ADM_ADD_PARAM(item.Name, type, Convert.ToString(item.Value), item.Description);
                    //_entities.BARS_ASYNC_ADM_APPEND_SQL_PARAM(schedulerCode, item.Name, type);
                }
                _entities.SaveChanges();
            }
        }

        public decimal AddParameter(TaskParameter parameter)
        {
            const string sql = @"begin bars_async_adm.add_param(
                                    :p_param_name,
                                    :p_param_type,
                                    :p_default_value,
                                    :p_user_prompt,
                                    :p_min,
                                    :p_max,
                                    :p_ui_type,
                                    :p_directory,
                                    :p_param_id);
                                end;";
            object[] parameters =
                {
                    new OracleParameter("p_param_name", OracleDbType.Varchar2){Value = parameter.Name.ToUpper()},
                    new OracleParameter("p_param_type", OracleDbType.Varchar2){Value = parameter.OriginalDbType},
                    new OracleParameter("p_default_value", OracleDbType.Varchar2){Value = parameter.Value},
                    new OracleParameter("p_user_prompt", OracleDbType.Varchar2){Value = parameter.Description},
                    new OracleParameter("p_min", OracleDbType.Varchar2){Value = parameter.Minimum},
                    new OracleParameter("p_max", OracleDbType.Varchar2){Value = parameter.Maximum},
                    new OracleParameter("p_ui_type", OracleDbType.Varchar2){Value = parameter.UiType},
                    new OracleParameter("p_directory", OracleDbType.Varchar2){Value = parameter.Directory},
                    new OracleParameter("p_param_id", OracleDbType.Decimal){Direction = ParameterDirection.Output}
                };
            _entities.ExecuteStoreCommand(sql, parameters);
            return Convert.ToDecimal(((OracleParameter)parameters[8]).Value.ToString());
        }

        public void AppendSqlParam(string schedulerCode, decimal paramId)
        {
            const string sql = @"begin bars_async_adm.append_sql_param(
                                    :p_sql_code,
                                    :p_param_id);
                                end;";
            object[] parameters =
                {
                    new OracleParameter("p_sql_code", OracleDbType.Varchar2){Value = schedulerCode.ToUpper()},
                    new OracleParameter("p_param_id", OracleDbType.Decimal){Value = paramId}
                };
            _entities.ExecuteStoreCommand(sql, parameters);
        }

        public void UpdateSql(Scheduler scheduler)
        {
            const string sql = @"begin bars_async_adm.add_sql(
                                    :p_sql_code,
                                    :p_sql_text,
                                    :p_exclusion_mode,
                                    :p_max_run_secs,
                                    :p_name,
                                    :p_session_params,
                                    :p_parallel_params,
                                    :p_description);
                                end;";
            object[] parameters =
                {
                    new OracleParameter("p_sql_code", OracleDbType.Varchar2){Value = scheduler.Code.ToUpper()},
                    new OracleParameter("p_sql_text", OracleDbType.Varchar2){Value = scheduler.SqlText},
                    new OracleParameter("p_exclusion_mode", OracleDbType.Varchar2){Value = scheduler.ExclusionMode},
                    new OracleParameter("p_max_run_secs", OracleDbType.Decimal){Value = scheduler.MaxExecutionTime},
                    new OracleParameter("p_name", OracleDbType.Varchar2){Value = scheduler.Name},
                    new OracleParameter("p_session_params", OracleDbType.Varchar2){Value = null},
                    new OracleParameter("p_parallel_params", OracleDbType.Varchar2){Value = null},
                    new OracleParameter("p_description", OracleDbType.Varchar2){Value = scheduler.Description}
                };
            _entities.ExecuteStoreCommand(sql, parameters);
        }

        public bool Delete(int id)
        {
            var scheduler = _entities.ASYNC_ACTION.FirstOrDefault(i=>i.ACTION_ID == id);
            if (scheduler == null)
            {
                return false;
            }

            object[] parameters =
            {
                new OracleParameter("p_sql_code", OracleDbType.Decimal){Value = id}
            };
            const string sql = @"begin bars_async_adm.del_action(:p_action_id);end;";
            _entities.ExecuteStoreCommand(sql, parameters);

            /*if (scheduler.SQL_ID != null)
            {
                DeleteSql((int)scheduler.SQL_ID);
            }

            _entities.ASYNC_ACTION.DeleteObject(scheduler); 
            _entities.SaveChanges();*/


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
                                    min,
                                    max,
                                    ui_type,
                                    directory,
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
                            OriginalDbType = Convert.ToString(reader["param_type"]),
                            Value = reader["default_value"],
                            Description = Convert.ToString(reader["user_prompt"]),
                            Minimum = Convert.ToString(reader["min"]),
                            Maximum = Convert.ToString(reader["max"]),
                            UiType = Convert.ToString(reader["ui_type"]),
                            Directory = Convert.ToString(reader["directory"]),
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