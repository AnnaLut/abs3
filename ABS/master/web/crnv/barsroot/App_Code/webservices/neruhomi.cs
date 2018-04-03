using System;
using System.Web;
using System.Globalization;
using System.Web.Services;
using System.Text;
using Bars;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Data;
using System.Data.Common;
using barsroot.core;
using Bars.Application;

public class NerInfo
{

}

/// <summary>
/// Summary description for send_sms
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class neruhomi : BarsWebService
{

    CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");

    public neruhomi()
    {
        cinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
        cinfo.DateTimeFormat.DateSeparator = "/";
    }

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
    public String Set(String p_FIO, String p_IDCODE, String p_DOCTYPE, String p_PASP_S, String p_PASP_N, String p_PASP_W, String p_PASP_D, String p_BIRTHDAT,
        String p_BIRTHPL, String p_SEX, String p_POSTIDX, String p_REGION, String p_DISTRICT, String p_CITY, String p_ADDRESS, String p_PHONE_H, String p_PHONE_J,
        String p_REGDATE, String p_NLS, String p_DATO, String p_OST, String p_SUM, String p_DATN, String p_BRANCH, String p_BSD, String p_OB22DE, String p_BSN,
        String p_OB22IE, String p_BSD7, String p_OB22D7, String p_source, String p_kv, String p_nd, String p_dptid, String p_LANDCOD, String p_FL, String p_DZAGR, String p_ref)
    {
        String UserName = Bars.Configuration.ConfigurationSettings.AppSettings["Ner.Username"];
        String Password = Bars.Configuration.ConfigurationSettings.AppSettings["Ner.Pass"];

        String Result;

        // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName);


        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {


            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "migraas.dpt2immobile";
            cmd.Parameters.Add("p_FIO", OracleDbType.Varchar2, p_FIO, ParameterDirection.Input);
            cmd.Parameters.Add("p_IDCODE", OracleDbType.Varchar2, p_IDCODE, ParameterDirection.Input);
            cmd.Parameters.Add("p_DOCTYPE", OracleDbType.Decimal, String.IsNullOrEmpty(p_DOCTYPE) ? (Decimal?)null : Convert.ToDecimal(p_DOCTYPE), ParameterDirection.Input);
            cmd.Parameters.Add("p_PASP_S", OracleDbType.Varchar2, p_PASP_S, ParameterDirection.Input);
            cmd.Parameters.Add("p_PASP_N", OracleDbType.Varchar2, p_PASP_N, ParameterDirection.Input);
            cmd.Parameters.Add("p_PASP_W", OracleDbType.Varchar2, p_PASP_W, ParameterDirection.Input);
            cmd.Parameters.Add("p_PASP_D", OracleDbType.Date, String.IsNullOrEmpty(p_PASP_D) ? (DateTime?)null : Convert.ToDateTime(p_PASP_D, cinfo), ParameterDirection.Input);
            cmd.Parameters.Add("p_BIRTHDAT", OracleDbType.Date, String.IsNullOrEmpty(p_BIRTHDAT) ? (DateTime?)null : Convert.ToDateTime(p_BIRTHDAT, cinfo), ParameterDirection.Input);
            cmd.Parameters.Add("p_BIRTHPL", OracleDbType.Varchar2, p_BIRTHPL, ParameterDirection.Input);
            cmd.Parameters.Add("p_SEX", OracleDbType.Decimal, String.IsNullOrEmpty(p_SEX) ? (Decimal?)null : Convert.ToDecimal(p_SEX), ParameterDirection.Input);
            cmd.Parameters.Add("p_POSTIDX", OracleDbType.Varchar2, p_POSTIDX, ParameterDirection.Input);
            cmd.Parameters.Add("p_REGION", OracleDbType.Varchar2, p_REGION, ParameterDirection.Input);
            cmd.Parameters.Add("p_DISTRICT", OracleDbType.Varchar2, p_DISTRICT, ParameterDirection.Input);
            cmd.Parameters.Add("p_CITY", OracleDbType.Varchar2, p_CITY, ParameterDirection.Input);
            cmd.Parameters.Add("p_ADDRESS", OracleDbType.Varchar2, p_ADDRESS, ParameterDirection.Input);
            cmd.Parameters.Add("p_PHONE_H", OracleDbType.Varchar2, p_PHONE_H, ParameterDirection.Input);
            cmd.Parameters.Add("p_PHONE_J", OracleDbType.Varchar2, p_PHONE_J, ParameterDirection.Input);
            cmd.Parameters.Add("p_REGDATE", OracleDbType.Date, String.IsNullOrEmpty(p_REGDATE) ? (DateTime?)null : Convert.ToDateTime(p_REGDATE, cinfo), ParameterDirection.Input);
            cmd.Parameters.Add("p_NLS", OracleDbType.Varchar2, p_NLS, ParameterDirection.Input);
            cmd.Parameters.Add("p_DATO", OracleDbType.Date, String.IsNullOrEmpty(p_DATO) ? (DateTime?)null : Convert.ToDateTime(p_DATO, cinfo), ParameterDirection.Input);
            cmd.Parameters.Add("p_OST", OracleDbType.Decimal, String.IsNullOrEmpty(p_OST) ? (Decimal?)null : Convert.ToDecimal(p_OST), ParameterDirection.Input);
            cmd.Parameters.Add("p_SUM", OracleDbType.Decimal, String.IsNullOrEmpty(p_SUM) ? (Decimal?)null : Convert.ToDecimal(p_SUM), ParameterDirection.Input);
            cmd.Parameters.Add("p_DATN", OracleDbType.Date, String.IsNullOrEmpty(p_DATN) ? (DateTime?)null : Convert.ToDateTime(p_DATN, cinfo), ParameterDirection.Input);
            cmd.Parameters.Add("p_BRANCH", OracleDbType.Varchar2, p_BRANCH, ParameterDirection.Input);
            cmd.Parameters.Add("p_BSD", OracleDbType.Varchar2, p_BSD, ParameterDirection.Input);
            cmd.Parameters.Add("p_OB22DE", OracleDbType.Varchar2, p_OB22DE, ParameterDirection.Input);
            cmd.Parameters.Add("p_BSN", OracleDbType.Varchar2, p_BSN, ParameterDirection.Input);
            cmd.Parameters.Add("p_OB22IE", OracleDbType.Varchar2, p_OB22IE, ParameterDirection.Input);
            cmd.Parameters.Add("p_BSD7", OracleDbType.Varchar2, p_BSD7, ParameterDirection.Input);
            cmd.Parameters.Add("p_OB22D7", OracleDbType.Varchar2, p_OB22D7, ParameterDirection.Input);
            cmd.Parameters.Add("p_source", OracleDbType.Varchar2, p_source, ParameterDirection.Input);
            cmd.Parameters.Add("p_kv", OracleDbType.Decimal, String.IsNullOrEmpty(p_kv) ? (Decimal?)null : Convert.ToDecimal(p_kv), ParameterDirection.Input);
            cmd.Parameters.Add("p_nd", OracleDbType.Varchar2, p_nd, ParameterDirection.Input);
            cmd.Parameters.Add("p_dptid", OracleDbType.Decimal, String.IsNullOrEmpty(p_dptid) ? (Decimal?)null : Convert.ToDecimal(p_dptid), ParameterDirection.Input);
            cmd.Parameters.Add("res_", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
            cmd.Parameters.Add("p_LANDCOD", OracleDbType.Decimal, String.IsNullOrEmpty(p_LANDCOD) ? (Decimal?)null : Convert.ToDecimal(p_LANDCOD), ParameterDirection.Input);
            cmd.Parameters.Add("p_FL", OracleDbType.Decimal, String.IsNullOrEmpty(p_FL) ? (Decimal?)null : Convert.ToDecimal(p_FL), ParameterDirection.Input);
            cmd.Parameters.Add("p_DZAGR", OracleDbType.Date, String.IsNullOrEmpty(p_DZAGR) ? (DateTime?)null : Convert.ToDateTime(p_DZAGR, cinfo), ParameterDirection.Input);
            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, String.IsNullOrEmpty(p_ref) ? (Decimal?)null : Convert.ToDecimal(p_ref), ParameterDirection.Input);

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
    public String BatchSet(String BatchData)
    {
        String UserName = Bars.Configuration.ConfigurationSettings.AppSettings["Ner.Username"];
        String Password = Bars.Configuration.ConfigurationSettings.AppSettings["Ner.Pass"];

        String Result;

        // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName);


        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandTimeout = 90;
        try
        {

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "p_batch_set";
            cmd.Parameters.Add("xml_body", OracleDbType.Clob, BatchData, ParameterDirection.Input);
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
