<%@ WebHandler Language="C#" Class="nonstop24" %>

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

public class nonstop24 : IHttpHandler, IRequiresSessionState
{
    # region Константы
    public const String TypeID = "NONSTOP24";
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

    public XmlDocument GetInfoDoc(XmlDocument XmlMessage)
    {
        XmlDocument Result = new XmlDocument();

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "ibx_pack.get_info_doc";
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
        /* NONSTOP24
         <pay-request>
            <act>4</act>
            <service_id>ХХХ</service_id>
            <pay_account>123434</pay_account>
            <pay_amount>10.20</pay_amount>
            <receipt_num>123568</receipt_num>
            <pay_id>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id>
            <trade_point>term1232</trade_point>
            <sign>F454FR43DE32JHSAGDSSFS</sign>
           </pay-request>
         */
        Decimal Act = Convert.ToDecimal(XmlMessage.GetElementsByTagName("act")[0].InnerText);
        String ExtRef = XmlMessage.GetElementsByTagName("pay_id")[0].InnerText;
        String Serv_Id = XmlMessage.GetElementsByTagName("service_id")[0].InnerText;
        DateTime ExtDate = DateTime.Now;
        String ExtSource = XmlMessage.GetElementsByTagName("trade_point")[0].InnerText;
        String DealID = XmlMessage.GetElementsByTagName("pay_account")[0].InnerText;
        String Sign = XmlMessage.GetElementsByTagName("sign")[0].InnerText;
        Decimal Sum = Convert.ToDecimal(XmlMessage.GetElementsByTagName("pay_amount")[0].InnerText.Replace(".",""));
        String Sum_Resp = XmlMessage.GetElementsByTagName("pay_amount")[0].InnerText;
        Decimal ResCode;
        String ResText;
        Decimal? ResRef;

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "ibx_pack.pay_nonstop24";
            cmd.Parameters.Add("p_type_id", OracleDbType.Varchar2, TypeID, ParameterDirection.Input);
            cmd.Parameters.Add("p_ext_ref", OracleDbType.Varchar2, ExtRef, ParameterDirection.Input);
            cmd.Parameters.Add("p_ext_date", OracleDbType.Date, ExtDate, ParameterDirection.Input);
            cmd.Parameters.Add("p_ext_source", OracleDbType.Varchar2, ExtSource, ParameterDirection.Input);
            cmd.Parameters.Add("p_deal_id", OracleDbType.Varchar2, DealID, ParameterDirection.Input);
            cmd.Parameters.Add("p_sum", OracleDbType.Decimal, Sum, ParameterDirection.Input);
            cmd.Parameters.Add("p_sign", OracleDbType.Varchar2, Sign, ParameterDirection.Input);
            cmd.Parameters.Add("p_act", OracleDbType.Decimal, Act, ParameterDirection.Input);
            cmd.Parameters.Add("p_serv_id", OracleDbType.Varchar2, Serv_Id, ParameterDirection.Input);
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

        /*
         Код результата запроса:
            <?xml version="1.0" encoding="UTF-8" ?>
                <pay-response>
                    <pay_id> XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</pay_id >
                    <service_id>XXX</ service_id>
                    <amount>10.20</amount>
                    <status_code>22</status_code>
                    <description>DDD</description>
                    <time_stamp>27.01.2006 10:27:21</time_stamp>
                    </pay-response>
                    Или
                    <?xml version="1.0" encoding="UTF-8" ?>
                    <pay-response>
                    <status_code>-100</status_code>
                    <time_stamp>27.01.2006 10:27:21</time_stamp>
                </pay-response>
         */
        String ResponceText = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        ResponceText += "<pay-response>";
        if (ResCode == 22)
        {
            ResponceText += String.Format("<pay_id>{0}</pay_id>", ExtRef);
            ResponceText += String.Format("<service_id>{0}</service_id>", Serv_Id);
            ResponceText += String.Format("<amount>{0}</amount>", Sum_Resp);
        }   
        ResponceText += String.Format("<status_code>{0}</status_code>", ResCode);
        if (ResCode == 22)
        {
            ResponceText += String.Format("<description>{0}</description>", ResText);
        }
        ResponceText += String.Format("<time_stamp>{0}</time_stamp>", DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss"));
        ResponceText += "</pay-response>";
        Result.LoadXml(ResponceText);

        return Result;
    }
    # endregion

    # region Реализация интерфейса
    public void ProcessRequest(HttpContext context)
    {
        
        // переводим в XML
        XmlDocument XmlRequest = new XmlDocument();
        XmlRequest.Load(context.Request.InputStream);

        // логин/пароль
        String UserName = "nonstop24";
        String Password = "qwerty";

        // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName, context);

        // действие
        String Act = XmlRequest.GetElementsByTagName("act")[0].InnerText.ToLower();

        /*
         Допустимые значения:
            1 – запрос информации про абонента, и
            проверка возможности оплаты (info);
            4 – запрос на оплату платежа (pay);
            7 – проверка состояния транзакции (status);
         */

        XmlDocument XmlResponce = null;
        switch (Act)
        {
            case "1":
                XmlResponce = GetInfo(XmlRequest);
                break;
            case "4":
                XmlResponce = Pay(XmlRequest);
                break;
            case "7":
                XmlResponce = GetInfoDoc(XmlRequest);
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