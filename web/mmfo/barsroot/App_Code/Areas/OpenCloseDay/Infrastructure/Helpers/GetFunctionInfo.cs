using System;
using System.Collections.Generic;
using System.Data;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.OpenCloseDay.Helpers
{
    public class GetFunctionInfo
    {
        public static void PushFuncList(List<FunctionInfo> functionList, int idGroup)
        {
            var functionInfoList = new FunctionInfoList();
            functionInfoList.FunctionInfoArray = functionList.ToArray();

            using (var context = new DbAccess())
            {
                try
                {
                    var parameters = new OracleParameter[2];
                    parameters[0] = DbAccess.CreateCustomTypeArrayInputParameter("TASK_LIST_INFO", "BARS.TMS_TAB_LIST_INFO", functionInfoList);
                    parameters[1] = new OracleParameter("P_ID_GROUP", OracleDbType.Int16, idGroup, ParameterDirection.Input);
                    var result = context.CreateCommand("BARS.TMS_UTL.START_GROUP", CommandType.StoredProcedure, parameters);
                    result.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }

    }
}
