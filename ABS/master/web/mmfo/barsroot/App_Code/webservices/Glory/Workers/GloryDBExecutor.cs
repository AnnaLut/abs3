using Bars.Classes;
using barsroot.core;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.SessionState;

namespace Bars.WebServices.Glory
{
    /// <summary>
    /// Сервис для работы с базой данных
    /// </summary>
    public class GloryDBExecutor
    {
        //CancellationTokenSource cancellationToken;
        /// <summary>
        /// Отправка уведомления об отсутствии связи с АТМ
        /// </summary>
        /// <param name="message"></param>
        public void ExecuteATMDisconnect(String message, String userLogin)
        {
            Task.Factory.StartNew(() => ExecureErrorLog(userLogin))
                .ContinueWith(tsk => OnThreadComplete(tsk),
                TaskContinuationOptions.None);
        }

        public void ExecureErrorLog(String userLogin)
        {
            String query = "bars.teller_tools.set_atm_fault";
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("p_user", OracleDbType.Varchar2, userLogin, ParameterDirection.Input));
            ExecuteProcedure(query, parameters);
        }

        public void OnThreadComplete(Task tsk)
        {

        }

        /// <summary>
        /// Обработка вызова процедуры в БД
        /// </summary>
        /// <param name="query"></param>
        /// <param name="parameters"></param>
        private void ExecuteProcedure(String query, List<OracleParameter> parameters)
        {
            using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.Parameters.Clear();
                    cmd.CommandText = query;
                    cmd.BindByName = true;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddRange(parameters.ToArray());
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}