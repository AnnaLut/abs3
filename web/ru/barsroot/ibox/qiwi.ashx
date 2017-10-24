<%@ WebHandler Language="C#" Class="qiwi" %>

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
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

public class qiwi : IHttpHandler, IRequiresSessionState
{
    # region Константы
    public const String TypeID = "QIWI";
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
    
    //Получение информации о договоре
    
    public XmlDocument GetInfo(HttpContext ctx)
    {
        XmlDocument Result = new XmlDocument();

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();

        String transaction_id = ctx.Request["txn_id"];
        String agr_num = ctx.Request["account"];
        //Decimal s = Convert.ToDecimal(ctx.Request["sum"]);
        
        try
        {
            
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "ibx_pack.get_info_qiwi";
            cmd.Parameters.Add("txn_id", OracleDbType.Varchar2, transaction_id, ParameterDirection.Input);
            cmd.Parameters.Add("account", OracleDbType.Varchar2, agr_num, ParameterDirection.Input);
          //  cmd.Parameters.Add("sum", OracleDbType.Decimal, s, ParameterDirection.Input);
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

    //Оплата
    
    public XmlDocument Pay(HttpContext ctx)
    {
        XmlDocument Result = new XmlDocument();

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();

        Decimal ResCode;
        String ResText;
        Decimal? ResRef;
        String ResDate;
        
        String transaction_id = ctx.Request["txn_id"];
        String agr_num = ctx.Request["account"];
        String ext_date =ctx.Request["txn_date"];
        String ext_source = ctx.Request["trm_id"];
        String s = ctx.Request["sum"];

        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "ibx_pack.pay_qiwi";
            cmd.Parameters.Add("type_id", OracleDbType.Varchar2, "QIWI", ParameterDirection.Input);
            cmd.Parameters.Add("txn_id", OracleDbType.Varchar2, transaction_id, ParameterDirection.Input);
            cmd.Parameters.Add("txn_date", OracleDbType.Varchar2, ext_date, ParameterDirection.Input);
            cmd.Parameters.Add("trm_id", OracleDbType.Varchar2, ext_source, ParameterDirection.Input);
            cmd.Parameters.Add("account", OracleDbType.Varchar2, agr_num, ParameterDirection.Input);
            cmd.Parameters.Add("sum", OracleDbType.Varchar2, s, ParameterDirection.Input);
            cmd.Parameters.Add("p_res_code", OracleDbType.Decimal, ParameterDirection.Output);
            cmd.Parameters.Add("p_res_text", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
            cmd.Parameters.Add("p_res_date", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
            cmd.Parameters.Add("p_res_ref", OracleDbType.Decimal, ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            ResCode = ((OracleDecimal)cmd.Parameters["p_res_code"].Value).Value;
            ResText  = ((OracleString)cmd.Parameters["p_res_text"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["p_res_text"].Value).Value; cmd.Parameters.Add("p_res_text", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
            ResDate  = ((OracleString)cmd.Parameters["p_res_date"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["p_res_date"].Value).Value; cmd.Parameters.Add("p_res_date", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
            ResRef  = ((OracleDecimal)cmd.Parameters["p_res_ref"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["p_res_ref"].Value).Value;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        String ResponceText = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        ResponceText += "<response>";
            ResponceText += String.Format("<osmp_txn_id>{0}</osmp_txn_id>", transaction_id);
            ResponceText += String.Format("<prv_txn>{0}</prv_txn>", ResRef);
            ResponceText += String.Format("<prv_txn_date>{0}</prv_txn_date>", ResDate);
            ResponceText += String.Format("<sum>{0}</sum>", s);
            ResponceText += String.Format("<result>{0}</result>", ResCode);
            ResponceText += String.Format("<comment>{0}</comment>", ResText);
        ResponceText += "</response>";
        Result.LoadXml(ResponceText);

        return Result;
    }

    //Сторнирование проводок
    
    public XmlDocument Bak(HttpContext ctx)
    {
        XmlDocument Result = new XmlDocument();

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();

        Decimal ResCode;
        String ResText;
        Decimal? ResRef;
        
        String transaction_id = ctx.Request["txn_id"];
        String transaction_id_bak = ctx.Request["cancel_txn_id"];
        String agr_num = ctx.Request["account"];
        String ext_date = ctx.Request["txn_date"];
        String ext_date_bak = ctx.Request["cancel_txn_date"];
        String s = ctx.Request["sum"];

        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "ibx_pack.bak_qiwi";
            cmd.Parameters.Add("type_id", OracleDbType.Varchar2, "QIWI", ParameterDirection.Input);
            cmd.Parameters.Add("txn_id", OracleDbType.Varchar2, transaction_id, ParameterDirection.Input);
            cmd.Parameters.Add("txn_date", OracleDbType.Varchar2, ext_date, ParameterDirection.Input);
            cmd.Parameters.Add("cancel_txn_id", OracleDbType.Varchar2, transaction_id_bak, ParameterDirection.Input);
            cmd.Parameters.Add("cancel_txn_date", OracleDbType.Varchar2, ext_date_bak, ParameterDirection.Input);
            cmd.Parameters.Add("account", OracleDbType.Varchar2, agr_num, ParameterDirection.Input);
            cmd.Parameters.Add("sum", OracleDbType.Varchar2, s, ParameterDirection.Input);
            cmd.Parameters.Add("p_res_code", OracleDbType.Decimal, ParameterDirection.Output);
            cmd.Parameters.Add("p_res_text", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
            cmd.Parameters.Add("p_res_ref", OracleDbType.Decimal, ParameterDirection.Output);
            cmd.ExecuteNonQuery();

            ResCode = ((OracleDecimal)cmd.Parameters["p_res_code"].Value).Value;
            ResText = ((OracleString)cmd.Parameters["p_res_text"].Value).IsNull ? String.Empty : ((OracleString)cmd.Parameters["p_res_text"].Value).Value; cmd.Parameters.Add("p_res_text", OracleDbType.Varchar2, 1000, null, ParameterDirection.Output);
            ResRef = ((OracleDecimal)cmd.Parameters["p_res_ref"].Value).IsNull ? (Decimal?)null : ((OracleDecimal)cmd.Parameters["p_res_ref"].Value).Value;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        String ResponceText = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
        ResponceText += "<response>";
        ResponceText += String.Format("<osmp_txn_id>{0}</osmp_txn_id>", transaction_id);
        ResponceText += String.Format("<cancel_txn_id>{0}</cancel_txn_id>", transaction_id_bak);
        ResponceText += String.Format("<prv_txn>{0}</prv_txn>", ResRef);
        ResponceText += String.Format("<sum>{0}</sum>", s);
        ResponceText += String.Format("<result>{0}</result>", ResCode);
        ResponceText += String.Format("<comment>{0}</comment>", ResText);
        ResponceText += "</response>";
        Result.LoadXml(ResponceText);

        return Result;
    }

    # region Реализация интерфейса
    public void ProcessRequest(HttpContext context)
    {

        // логин/пароль
        String UserName = "absadm";
        String Password = "qwerty";

        // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);
        if (isAuthenticated) LoginUser(UserName, context);

        // действие
        String Command = context.Request["command"];

        /*
         Допустимые значения:
            check – запрос информации про абонента, и
            проверка возможности оплаты (info);
            pay – запрос на оплату платежа (pay);
            cancel – отмена платежа;
         */

        XmlDocument XmlResponce = null;
        switch (Command)
        {
            case "pay":
                XmlResponce = Pay(context);
                break;
            case "cancel":
                XmlResponce = Bak(context);
                break;    
            case "check":
                XmlResponce = GetInfo(context);
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