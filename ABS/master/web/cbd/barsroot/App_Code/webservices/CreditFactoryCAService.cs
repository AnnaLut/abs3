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
using System.Threading;
using System.Threading.Tasks;

using Bars.Oracle;
using Bars.Application;
using Bars.WebServices;
using Bars.Classes;
using Bars.Exception;
using Bars.Logger;
using barsroot.core;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

/// <summary>
/// Summary description for CreditFactoryCAService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class CreditFactoryCAService : Bars.BarsWebService
{

    public WsHeader WsHeaderValue;

    public class ReqRegistationParams
    {
        /// <summary>
        /// Бранч місця видачі кредиту
        /// </summary>
        public String dBranch { get; set; }
        /// <summary>
        /// Номер кредитного договору
        /// </summary>
        public decimal dNum { get; set; }
        /// <summary>
        /// Номер рахунку
        /// </summary>
        public String accNum { get; set; }
        /// <summary>
        /// Клас позичальника за цим договором
        /// </summary>
        public String dClass { get; set; }
        /// <summary>
        /// ВКР позичальника за цим договором
        /// </summary>
        public String dVkr { get; set; }
        /// <summary>
        /// Сума за договором
        /// </summary>
        public decimal dSum { get; set; }
        /// <summary>
        /// Код валюты
        /// </summary>
        public decimal kV { get; set; }
        /// <summary>
        /// Дата погодження кредиту
        /// </summary>
        public String dDate { get; set; }
    }

    public class ReqParams
    {
        /// <summary>
        /// Ідентифікаційний код клієнта
        /// </summary>
        public String Okpo { get; set; }
        /// <summary>
        /// Номер паспорту
        /// </summary>
        public String paspNum { get; set; }
        /// <summary>
        /// Дата народження
        /// </summary>
        public String birthDate { get; set; }
    }

    public class RequestSeting
    {
        /// <summary>
        /// МФО сервіса
        /// </summary>
        public String mfo { get; set; }
        /// <summary>
        /// url сервіса
        /// </summary>
        public String url { get; set; }
        /// <summary>
        /// логін користувача
        /// </summary>
        public String username { get; set; }
        /// <summary>
        /// пароль користувача
        /// </summary>
        public String password { get; set; }
    }

    public CreditFactoryCAService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
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

    public decimal setLog(String Diraction, String Data, decimal idIn, String Status)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        decimal idInLog = idIn;

        try
        {
            cmd.CommandText = "bars.utl_credit_factory.log";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_id", OracleDbType.Decimal, System.Data.ParameterDirection.ReturnValue);
            cmd.Parameters.Add("p_direction", OracleDbType.Varchar2, Diraction, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_data", OracleDbType.Clob, Data, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_is_valid", OracleDbType.Varchar2, Status, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_in_id", OracleDbType.Clob, idInLog, System.Data.ParameterDirection.Input);

            cmd.ExecuteNonQuery();

            return ((OracleDecimal)cmd.Parameters["p_id"].Value).Value;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

    }

    public static MemoryStream SerializeToStream(object o, Type t)
    {
        MemoryStream res = new MemoryStream();
        XmlSerializer xs = new XmlSerializer(t);
        xs.Serialize(res, o);
        return res;
    }

    [WebMethod(EnableSession = true, Description = "Запис інформації про виданий кредит")]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public XmlNode KF_CREDIT_Registation_RemoteRequest(String DBRANCH, decimal DNUM, String ACCNUM, String DCLASS, String DVKR, decimal DSUM, decimal KV, String DDATE)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);

        ReqRegistationParams reqParams = new ReqRegistationParams();
        reqParams.dBranch = DBRANCH;
        reqParams.dNum = DNUM;
        reqParams.accNum = ACCNUM;
        reqParams.dClass = DCLASS;
        reqParams.dVkr = DVKR;
        reqParams.dSum = DSUM;
        reqParams.kV = KV;
        reqParams.dDate = DDATE;

        XmlDocument doc = new XmlDocument();

        XmlElement root = doc.CreateElement("KF_CREDITS_RemoteResponse");
        doc.AppendChild(root);

        XmlElement response = doc.CreateElement("RESPONSE");
        root.AppendChild(response);

        MemoryStream stream = SerializeToStream(reqParams, typeof(ReqRegistationParams));
        StreamReader streader = new StreamReader(stream);
        streader.BaseStream.Position = 0;
        String OutXml = streader.ReadToEnd();
        var idLogIn = setLog("I", OutXml, 0, "SUCCESS");
        String p_url_service = "";
        String p_username = "";
        String p_password = "";

        CreditFactoryService factoryRU = new CreditFactoryService();


        String p_mfo = DBRANCH.Substring(1, 6);
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        try
        {
            cmd.CommandText = "bars.utl_credit_factory.get_service_params";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, p_mfo, System.Data.ParameterDirection.Input);
            cmd.Parameters.Add("p_url_service", OracleDbType.Varchar2, 4000, p_url_service, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add("p_username", OracleDbType.Varchar2, 400, p_username, System.Data.ParameterDirection.Output);
            cmd.Parameters.Add("p_password", OracleDbType.Varchar2, 400, p_password, System.Data.ParameterDirection.Output);

            cmd.ExecuteNonQuery();

            p_url_service = ((OracleString)cmd.Parameters["p_url_service"].Value).Value;
            p_username = ((OracleString)cmd.Parameters["p_username"].Value).Value;
            p_password = ((OracleString)cmd.Parameters["p_password"].Value).Value;

            WsHeader header = new WsHeader();

            header.UserName = p_username;
            header.Password = p_password;

            factoryRU.WsHeaderValue = header;

            factoryRU.Url = p_url_service;

            try
            {
                XmlNode resp = factoryRU.KF_CREDIT_Registation_RemoteRequest(reqParams.dBranch, reqParams.dNum, reqParams.accNum, reqParams.dClass, reqParams.dVkr, reqParams.dSum, reqParams.kV, reqParams.dDate);

                response.InnerXml = resp.InnerXml;

                var idOut = setLog("O", doc.InnerXml, idLogIn, "SUCCESS");
            }
            catch (Exception e)
            {
                var idLogOut = setLog("O", e.Message, idLogIn, "ERROR");
                response.InnerXml = "<ERRORS>Log id: " + Convert.ToString(idLogOut) + " " + e.Message + "</ERRORS>";
            }
            finally
            {
                factoryRU.Dispose();
            }

        }
        catch (OracleException e)
        {
            var idLogOut = setLog("O", e.Message, idLogIn, "ERROR");
            response.InnerXml = "<ERRORS>Log id: " + Convert.ToString(idLogOut) + " " + e.Message + "</ERRORS>";
        }
        finally
        {
            con.Close();
            con.Dispose();
        }

        return doc;
    }

    [WebMethod(EnableSession = true, Description = "Список всіх кредитів по клієнту")]
    [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
    public XmlNode KF_CREDITS_RemoteRequest(String OKPO, String PASPNUM, String BIRTHDATE)
    {
        String userName = WsHeaderValue.UserName;
        String password = WsHeaderValue.Password;

        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
        if (isAuthenticated) LoginUser(userName);


        ReqParams reqParams = new ReqParams();
        reqParams.Okpo = OKPO;
        reqParams.paspNum = PASPNUM;
        reqParams.birthDate = BIRTHDATE;

        MemoryStream stream = SerializeToStream(reqParams, typeof(ReqParams));
        StreamReader streader = new StreamReader(stream, UTF8Encoding.UTF8);
        streader.BaseStream.Position = 0;
        String OutXml =  streader.ReadToEnd();
        var idLogIn = setLog("I", OutXml, 0, "SUCCESS");

        XmlDocument doc = new XmlDocument();

        XmlElement root = doc.CreateElement("KF_CREDITS_RemoteResponse");

        doc.AppendChild(root);

        XmlElement response = doc.CreateElement("RESPONSE");
        root.AppendChild(response);
        try
        {
            IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
            OracleConnection con = icon.GetUserConnection(Context);
            OracleCommand cmd = con.CreateCommand();

            cmd.CommandType = System.Data.CommandType.Text;

            List<RequestSeting> requestSetings = new List<RequestSeting>();

            try
            {
                cmd.CommandText = "select mfo, url_service, username, password from bars.cf_request_setings where is_active = 1";
                OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    RequestSeting reqSet = new RequestSeting();
                    reqSet.mfo = reader["mfo"].ToString();
                    reqSet.url = reader["url_service"].ToString();
                    reqSet.username = reader["username"].ToString();
                    reqSet.password = reader["password"].ToString();
                    requestSetings.Add(reqSet);
                }
            }
            catch (Exception e)
            {
                response.InnerXml = "<ERRORS>Log id: " + Convert.ToString(idLogIn) + " " + e.Message + "</ERRORS>";
                var idLogOut = setLog("O", doc.InnerXml, idLogIn, "ERROR");
                return doc;
            }

            List<String> status = new List<String>();
            Parallel.ForEach(requestSetings, item =>
            {
                XmlElement mfoXml = doc.CreateElement("MFO");
                response.AppendChild(mfoXml);

                XmlElement mfoNum = doc.CreateElement("MFONUM");
                mfoXml.AppendChild(mfoNum);

                XmlElement error = doc.CreateElement("ERROR");
                mfoXml.AppendChild(error);

                CreditFactoryService factoryRU = new CreditFactoryService();

                WsHeader header = new WsHeader();

                try
                {
                    header.UserName = item.username;
                    header.Password = item.password;

                    factoryRU.WsHeaderValue = header;

                    factoryRU.Url = item.url;

                    XmlNode resp = factoryRU.KF_CREDITS_RemoteRequest(reqParams.Okpo, reqParams.paspNum, reqParams.birthDate);

                    mfoNum.InnerText = item.mfo;
                    var tmp = Encoding.UTF8.GetBytes(resp.InnerXml);
                    mfoXml.InnerXml += Encoding.UTF8.GetString(tmp);
                    status.Add("SUCCESS");
                }
                catch (Exception e)
                {
                    mfoNum.InnerText = item.mfo;
                    error.InnerText = "Remote Exception: " + e.Message;
                    status.Add("ERROR");
                }
                finally
                {
                    factoryRU.Dispose();
                }

            });
            //}
            var stsError = "";
            for (var i = 0; i < status.Count; i++)
            {
                if (status[i] == "ERROR")
                {
                    stsError = status[i];
                    break;
                }
            }

            var idOut = setLog("O", doc.InnerXml, idLogIn, stsError == "ERROR" ? stsError : "SUCCESS");
            con.Close();
            con.Dispose();
            return doc;
        }
        catch (Exception e)
        {
            response.InnerXml = "<ERRORS>Log id: " + Convert.ToString(idLogIn) + " " + e.Message + "</ERRORS>";
            var idLogOut = setLog("O", doc.InnerXml, idLogIn, "ERROR");
            return doc;
        }
    }
}
