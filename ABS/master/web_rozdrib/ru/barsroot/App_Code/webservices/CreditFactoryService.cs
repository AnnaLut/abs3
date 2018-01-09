using System;
using System.Collections.Generic;
using System.Web;
using System.Xml;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Text.RegularExpressions;
using System.Globalization;
using System.IO;
using System.Xml.Serialization;
using System.Text;

using Bars.Oracle;
using Bars.Application;
using Bars.WebServices;
using Bars.Classes;
using Bars.Exception;
using barsroot.core;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

/// <summary>
/// Summary description for CreditFactoryService
/// </summary>
[WebService(Namespace = "http://tempuri.org/",Description="Взаємодія КФ/СМ з АБС")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class CreditFactoryService : Bars.BarsWebService
{


    public WsHeader WsHeaderValue;
    public CreditFactoryService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    private string GetUserParams(string params_str, string role)
    {
        return String.Empty;
    }
    /// <summary>
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

        try
        {
            InitOraConnection();
            // установка первичных параметров
            SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
            SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);
            SetParameters("p_hostname", DB_TYPE.Varchar2, GetHostName(), DIRECTION.Input);
            SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
            SQL_PROCEDURE("bars.bars_login.login_user");
        }
        finally
        {
            DisposeOraConnection();
        }

        // Если выполнили установку параметров
        Session["UserLoggedIn"] = true;
    }

    [WebMethod(EnableSession = true, Description="Запис інформації про виданий кредит")]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public XmlNode KF_CREDIT_Registation_RemoteRequest(String DBRANCH, decimal DNUM, String ACCNUM, String DCLASS, String DVKR, decimal DSUM, decimal KV, String DDATE)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);
        
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        
        XmlDocument doc = new XmlDocument();

        XmlElement root = doc.CreateElement("KF_CREDIT_Registation_RemoteResponse");
        doc.AppendChild(root);

        XmlElement response = doc.CreateElement("RESPONSE");
        root.AppendChild(response);

        try
        {
            cmd.CommandText = "bars.bars_credit_factory.set_bpk_credit";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_nd", OracleDbType.Decimal, DNUM, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, DBRANCH, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_kv", OracleDbType.Decimal, KV, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, ACCNUM, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_dclass", OracleDbType.Varchar2, DCLASS, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_dvkr", OracleDbType.Varchar2, DVKR, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_dsum", OracleDbType.Decimal, DSUM, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_ddate", OracleDbType.Date, Convert.ToDateTime(DDATE), System.Data.ParameterDirection.Input);

            cmd.ExecuteNonQuery();

            response.InnerText = "Successful";
        }
        catch (OracleException e)
        {
            response.InnerText = "Error: " + e.Message; 
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return doc;
    }

    [WebMethod(EnableSession = true,Description="Список всіх кредитів по клієнту")]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public XmlNode KF_CREDITS_RemoteRequest(String OKPO, String PASPNUM, String BIRTHDATE)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);
        
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        
        XmlDocument doc = new XmlDocument();

        XmlElement root = doc.CreateElement("KF_CREDITS_RemoteResponse");
        doc.AppendChild(root);

        try
        {
            cmd.CommandText = "bars.bars_credit_factory.get_crd_response";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_responce", OracleDbType.Clob, System.Data.ParameterDirection.ReturnValue);
            cmd.Parameters.Add("p_okpo", OracleDbType.Varchar2, OKPO, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_paspnum", OracleDbType.Varchar2, PASPNUM, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_bday", OracleDbType.Varchar2, /*Convert.ToDateTime(*/BIRTHDATE/*)*/, System.Data.ParameterDirection.Input);

            cmd.ExecuteNonQuery();

            OracleClob res = (OracleClob)cmd.Parameters["p_responce"].Value;
            string creditList = res.IsNull ? null : res.Value;

            res.Close();
            res.Dispose();

            root.InnerXml = creditList;
        }
        catch(OracleException e)
        {
            root.InnerText = "Error: " + e.Message;
        }
        finally 
        {
            con.Close();
            con.Dispose();
        }

        return doc;
    }

    [WebMethod(EnableSession = true, Description = "Список всіх кредитів по клієнту")]
    public String KF_Ping_RemoteRequest(String userName, String Password)
    {
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, Password, true);
        if (isAuthenticated) LoginUser(userName);

        return "Ok";
    }

}
