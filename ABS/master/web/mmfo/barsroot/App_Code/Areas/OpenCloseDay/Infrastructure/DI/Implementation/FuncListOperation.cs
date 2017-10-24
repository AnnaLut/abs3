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

namespace BarsWeb.Areas.OpenCloseDay.Infrastructure.DI.Implementation
{
    public class FuncListOperation : IFuncListOperation
    {
        public ReturnModel GetList(string dateType)
        {
            var list = new List<Function>();
            var error = new ErrorInfo();
            using (var command = new OracleCommand())
            {
                command.CommandText = "TMS_UTL.GET_LIST_TASKS";
                command.CommandType = CommandType.StoredProcedure;
                command.Connection = OraConnector.Handler.UserConnection;
                command.Parameters.Add("P_GROUP_NAME", dateType);
                command.Parameters.Add("P_LIST_TASKS", OracleDbType.RefCursor, ParameterDirection.Output);
                command.Parameters.Add("P_GROUP_ID", OracleDbType.Int16, ParameterDirection.Output);
                command.Parameters.Add("P_START_DATE", OracleDbType.Varchar2, 100, null, ParameterDirection.Output);
                command.Parameters.Add("P_DURATION", OracleDbType.Varchar2, 100, null, ParameterDirection.Output);
                command.Parameters.Add("P_STATUS_GROUP", OracleDbType.Varchar2, 100, null, ParameterDirection.Output);
                command.Parameters.Add("P_GROUP_LOG", OracleDbType.Int16, ParameterDirection.Output);
                command.Parameters.Add("P_ERROR_DATA", OracleDbType.RefCursor, ParameterDirection.Output);
                
                command.ExecuteNonQuery();
                var read = command.ExecuteReader();
                var groupId = ((OracleDecimal)command.Parameters["P_GROUP_ID"].Value).IsNull ? 0 : ((OracleDecimal)command.Parameters["P_GROUP_ID"].Value).Value;
                var startDate = ((OracleString)command.Parameters["P_START_DATE"].Value).IsNull ? "" : ((OracleString)command.Parameters["P_START_DATE"].Value).Value;
                var duration = ((OracleString)command.Parameters["P_DURATION"].Value).IsNull ? "" : ((OracleString)command.Parameters["P_DURATION"].Value).Value;
                var statusGroup = ((OracleString)command.Parameters["P_STATUS_GROUP"].Value).IsNull ? "" : ((OracleString)command.Parameters["P_STATUS_GROUP"].Value).Value;
                var groupLog = ((OracleDecimal)command.Parameters["P_GROUP_LOG"].Value).IsNull ? 0 : ((OracleDecimal)command.Parameters["P_GROUP_LOG"].Value).Value;
                
                //Read RefCursor
                while (read.Read())
                {
                    var func = new Function();
                    if (!read.IsDBNull(0))
                        func.TASK_ID = read.GetInt16(0);
                    if (!read.IsDBNull(1))
                        func.TASK_ACTIVE = read.GetString(1);
                    if (!read.IsDBNull(2))
                        func.TASK_DESCRIPTION = read.GetString(2);
                    if (!read.IsDBNull(3))
                        func.TASK_RANK = read.GetInt16(3);
                    if (!read.IsDBNull(4))
                        func.TASK_TYPE = read.GetString(4);
                    if (!read.IsDBNull(5))
                        func.STATUS_TASK = read.GetString(5);
                    if (!read.IsDBNull(6))
                        func.START_TIME = read.GetString(6);
                    if (!read.IsDBNull(7))
                        func.TAST_DURATION = read.GetString(7);

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
                return new ReturnModel()
                {
                    IdGroup = groupId,
                    StartDate = startDate,
                    Duration = duration,
                    StatusGroup = statusGroup,
                    GroupLog = groupLog,
                    ListFunc = list,
                    Error = error
                };
            }
        }

        public void ExecuteFunc(IList<FuncArray> model, string idGroup)
        {
            var funcList = new List<FunctionInfo>();
            foreach (var item in model)
            {
                var func = new FunctionInfo();
                func.TaskId = int.Parse(item.id);
                func.TaskActive = item.active;
                funcList.Add(func);
            }

            var group = int.Parse(idGroup);
            GetFunctionInfo.PushFuncList(funcList, group);
        }

    
        public void RunFailedGroup(int id)
        {
            var p = new DynamicParameters();
            p.Add("P_ID_GROUP_LOG", id);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute("TMS_UTL.RUN_GROUP", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void StopFailGroup(int id)
        {
            var p = new DynamicParameters();
            p.Add("P_ID_GROUP_LOG", id);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute("TMS_UTL.STOP_GROUP", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void RestoreGroup(int id)
        {
            var p = new DynamicParameters();
            p.Add("P_ID_GROUP_LOG", id);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute("TMS_UTL.RESTORE_GROUP", p, commandType: CommandType.StoredProcedure);
            }
        }

        /*public List<History> GetHistory(string date, string dateType)
        {
            DateTime bankDate;
            if (!DateTime.TryParse(date, out bankDate))
                throw new Exception("Не дійсна банківська дата!");
            var connection = OraConnector.Handler.UserConnection;
            var p = new OracleDynamicParameters();
            p.Add("P_GROUP_NAME", dateType, OracleDbType.Varchar2, ParameterDirection.Input);
            p.Add("P_BANK_DATE", DateTime.Parse(date), OracleDbType.Date, ParameterDirection.Input);
            p.Add("P_LIST_TASKS", dbType: OracleDbType.RefCursor, direction: ParameterDirection.Output);
            var multi = connection.Query<History>("TMS_UTL.GET_LIST_TASKS_HIS", param: p,
                commandType: CommandType.StoredProcedure);

            var multi1 = connection.Execute("TMS_UTL.GET_LIST_TASKS_HIS", param: p,
               commandType: CommandType.StoredProcedure);


          List<History> asdas = p.Get<dynamic>("P_LIST_TASKS");
            return null;
        }*/
    }
}