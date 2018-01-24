using System;
using System.Web.Services;
using System.IO;
using System.Web;
using System.Web.Script.Services;
using System.Xml;
using Bars.WebServices.MSP;
using Bars.Application;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.Data;
using Oracle.DataAccess.Types;
using System.Net;
using BarsWeb.Core.Logger;
using System.Configuration;

/// <summary>
/// Summary description for MinSocPol
/// </summary>
[WebService(Namespace = "http://tempuri.org/", Description = "Сервіс для обміну данними з Мін.Соц.Політики")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class MinSocPol : Bars.BarsWebService
{
    IResultHolder rh = new McpResultHolder();
    private readonly IDbLogger dbLogger = DbLoggerConstruct.NewDbLogger();
    public MinSocPol() { }

    [WebMethod(Description = "Тест роботи сервісу")]
    public string IsAlive()
    {
        return "I'm alive!";
    }

    [WebMethod(EnableSession = true, Description = "Основний метод для запитиів")]
    [ScriptMethod(UseHttpGet = false)]
    public XmlDocument Action()
    {
        Login();
        dbLogger.Info(string.Format("MinSocPol service. Action started at {0}", DateTime.Now));
        XmlDocument respXml = new XmlDocument();

        HeaderParser hp = new HeaderParser();
        int at = hp.Parse(Context.Request.Headers);
        if (at == -1)
        {
            respXml.LoadXml(rh.HeaderError());
            return respXml;
        }

        string xml = string.Empty;
        Context.Request.InputStream.Position = 0;
        using (StreamReader stream = new StreamReader(Context.Request.InputStream))
        {
            string x = stream.ReadToEnd();
            xml = HttpUtility.UrlDecode(x);
        }

        try
        {
            xml = SaveData(at, xml);
        }
        catch (Exception e)
        {
            dbLogger.Error(string.Format("MinSocPol service. DateTime: {0}; Message: {1}; StackTrace: {2}", DateTime.Now, e.Message, e.StackTrace));

            Context.Response.Status = "500 Internal Server Error";
            Context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            Context.ApplicationInstance.CompleteRequest();

            return null;
        }        

        respXml.LoadXml(xml);

        return respXml;
    }

    [WebMethod(EnableSession = true, Description = "Метод не використовувати")]
    public new string GetUserParams(string params_str, string role)
    {
        throw new NotImplementedException("Використання методу заборонено!");
    }

    string SaveData(int at, string xml)
    {
        string val = string.Empty;

        using (OracleConnection connection = OraConnector.Handler.UserConnection)
        {
            using (var cmd = connection.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "msp.msp_utl.create_request";

                cmd.Parameters.Add(new OracleParameter("p_req_xml", OracleDbType.Clob, xml, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_act_type", OracleDbType.Int32, at, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_xml", OracleDbType.Clob, null, ParameterDirection.Output));

                cmd.ExecuteNonQuery();

                OracleClob p_xml = (OracleClob)cmd.Parameters[2].Value;
                val = p_xml.Value;
            }
        }
        return val;
    }

    void Login()
    {
        string UserName = ConfigurationManager.AppSettings["msp.ServiceUserName"];
        string Password = ConfigurationManager.AppSettings["msp.ServicePassword"];

        if (string.IsNullOrEmpty(UserName))
        {
            UserName = "absadm01";
        }
        if (string.IsNullOrEmpty(Password))
        {
            Password = "qwerty";
        }

        bool isAuthenticated = CustomAuthentication.AuthenticateUser(UserName, Password, true);

        if (isAuthenticated)
            LoginUserInt(UserName);
    }
}
