using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Windows.Forms;
using AttributeRouting.Helpers;
using Bars.Classes;
using BarsWeb.Areas.OpenCloseDay.Helpers;
using BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Abstract;
using BarsWeb.Areas.OpenCloseDay.Models;
using Dapper;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Oracle;

namespace BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Implementation
{
    public class StatisticsOperations : IStatisticsOperations
    {
        public List<BranchStage> GetBranchStages()
        {
            var list = new List<BranchStage>();
            var error = new ErrorInfo();
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.get_branch_stages";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;
                
                command.Parameters.Add("E_DATA", OracleDbType.RefCursor, ParameterDirection.ReturnValue);

                command.ExecuteNonQuery();
                var read = command.ExecuteReader();
                           
                //Read RefCursor
                while (read.Read())
                {
                    var item = new BranchStage();

                    if (!read.IsDBNull(0))
                        item.BRANCH = read.GetString(0);
                    if (!read.IsDBNull(1))
                        item.BRANCH_NAME = read.GetString(1);
                    if (!read.IsDBNull(2))
                        item.STAGE_NAME = read.GetString(2);
                    if (!read.IsDBNull(3))
                        item.STAGE_TIME = read.GetDateTime(3);
                    if (!read.IsDBNull(4))
                        item.STAGE_USER = read.GetString(4);
                    if (!read.IsDBNull(5))
                        item.IS_READY = Convert.ToInt32(read.GetDecimal(5));
                    

                    list.Add(item);
                }
                if (read.NextResult())
                {
                    while (read.Read())
                    {
                        if (!read.IsDBNull(0))
                            error.TASK_DESCRIPTION = read.GetString(0);
                        if (!read.IsDBNull(1))
                            error.ERR_MSG = read.GetString(1);
                    }
                }
                command.Connection.Close();
                return list;
            }
        }

        public List<BranchStage> GetAllBranchStages()
        {
            var list = new List<BranchStage>();
            var error = new ErrorInfo();
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.get_all_branch_stages";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;

                command.Parameters.Add("E_DATA", OracleDbType.RefCursor, ParameterDirection.ReturnValue);

                command.ExecuteNonQuery();
                var read = command.ExecuteReader();

                //Read RefCursor
                while (read.Read())
                {
                    var item = new BranchStage();

                    if (!read.IsDBNull(0))
                        item.BRANCH = read.GetString(0);
                    if (!read.IsDBNull(1))
                        item.BRANCH_NAME = read.GetString(1);
                    if (!read.IsDBNull(2))
                        item.STAGE_NAME = read.GetString(2);
                    if (!read.IsDBNull(3))
                        item.STAGE_TIME = read.GetDateTime(3);
                    if (!read.IsDBNull(4))
                        item.STAGE_USER = read.GetString(4);
                    if (!read.IsDBNull(5))
                        item.IS_READY = Convert.ToInt32(read.GetDecimal(5));


                    list.Add(item);
                }
                if (read.NextResult())
                {
                    while (read.Read())
                    {
                        if (!read.IsDBNull(0))
                            error.TASK_DESCRIPTION = read.GetString(0);
                        if (!read.IsDBNull(1))
                            error.ERR_MSG = read.GetString(1);
                    }
                }
                command.Connection.Close();
                return list;
            }
        }

        public int GetDeployRunId(DateTime date)
        {
            var sql = @"gl_ui.deploy_run";

            var p = new DynamicParameters();

            p.Add("p_next_date", dbType: DbType.Date, value: date, direction: ParameterDirection.Input);
            p.Add("p_deploy_id", dbType: DbType.Int32, direction: ParameterDirection.ReturnValue);
            
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p, commandType: CommandType.StoredProcedure);
            }
            return p.Get<Int32>("p_deploy_id");
        }

        public List<OPTask> GetTaskList(int session_id)
        { 
            var list = new List<OPTask>();
            var error = new ErrorInfo();

            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.get_task_list";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;


                command.Parameters.Add("SYS_REFCURSOR", OracleDbType.RefCursor, ParameterDirection.ReturnValue);
                command.Parameters.Add("P_RUN_ID", OracleDbType.Decimal, session_id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                var read = command.ExecuteReader();
                           
                //Read RefCursor
                while (read.Read())
                {
                    var item = new OPTask();

                    if (!read.IsDBNull(0))
                        item.TASK_ID = read.GetDecimal(0);
                    if (!read.IsDBNull(1))
                        item.SEQUENCE_NUMBER = read.GetDecimal(1);
                    if (!read.IsDBNull(2))
                        item.TASK_NAME = read.GetString(2);
                    if (!read.IsDBNull(3))
                        item.IS_ON = read.GetDecimal(3);
                    if (!read.IsDBNull(4))
                        item.SHOW_BRANCHES = read.GetDecimal(4);                   

                    list.Add(item);
                }
                if (read.NextResult())
                {
                    while (read.Read())
                    {
                        if (!read.IsDBNull(0))
                            error.TASK_DESCRIPTION = read.GetString(0);
                        if (!read.IsDBNull(1))
                            error.ERR_MSG = read.GetString(1);
                    }
                }
                command.Connection.Close();
                return list;
            }
        }

        public List<OPBranchTask> GetBranchTaskList(int session_id, int func_id)
        {
            var list = new List<OPBranchTask>();
            var error = new ErrorInfo();

            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.get_task_branch_list";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;


                command.Parameters.Add("SYS_REFCURSOR", OracleDbType.RefCursor, ParameterDirection.ReturnValue);
                command.Parameters.Add("P_RUN_ID", OracleDbType.Decimal, session_id, ParameterDirection.Input);
                command.Parameters.Add("P_TASK_ID", OracleDbType.Decimal, func_id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                var read = command.ExecuteReader();

                //Read RefCursor
                while (read.Read())
                { 
                    var item = new OPBranchTask();

                    if (!read.IsDBNull(0))
                        item.TASK_RUN_ID = read.GetDecimal(0);
                    if (!read.IsDBNull(1))
                        item.BRANCH_CODE = read.GetString(1);
                    if (!read.IsDBNull(2))
                        item.BRANCH_NAME = read.GetString(2);
                    if (!read.IsDBNull(3))
                        item.IS_ON = read.GetDecimal(3);
                    if (!read.IsDBNull(4))
                        item.TASK_RUN_STATE = read.GetString(4);

                    list.Add(item);
                }
                if (read.NextResult())
                {
                    while (read.Read())
                    {
                        if (!read.IsDBNull(0))
                            error.TASK_DESCRIPTION = read.GetString(0);
                        if (!read.IsDBNull(1))
                            error.ERR_MSG = read.GetString(1);
                    }
                }
                command.Connection.Close();
                return list;
            }
        }

        public void EnableTaskForRun(int session_id, int func_id)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.enable_task_for_run";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;
                command.Parameters.Add("P_RUN_ID", OracleDbType.Decimal, session_id, ParameterDirection.Input);
                command.Parameters.Add("P_TASK_ID", OracleDbType.Decimal, func_id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }

        public void DisableTaskForRun(int session_id, int func_id)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.disable_task_for_run";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;

                command.Parameters.Add("P_RUN_ID", OracleDbType.Decimal, session_id, ParameterDirection.Input);
                command.Parameters.Add("P_TASK_ID", OracleDbType.Decimal, func_id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }
        public void EnableTaskForBranch(int func_id)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.enable_task_for_branch";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;
                
                command.Parameters.Add("P_TASK_RUN_ID", OracleDbType.Decimal, func_id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }
        public void DisableTaskForBranch(int func_id)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.disable_task_for_branch";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;
                
                command.Parameters.Add("P_TASK_RUN_ID", OracleDbType.Decimal, func_id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }
        public List<OpenCloseHistoryItem> GetRunHistory()
        { 
            var sql = @"select* from v_tms_run t order by t.id desc";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var item = connection.Query<OpenCloseHistoryItem>(sql).ToList();
                return item;
            }
        }
        public void StartRun(int run_id)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.start_run";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;

                command.Parameters.Add("P_RUN_ID", OracleDbType.Decimal, run_id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }
        public void SetNewBankDate(int run_id, DateTime new_date)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.set_new_bank_date";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;

                command.Parameters.Add("P_RUN_ID", OracleDbType.Decimal, run_id, ParameterDirection.Input);
                command.Parameters.Add("P_NEW_BANK_DATE", OracleDbType.Date, new_date, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }
        public OpenCloseMonitorInfo GetTaskMonitor(int deploy_run_id)
        {
            var list = new List<OpenCLoseFuncMonitorItem>();
            var error = new ErrorInfo();
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.get_task_monitor";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;
                
                command.Parameters.Add("p_run_id", OracleDbType.Decimal, deploy_run_id, ParameterDirection.Input);

                command.Parameters.Add("p_current_date", OracleDbType.Date, ParameterDirection.Output);
                command.Parameters.Add("p_new_date", OracleDbType.Date, ParameterDirection.Output);
                command.Parameters.Add("p_run_state_id", OracleDbType.Decimal, ParameterDirection.Output);
                command.Parameters.Add("p_run_state_name", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                command.Parameters.Add("p_task_data", OracleDbType.RefCursor, ParameterDirection.Output);


                command.ExecuteNonQuery();
                var read = command.ExecuteReader();
                var current_date = ((OracleDate)command.Parameters["p_current_date"].Value).IsNull ? new DateTime(1999, 1, 1) : ((OracleDate)command.Parameters["p_current_date"].Value).Value;
                var new_date = ((OracleDate)command.Parameters["p_new_date"].Value).IsNull ? new DateTime(1999, 1, 1) : ((OracleDate)command.Parameters["p_new_date"].Value).Value;
                var run_state_id = ((OracleDecimal)command.Parameters["p_run_state_id"].Value).IsNull ? 4 : ((OracleDecimal)command.Parameters["p_run_state_id"].Value).Value;
                var run_state_name = ((OracleString)command.Parameters["p_run_state_name"].Value).IsNull ? "" : ((OracleString)command.Parameters["p_run_state_name"].Value).Value;

                //Read RefCursor
                while (read.Read())
                {
                    var func = new OpenCLoseFuncMonitorItem();

                    if (!read.IsDBNull(0))
                        func.ID = read.GetDecimal(0);
                    if (!read.IsDBNull(1))
                        func.SEQUENCE_NUMBER = read.GetDecimal(1);
                    if (!read.IsDBNull(2))
                        func.TASK_NAME = read.GetString(2);
                    if (!read.IsDBNull(3))
                        func.BRANCH_CODE = read.GetString(3);
                    if (!read.IsDBNull(4))
                        func.BRANCH_NAME = read.GetString(4);
                    if (!read.IsDBNull(5))
                        func.START_TIME = read.GetDateTime(5);
                    if (!read.IsDBNull(6))
                        func.FINISH_TIME = read.GetDateTime(6);
                    if (!read.IsDBNull(7))
                        func.TASK_RUN_STATE = read.GetString(7);
                    if (!read.IsDBNull(8))
                        func.BUTTON_FLAGS = NumberList.FromObject(read.GetOracleValue(8)).ReplaceNullValues(0);

                    list.Add(func);
                }
                if (read.NextResult())
                {
                    while (read.Read())
                    {
                        if (!read.IsDBNull(0))
                            error.TASK_DESCRIPTION = read.GetString(0);
                        if (!read.IsDBNull(1))
                            error.ERR_MSG = read.GetString(1);
                    }
                }
                command.Connection.Close();
                return new OpenCloseMonitorInfo()
                {
                    P_CURRENT_DATE = current_date,
                    P_NEW_DATE = new_date,
                    P_RUN_STATE_ID = run_state_id,
                    P_RUN_STATE_NAME = run_state_name,
                    P_TASK_DATA = list
                };
            }
        }

        public List<OpenCloseBranchStage> GetBranchStageDirectory()
        {
            var list = new List<OpenCloseBranchStage>();
            var error = new ErrorInfo();
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.get_branch_stage_directory";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;


                command.Parameters.Add("SYS_REFCURSOR", OracleDbType.RefCursor, ParameterDirection.ReturnValue);
                command.ExecuteNonQuery();
                var read = command.ExecuteReader();

                while (read.Read())
                {
                    var item = new OpenCloseBranchStage();

                    if (!read.IsDBNull(0))
                        item.LIST_ITEM_ID = read.GetDecimal(0);
                    if (!read.IsDBNull(1))
                        item.LIST_ITEM_NAME = read.GetString(1);

                    list.Add(item);
                }
                if (read.NextResult())
                {
                    while (read.Read())
                    {
                        if (!read.IsDBNull(0))
                            error.TASK_DESCRIPTION = read.GetString(0);
                        if (!read.IsDBNull(1))
                            error.ERR_MSG = read.GetString(1);
                    }
                }
                command.Connection.Close();
                return list;
            }
        }

        public void SetSingleBranchStage(string branch_code, int stage_id)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.set_branch_stage";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;

                command.Parameters.Add("P_BRANCH_CODE", OracleDbType.Varchar2, branch_code, ParameterDirection.Input);
                command.Parameters.Add("P_STAGE_ID", OracleDbType.Decimal, stage_id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }
        public OpenCloseStateInfo GetTaskRunReportData(int mon_id)
        {
            var sql = @"gl_ui.get_task_run_report_data";
            var p = new DynamicParameters();

            p.Add("P_TASK_RUN_ID", dbType: DbType.Int32, value: mon_id, direction: ParameterDirection.Input);
            p.Add("CLOB_DATA", dbType: DbType.String, size: 10000, direction: ParameterDirection.ReturnValue);
            //WARNING! Names of parametres must be the same with names in function
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p, commandType: CommandType.StoredProcedure);
            }

            string example_value_1 = p.Get<string>("CLOB_DATA");

            return new OpenCloseStateInfo()
            {
                MESSAGE_INFO = example_value_1
            };
            
        }
        public void MonitorStartTaskRun(int id)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.start_task_run";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;

                command.Parameters.Add("P_RUN_ID", OracleDbType.Decimal, id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }
        public void MonitorTerminateTaskRun(int id)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.terminate_task_run";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;

                command.Parameters.Add("P_RUN_ID", OracleDbType.Decimal, id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }
        public void MonitorDisableTaskRun(int id)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.disable_task_run";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;

                command.Parameters.Add("P_RUN_ID", OracleDbType.Decimal, id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }

        }
        public void MonitorRepeatTaskRun(int id)
        {
            using (var command = new OracleCommand())
            {
                command.CommandText = "gl_ui.repeat_task_run";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;

                command.Parameters.Add("P_RUN_ID", OracleDbType.Decimal, id, ParameterDirection.Input);

                command.ExecuteNonQuery();
                command.Connection.Close();
            }
        }

    }
}