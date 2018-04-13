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

public class EQInfo
{
    
}

/// <summary>
/// Summary description for send_sms
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class get_eq : BarsWebService
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
    public  String  Get_eq(Decimal vidd, String ser, String num, String datb, Decimal kv, String kurs, Decimal s, String fio, String drday, String tt)
    {

        String UserName = Bars.Configuration.ConfigurationSettings.AppSettings["VAL.Username"];
        String Password = Bars.Configuration.ConfigurationSettings.AppSettings["VAL.Pass"];
        
        // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        String Result;

        try
        {

            //cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select to_char(limeq.geteq(:fl,:ser, :num, :datb, :kv, :kurs, :s, :fio2, :drday, :tt)) as Result from dual";
            cmd.Parameters.Add("fl", OracleDbType.Int32, vidd, ParameterDirection.Input);
            cmd.Parameters.Add("ser", OracleDbType.Varchar2, ser, ParameterDirection.Input);
            cmd.Parameters.Add("num", OracleDbType.Varchar2, num, ParameterDirection.Input);
            cmd.Parameters.Add("datb", OracleDbType.Varchar2, datb, ParameterDirection.Input);
            cmd.Parameters.Add("kv", OracleDbType.Decimal, kv, ParameterDirection.Input);
            cmd.Parameters.Add("kurs", OracleDbType.Varchar2, kurs, ParameterDirection.Input);
            cmd.Parameters.Add("s", OracleDbType.Decimal, s, ParameterDirection.Input);
            cmd.Parameters.Add("fio2", OracleDbType.Varchar2, fio, ParameterDirection.Input);
            cmd.Parameters.Add("drday", OracleDbType.Varchar2, drday, ParameterDirection.Input);
            cmd.Parameters.Add("tt", OracleDbType.Varchar2, tt, ParameterDirection.Input);
            
            OracleDataReader rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                Result = rdr["Result"] == DBNull.Value ? (String)null : (String)rdr["Result"];
                if (Result != null)
                { return Result; }
                
            }
            rdr.Close();
            rdr.Dispose();


        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return null;
    }

     [WebMethod(EnableSession = true)]
    public String Set_eq(String vdat_, String datb_, String pdat_, Decimal vidd_, String serd_, String pasp_, String fio_, Decimal sq_, Decimal kv_, Decimal s_, String ref_, String branch_, String kurs_, String kuro_, String tt_, String drday_)
    {
        String UserName = Bars.Configuration.ConfigurationSettings.AppSettings["VAL.Username"];
        String Password = Bars.Configuration.ConfigurationSettings.AppSettings["VAL.Pass"];

        String Result;    
         
        // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try 
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "limeq.seteq";
            cmd.Parameters.Add("vdat_", OracleDbType.Varchar2, vdat_, ParameterDirection.Input);
            cmd.Parameters.Add("datb_", OracleDbType.Varchar2, datb_, ParameterDirection.Input);
            cmd.Parameters.Add("pdat_", OracleDbType.Varchar2, pdat_, ParameterDirection.Input);
            cmd.Parameters.Add("vidd_", OracleDbType.Decimal, vidd_, ParameterDirection.Input);
            cmd.Parameters.Add("serd_", OracleDbType.Varchar2, serd_, ParameterDirection.Input);
            cmd.Parameters.Add("pasp_", OracleDbType.Varchar2, pasp_, ParameterDirection.Input);
            cmd.Parameters.Add("fio_", OracleDbType.Varchar2, fio_, ParameterDirection.Input);
            cmd.Parameters.Add("sq_", OracleDbType.Decimal, sq_, ParameterDirection.Input);
            cmd.Parameters.Add("kv_", OracleDbType.Decimal, kv_, ParameterDirection.Input);
            cmd.Parameters.Add("s_", OracleDbType.Decimal, s_, ParameterDirection.Input);
            cmd.Parameters.Add("ref_", OracleDbType.Varchar2, ref_, ParameterDirection.Input);
            cmd.Parameters.Add("branch_", OracleDbType.Varchar2, branch_, ParameterDirection.Input);
            cmd.Parameters.Add("kurs_", OracleDbType.Varchar2, kurs_, ParameterDirection.Input);
            cmd.Parameters.Add("kuro_", OracleDbType.Varchar2, kuro_, ParameterDirection.Input);
			cmd.Parameters.Add("tt_", OracleDbType.Varchar2, tt_, ParameterDirection.Input);
            cmd.Parameters.Add("drday_", OracleDbType.Varchar2, drday_, ParameterDirection.Input);
            cmd.Parameters.Add("res_", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            
            Result = ((OracleString)cmd.Parameters["res_"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["res_"].Value).Value;
            
            if (Result != null)
            { return Result; }
        }
        finally 
        {
            con.Close();
            con.Dispose();
        }

        return null;

    }

     [WebMethod(EnableSession = true)]
     public void Del_eq(Decimal ref_, String branch_)
     {
         String UserName = Bars.Configuration.ConfigurationSettings.AppSettings["VAL.Username"];
         String Password = Bars.Configuration.ConfigurationSettings.AppSettings["VAL.Pass"];



         // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
         Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
         if (isAuthenticated) LoginUser(UserName);

         OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
         OracleCommand cmd = con.CreateCommand();
         try 
         {
             cmd.CommandType = CommandType.StoredProcedure;
             cmd.CommandText = "limeq.deleq";
             cmd.Parameters.Add("ref_", OracleDbType.Decimal, ref_, ParameterDirection.Input);
             cmd.Parameters.Add("branch_", OracleDbType.Varchar2, branch_, ParameterDirection.Input);
             cmd.ExecuteNonQuery();
         }
         finally 
         {
             con.Close();
             con.Dispose();
         }
     }

     [WebMethod(EnableSession = true)]
     public String CorectData(String BatchData)
     {
         String UserName = Bars.Configuration.ConfigurationSettings.AppSettings["VAL.Username"];
         String Password = Bars.Configuration.ConfigurationSettings.AppSettings["VAL.Pass"];

         String Result;

         // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
         Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
         if (isAuthenticated) LoginUser(UserName);

         OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
         OracleCommand cmd = con.CreateCommand();
         try
         {
             cmd.CommandType = CommandType.StoredProcedure;
             cmd.CommandText = "corect_data";
             cmd.Parameters.Add("xml_body", OracleDbType.Clob, BatchData, ParameterDirection.Input);
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
     public String Ping(String service_id, String abonent_id)
     {
         String UserName = Bars.Configuration.ConfigurationSettings.AppSettings["VAL.Username"];
         String Password = Bars.Configuration.ConfigurationSettings.AppSettings["VAL.Pass"];

         String Result;

         // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
         Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
         if (isAuthenticated) LoginUser(UserName);

         OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
         OracleCommand cmd = con.CreateCommand();
         try
         {
             cmd.CommandType = CommandType.StoredProcedure;
             cmd.CommandText = "limeq.ping";
             cmd.Parameters.Add("service_id", OracleDbType.Varchar2, service_id, ParameterDirection.Input);
             cmd.Parameters.Add("abonent_id", OracleDbType.Varchar2, abonent_id, ParameterDirection.Input);
             cmd.Parameters.Add("res_", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
             cmd.ExecuteNonQuery();

             Result = ((OracleString)cmd.Parameters["res_"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["res_"].Value).Value;

             if (Result != null)
             { return Result; }

         }
         finally
         {
             con.Close();
             con.Dispose();
         }

         return null;
     }

}
