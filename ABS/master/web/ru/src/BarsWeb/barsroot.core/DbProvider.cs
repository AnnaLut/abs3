using System.Data;
using System.Web;
using System;
using System.Data.Common;
using System.Security;
using System.Security.Permissions;
using Oracle.DataAccess.Client;

namespace barsroot.core
{
    /// <summary>
    /// Провайдер для перехвата открытия соединения к базе
    /// </summary>
    public sealed class BBProviderFactory : DbProviderFactory
    {
        public static BBProviderFactory Instance = new BBProviderFactory();

        static BBProviderFactory()
        {
            Instance = new BBProviderFactory();
        }

        public BBProviderFactory()
        {
        }

        public void OnStateChange(object sender, StateChangeEventArgs e)
        {
            // на открытии соединения устанавливаем параметры глобализации
            if (e.OriginalState != ConnectionState.Open && e.CurrentState == ConnectionState.Open)
            {
                // Выполняем только если есть был выполнен login_user
                bool userLoggedIn = (HttpContext.Current.Session["UserLoggedIn"] == null) ? (false) : (Convert.ToBoolean(HttpContext.Current.Session["UserLoggedIn"]));
                if (userLoggedIn)
                {
                    OracleConnection con = (OracleConnection)sender;
                    OracleCommand cmd = con.CreateCommand();
                    // идентификатор сесии
                    string sessionID = HttpContext.Current.Session.SessionID;

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "bars.bars_login.set_user_session";
                    cmd.Parameters.Add("session_id", OracleDbType.Varchar2, sessionID, ParameterDirection.Input);
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (OracleException ex)
                    {
                        if (ex.Message.StartsWith("ORA-20984") /*Банковский день закрыт*/ ||
                            ex.Message.StartsWith("ORA-20982") /*Попытка представления сессией без ее регистрации с помощью LOGIN_USER*/ ||
                            ex.Message.StartsWith("ORA-20981") /*Не передан идентификатор сессии или он пустой*/
                           )
                        {
                            HttpContext.Current.Session.Abandon();
                            if (ex.Message.StartsWith("ORA-20984"))
                            {
                                HttpContext.Current.Response.Write("<script language=javascript>alert('Банківський день закрито. Спробуйте перезайти в систему.');parent.location.reload();</script>");
                                HttpContext.Current.Response.Flush();
                            }
                        }
                        else
                            throw;
                    }
                    ValidLic((OracleConnection) sender);

                    cmd.Dispose();
                }

            }
        }

        public void ValidLic(OracleConnection conn)
        {
            if (HttpContext.Current.Session["IsLicenseValid"] == null)
            {
                OracleCommand cmd = conn.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "begin bars_lic.validate_lic(sys_context('bars_global','user_name')); end;";

                try
                {
                    cmd.ExecuteNonQuery();
                    HttpContext.Current.Session["IsLicenseValid"] = true;
                }
                catch (OracleException e)
                {
                    throw e;
                }
            }
        }
        public override DbConnection CreateConnection()
        {
            // создаем соединение
            OracleConnection con = (OracleConnection)OracleClientFactory.Instance.CreateConnection();
            // навешиваем обработчик на открытие соединения
            con.StateChange += OnStateChange;
            // возвращаем соединение
            return con;
        }

        // Methods
        public override DbCommand CreateCommand()
        {
            return OracleClientFactory.Instance.CreateCommand();
        }

        public override DbCommandBuilder CreateCommandBuilder()
        {
            return OracleClientFactory.Instance.CreateCommandBuilder();
        }

        public override DbConnectionStringBuilder CreateConnectionStringBuilder()
        {
            return OracleClientFactory.Instance.CreateConnectionStringBuilder();
        }

        public override DbDataAdapter CreateDataAdapter()
        {
            return OracleClientFactory.Instance.CreateDataAdapter();
        }

        public override DbDataSourceEnumerator CreateDataSourceEnumerator()
        {
            return OracleClientFactory.Instance.CreateDataSourceEnumerator();
        }

        public override DbParameter CreateParameter()
        {
            return OracleClientFactory.Instance.CreateParameter();
        }

        public override CodeAccessPermission CreatePermission(PermissionState state)
        {
            return OracleClientFactory.Instance.CreatePermission(state);
        }

        public override bool CanCreateDataSourceEnumerator
        {
            get
            {
                return OracleClientFactory.Instance.CanCreateDataSourceEnumerator;
            }
        }
    }
}
