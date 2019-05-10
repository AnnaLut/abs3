using Bars.Classes;
using barsroot.core;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.SessionState;

namespace Bars.WebServices.Glory
{
    /// <summary>
    /// Сервис для работы с базой данных
    /// </summary>
    public class GloryDBExecutor
    {

        /// <summary>
        /// Отправка уведомления об отсутствии связи с АТМ
        /// </summary>
        /// <param name="message"></param>
        public void ExecuteATMDisconnect(String message, HttpSessionState session, String userLogin)
        {
            if(session["UserLoggedIn"] == null)
                this.LoginUser(userLogin, session);
            String query = "bars.teller_tools.set_atm_fault";
            List<OracleParameter> parameters = new List<OracleParameter>();
            ExecuteProcedure(query, parameters);
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

        /// <summary>
        /// Логирование пользователя
        /// </summary>
        /// <param name="_userName">Имя пользователя</param>
        /// <param name="session">HttpSession</param>
        /// <param name="sessionId">ИД Сессии</param>
        private void LoginUser(String _userName, HttpSessionState session)
        {
            // Інформація про поточного користувача
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(_userName);
            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                OracleCommand cmd = con.CreateCommand();
                using (con)
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "bars.bars_login.login_user";

                    cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, session.SessionID, ParameterDirection.Input);
                    cmd.Parameters.Add("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input);
                    cmd.Parameters.Add("p_hostname", OracleDbType.Varchar2, RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), ParameterDirection.Input);
                    cmd.Parameters.Add("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);

                    cmd.ExecuteNonQuery();
                }
            }
            session["UserLoggedIn"] = true;
        }
    }
}