using System.Web;
using barsroot.core;
using BarsWeb.Infrastructure;
using Models;
using System.Data.EntityClient;
using System.Data;
using Oracle.DataAccess.Client;

namespace BarsWeb.Models
{
    /// <summary>
    /// Сводное описание для EntitiesBarsCore
    /// </summary>
    public partial class EntitiesBarsCore 
    {
        private void AddStateChange(System.Data.Common.DbConnection conn)
        {
            conn.StateChange += OnStateChange;
        }

        /// <summary>
        /// обработка события открытия подключения
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="ev"></param>
        public void OnStateChange(object sender, StateChangeEventArgs ev)
        {
            if (ev.OriginalState != ConnectionState.Open && ev.CurrentState == ConnectionState.Open)
            {
                try
                {
                    var conn = (EntityConnection)sender;
                    string sessionId = HttpContext.Current.Session.SessionID;
                    using (var command = conn.StoreConnection.CreateCommand())
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.CommandText = "bars.bars_login.set_user_session";
                        command.Parameters.Add(new OracleParameter("p_sessionid", sessionId));
                        command.ExecuteNonQuery();
                    }
                }
                catch (OracleException ex)
                {
                    if (ex.Message.StartsWith("ORA-20984") /*Банковский день закрыт*/||
                        ex.Message.StartsWith("ORA-20982")
                        /*Попытка представления сессией без ее регистрации с помощью LOGIN_USER*/||
                        ex.Message.StartsWith("ORA-20981") /*Не передан идентификатор сессии или он пустой*/
                        )
                    {
                        HttpContext.Current.Session.Abandon();
                        if (ex.Message.StartsWith("ORA-20984"))
                        {
                            HttpContext.Current.Response.Write(
                                "<script language=javascript>alert('Банківський день закрито. Спробуйте перезайти в систему.');parent.location.reload();</script>");
                            HttpContext.Current.Response.Flush();
                        }
                    }
                    else
                    {
                        throw ex;
                    }
                }
            }
        }

        /// <summary>
        /// строка подключения пользователя для EF
        /// </summary>
        /// <returns></returns>
        private string UserConnStr(string modelName = "EntityBarsModel")
        {
            string connStr = string.Empty;

            try
            {
                string userConnStr = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
                connStr = string.Format("metadata =res://*/App_Code.Models.{0}.csdl|res://*/App_Code.Models.{0}.ssdl|res://*/App_Code.Models.{0}.msl;provider=Oracle.DataAccess.Client;provider connection string=\"{1}\"", 
                                         modelName, 
                                         userConnStr);
            }
            catch (BarsCoreException e)
            {
                var response = HttpContext.Current.Response;
                response.Redirect(Constants.LoginPageUrl);
                response.End();
                response.Flush();
            }
            return connStr;
        }
        /// <summary>
        /// создание контекста модели
        /// </summary>
        /// <param name="connectionStr">строка подключения к базе(если параметр не передавать то стороку вернет UserConnStr())</param>
        /// <returns>новый контекст EntitiesBars()</returns>
        public EntitiesBars NewEntity(string connectionStr="")
        {
            connectionStr = string.IsNullOrWhiteSpace(connectionStr) ? UserConnStr() : connectionStr;
            var newEntity = new EntitiesBars(connectionStr);
            AddStateChange(newEntity.Connection);
            return newEntity;
        }
    }
}