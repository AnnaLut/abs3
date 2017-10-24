<%@ WebHandler Language="C#" Class="bnk24" %>

using System;
using System.Web;

using System.Web.SessionState;
using System.IO;
using System.Xml;
using System.Data;
using System.Data.Common;
using System.Diagnostics;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

using Bars.Application;
using barsroot.core;

public class bnk24 : IHttpHandler, IRequiresSessionState
{
    # region Константы
    public const String TypeID = "BNK24";
    # endregion

    # region Приватные методы
    private string GetHostName()
    {
        string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
            userHost = HttpContext.Current.Request.UserHostAddress;

        if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
            userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

        return userHost;
    }
    private void LoginUser(String userName, HttpContext context)
    {
        // информация о текущем пользователе
        UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "bars.bars_login.login_user";

            cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, context.Session.SessionID, ParameterDirection.Input);
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
        context.Session["UserLoggedIn"] = true;
    }
    # endregion

    # region Приватные методы
    public XmlDocument GetInfo(XmlDocument XmlMessage)
    {
        XmlDocument Result = new XmlDocument();

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "ibx_pack.get_info";
            cmd.Parameters.Add("p_type_id", OracleDbType.Varchar2, TypeID, ParameterDirection.Input);
            cmd.Parameters.Add("p_params", OracleDbType.XmlType, XmlMessage.InnerXml, ParameterDirection.Input);
            cmd.Parameters.Add("p_result", OracleDbType.XmlType, ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            OracleXmlType XmlResponce = (OracleXmlType)cmd.Parameters["p_result"].Value;
            Result = XmlResponce.GetXmlDocument();
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return Result;
    }
    public XmlDocument Pay(XmlDocument XmlMessage)
    {
        XmlDocument Result = new XmlDocument();

        /* Пример входящего XML
        <?xml version="1.0" encoding="UTF-8"?>
        <commandCall>
            <login>platezhka</login>
            <password>1234567</password>
            <command>pay</command>
            <transactionID>1234567890123</transactionID>
            <payTimestamp>20101008162022</ payTimestamp >
            <payID>55830367279006</ payID >
            <payElementID>0</payElementID>
            <account>1234567890</account>
            <amount>9800</amount>
            <terminalId>11352</terminalId>
        </commandCall>
        */

        String ExtRef = XmlMessage.GetElementsByTagName("payID")[0].InnerText;
        DateTime ExtDate = DateTime.ParseExact(XmlMessage.GetElementsByTagName("payTimestamp")[0].InnerText, "yyyyMMddHHmmss", System.Globalization.CultureInfo.InvariantCulture);
        String ExtSource = XmlMessage.GetElementsByTagName("terminalId")[0].InnerText;
        String DealID = XmlMessage.GetElementsByTagName("account")[0].InnerText.Split('|')[0];
        Decimal Sum = Convert.ToDecimal(XmlMessage.GetElementsByTagName("amount")[0].InnerText);
        Decimal ResCode;
        String ResText;
        Decimal? ResRef;

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "ibx_pack.pay";
            cmd.Parameters.Add("p_type_id", OracleDbType.Varchar2, TypeID, ParameterDirection.Input);
            cmd.Parameters.Add("p_ext_ref", OracleDbType.Varchar2, ExtRef, ParameterDirection.Input);
            cmd.Parameters.Add("p_ext_date", OracleDbType.Date, ExtDate, ParameterDirection.Input);
            cmd.Parameters.Add("p_ext_source", OracleDbType.Varchar2, ExtSource, ParameterDirection.Input);
            cmd.Parameters.Add("p_deal_id", OracleDbType.Varchar2, DealID, ParameterDirection.Input);
            cmd.Parameters.Add("p_sum", OracleDbType.Decimal, Sum, ParameterDirection.Input);
            cmd.Parameters.Add("p_res_code", OracleDbType.Decimal, ParameterDirection.Output);
            cmd.Parameters.Add("p_res_text", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
            cmd.Parameters.Add("p_res_ref", OracleDbType.Decimal, ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            ResCode = ((OracleDecimal)cmd.Parameters["p_res_code"].Value).Value;
            ResText = ((OracleString)cmd.Parameters["p_res_text"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["p_res_text"].Value).Value;
            ResRef = ((OracleDecimal)cmd.Parameters["p_res_ref"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["p_res_ref"].Value).Value;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        /* Пример исходящего XML
        <?xml version="1.0" encoding="UTF-8"?>
        <commandResponse>
                <extTransactionID>1234567</extTransactionID>
                <account>1234567890</account>
                <result>0</result>
                <comment>OK</comment>
        </commandResponse>
        */
        String ResponceText = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        ResponceText += "<commandResponse>";
        ResponceText += "<extTransactionID/>";
        ResponceText += String.Format("<account>{0}</account>", DealID);
        ResponceText += String.Format("<result>{0}</result>", ResCode);
        ResponceText += String.Format("<comment>{0}</comment>", ResText);
        ResponceText += "</commandResponse>";
        Result.LoadXml(ResponceText);

        return Result;
    }

    public XmlDocument Verification(XmlDocument XmlMessage)
    {
        XmlDocument Result = new XmlDocument();

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();

        try 
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "ibx_pack.verification";
            cmd.Parameters.Add("p_type_id", OracleDbType.Varchar2, TypeID, ParameterDirection.Input);
            cmd.Parameters.Add("p_params", OracleDbType.XmlType, XmlMessage.InnerXml, ParameterDirection.Input);
            cmd.Parameters.Add("p_result", OracleDbType.XmlType, ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            OracleXmlType XmlResponce = (OracleXmlType)cmd.Parameters["p_result"].Value;
            Result = XmlResponce.GetXmlDocument();
        }
        finally 
        {
            con.Close();
            con.Dispose();
        }

        return Result;
    }
    
    
    # endregion

    # region Реализация интерфейса
    public void ProcessRequest(HttpContext context)
    {
        /* Пример входящего XML
        <?xml version="1.0" encoding="UTF-8"?>
        <commandCall>
             <login>platezhka</login>
             <password>1234567</password>
             <command>check</command>
             <transactionID>1234567890123</transactionID>
             <payElementID>0</payElementID>
             <account>1234567890</account>
        </commandCall>
        */

        // переводим в XML
        XmlDocument XmlRequest = new XmlDocument();
        XmlRequest.Load(context.Request.InputStream);

        // логин/пароль
        String UserName = XmlRequest.GetElementsByTagName("login")[0].InnerText;
        String Password = XmlRequest.GetElementsByTagName("password")[0].InnerText;

        // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName, context);

        // действие
        String Сommand = XmlRequest.GetElementsByTagName("command")[0].InnerText.ToLower();

        XmlDocument XmlResponce = null;
        switch (Сommand)
        {
            case "check":
                XmlResponce = GetInfo(XmlRequest);
                break;
            case "pay":
                XmlResponce = Pay(XmlRequest);
                break;
            case "verification":
                XmlResponce = Verification(XmlRequest);
                break;
            default:
                XmlResponce = null;
                break;
        }

        // ответ
        context.Response.ContentType = "text/xml";
        context.Response.ContentEncoding = System.Text.Encoding.UTF8;
        XmlResponce.Save(context.Response.Output);
        context.Response.Flush();
        context.Response.End();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    # endregion
}