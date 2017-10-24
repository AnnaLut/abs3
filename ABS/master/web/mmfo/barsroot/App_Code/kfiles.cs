using System;
using System.Web;
using System.Web.Services;
using Bars;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Data;
using System.Data.Common;
using barsroot.core;
using Bars.Application;



/// <summary>
/// Summary description for send kfiles
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]


public class kfiles : BarsWebService
{

    private string GetHostName()
    {
        string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
            userHost = HttpContext.Current.Request.UserHostAddress;

        if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
            userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

        return userHost;
    }   
    private void LoginUser(String userName)
    {
        // информация о текущем пользователе
        UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars.bars_login.login_user";

            cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, Session.SessionID, ParameterDirection.Input);
            cmd.Parameters.Add("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input);
            cmd.Parameters.Add("p_hostname", OracleDbType.Varchar2, GetHostName(), ParameterDirection.Input);
            cmd.Parameters.Add("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);

            cmd.ExecuteNonQuery();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        // Если выполнили установку параметров
        Session["UserLoggedIn"] = true;
    }
    

    [WebMethod(EnableSession = true)]
    public String SendData(String Data)
    {
        String UserName = Bars.Configuration.ConfigurationSettings.AppSettings["KFILES.Username"];
        String Password = Bars.Configuration.ConfigurationSettings.AppSettings["KFILES.Pass"];

        String Result;

        // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "kfile_pack.kfile_get";
            cmd.Parameters.Add("xml_body", OracleDbType.Clob, Data, ParameterDirection.Input);
            cmd.Parameters.Add("res_", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            Result = ((OracleString)cmd.Parameters["res_"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["res_"].Value).Value;

            if (Result != null)
            {
                return Result;
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return null;
    }

    [WebMethod(EnableSession = true)]
    public String GetDictCnt()
    {
        String UserName = Bars.Configuration.ConfigurationSettings.AppSettings["KFILES.Username"];
        String Password = Bars.Configuration.ConfigurationSettings.AppSettings["KFILES.Pass"];

        String Result;

        // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "kfile_pack.dict_send_cnt";
            cmd.Parameters.Add("res_", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            Result = ((OracleString)cmd.Parameters["res_"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["res_"].Value).Value;

            if (Result != null)
            {
                return Result;
            }
            
             
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return null;
    }


    [WebMethod(EnableSession = true)]
    public String GetDict(String Data)
    {
        String UserName = Bars.Configuration.ConfigurationSettings.AppSettings["KFILES.Username"];
        String Password = Bars.Configuration.ConfigurationSettings.AppSettings["KFILES.Pass"];

        String Result;

        // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "kfile_pack.dict_send";
            cmd.Parameters.Add("xml_body", OracleDbType.Clob, Data, ParameterDirection.Input);
            cmd.Parameters.Add("res_", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            Result = ((OracleString)cmd.Parameters["res_"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["res_"].Value).Value;

            if (Result != null)
            {
                return Result;
            }
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return null;
    }
}
