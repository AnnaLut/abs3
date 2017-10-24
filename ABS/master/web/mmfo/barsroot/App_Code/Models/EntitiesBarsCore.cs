using System.Data;
using System.Data.EntityClient;
using System.Web;
using barsroot.core;
using BarsWeb.Infrastructure;
using Models;

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
                    var command = conn.StoreConnection.CreateCommand();
                    command.CommandText = "begin bars.bars_login.set_user_session('" + System.Web.HttpContext.Current.Session.SessionID + "'); end;";
                    command.ExecuteNonQuery();
                    //_newEntity.ExecuteStoreCommand("begin bars.bars_login.set_user_session('" + System.Web.HttpContext.Current.Session.SessionID + "'); end;");
                }
                catch (Oracle.DataAccess.Client.OracleException ex)
                {
                    if (ex.Message.StartsWith("ORA-20984") /*Банковский день закрыт*/||
                        ex.Message.StartsWith("ORA-20982")
                        /*Попытка представления сессией без ее регистрации с помощью LOGIN_USER*/||
                        ex.Message.StartsWith("ORA-20981") /*Не передан идентификатор сессии или он пустой*/
                        )
                    {
                        System.Web.HttpContext.Current.Session.Abandon();
                        if (ex.Message.StartsWith("ORA-20984"))
                        {
                            System.Web.HttpContext.Current.Response.Write(
                                "<script language=javascript>alert('Банківський день закрито. Спробуйте перезайти в систему.');parent.location.reload();</script>");
                            System.Web.HttpContext.Current.Response.Flush();
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
            string connStr = "metadata=res://*/App_Code.Models." + modelName + ".csdl|res://*/App_Code.Models." + modelName + ".ssdl|res://*/App_Code.Models." + modelName + ".msl;provider=Oracle.DataAccess.Client;";//barsroot.core;
            connStr += "provider connection string=\"";
            string userConnStr = "";
            try
            {
                userConnStr = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
            }
            catch (BarsCoreException e)
            {
                var response = HttpContext.Current.Response;
                response.Redirect(Constants.LoginPageUrl);
                response.End();
                response.Flush();
            }
            connStr += userConnStr + "\"";
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
            //_newEntity.Connection.StateChange += new StateChangeEventHandler(OnStateChange);
            AddStateChange(newEntity.Connection);
            return newEntity;
        }
    }
}