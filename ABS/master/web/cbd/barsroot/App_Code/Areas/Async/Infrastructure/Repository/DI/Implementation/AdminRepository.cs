using System;
using System.Collections.Generic;
using System.Data;
using Bars.Classes;
using BarsWeb.Areas.Async.Infrastructure.Repository.DI.Abstract;
using Areas.Async.Models;
using BarsWeb.Areas.Async.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Async.Infrastructure.Repository.DI.Implementation
{
    public class AdminRepository : IAdminRepository
    {
        readonly AsyncEntities _entities;
        public AdminRepository(IAsyncModel model)
        {
		    _entities = model.AsyncEntities;
        }
        private OracleDbType TypeCodeToOracleDbType(TypeCode code)
        {
            switch (code)
            {
                case TypeCode.Char:
                case TypeCode.String:
                    return OracleDbType.Varchar2;
                case TypeCode.Decimal:
                case TypeCode.Double:
                case TypeCode.Int16:
                case TypeCode.Int32:
                case TypeCode.Int64:
                case TypeCode.UInt16:
                case TypeCode.UInt32:
                case TypeCode.UInt64:
                case TypeCode.Boolean:
                    return OracleDbType.Decimal;
                case TypeCode.DateTime:
                    return OracleDbType.Date;
                default:
                    return OracleDbType.Varchar2;
            }
        }

        private TypeCode ParamTypeCodeToTypeCode(string code)
        {
            code = code.Trim().ToUpper();
            switch (code)
            {
                case "DATE":
                    return TypeCode.DateTime;
                case "NUMBER":
                    return TypeCode.Decimal;
                case "VARCHAR2":
                    return TypeCode.String;
                default:
                    return TypeCode.String;
            }
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

            /*var conn = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            var cmd = conn.CreateCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars_async.get_sql_params";
            cmd.Parameters.Clear();

            cmd.Parameters.Add(new OracleParameter("p_sql_code", schedulerCode));
            OracleParameter refCursor = cmd.Parameters.Add("p_params",OracleDbType.RefCursor,ParameterDirection.Output);
            if (conn.State != ConnectionState.Open) conn.Open();
            cmd.ExecuteNonQuery();
            OracleDataReader reader = ((OracleRefCursor)refCursor.Value).GetDataReader();

            var resultList = new List<TaskParameter>();
            while (reader.Read())
            {
                resultList.Add(new TaskParameter
                {
                    Name = (string)reader["param_name"],
                    Type = TypeCode.String,//(string)reader["param_type"],
                    Value = reader["default_value"],
                    Description = (string)reader["user_prompt"]
                });
            }

            refCursor.Dispose();
            if (cmd.Connection.State != ConnectionState.Open) cmd.Connection.Close();
            cmd.Dispose();
            if (conn.State != ConnectionState.Open) conn.Close();
            conn.Dispose();*/

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
                            Type = ParamTypeCodeToTypeCode(Convert.ToString(reader["param_type"])),
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
            
            /*var resultList = new List<TaskParameter>();
            resultList.Add(new TaskParameter
            {
                Name = "P_DATE",
                Type = TypeCode.DateTime,
                Value = DateTime.Now,
                Description = "",
                Position = 1,
                SchedulerCode = "NBU_REP_01"
            });*/

            return resultList;
        }
        public string CreateTask(string schedulerCode)
        {
            /*var name = new OracleParameter("l_job_name", OracleDbType.Varchar2, ParameterDirection.Output);
            object[] parameters =         
            { 
                name,                
                new OracleParameter("p_action_code",OracleDbType.Varchar2,(object)schedulerCode,ParameterDirection.Input)

            };
            const string sql1 = @"select 
                                    bars_async.create_job(:p_action_code)
                                from dual";
            const string sql2 = @"declare
                                    l_job_name varchar2(200); 
                                 begin
                                    :l_job_name := bars_async.create_job(:p_action_code);
                                 end;";
            const string sql3 = @"bars_async.create_job";
            //var taskId = _entities.ExecuteStoreQuery<string>(sql, parameters).FirstOrDefault();
            _entities.ExecuteStoreCommand(sql2, parameters);
            return Convert.ToString(name.Value);*/

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
                    new OracleParameter("p_value", TypeCodeToOracleDbType(item.Type),item.Value,ParameterDirection.Input)
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