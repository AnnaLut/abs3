using Bars.Application;
using BarsWeb.Core.Logger;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Security.Cryptography.X509Certificates;
using barsroot.core;

namespace Bars.WebServices.CreditInfoService
{
    /// <summary>
    /// Summary description for SendCreditInfoService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class SendCreditInfoService : BarsWebService
    {
        public WsHeader WsHeaderValue;

        private readonly IDbLogger Logger;
        private const string SERVICE_NAME = "SendCreditInfoService";
        //private enum HTTPMethods {GET, POST, PUT, DELETE};
        private List<HttpStatusCode> expectedStatusCodes = new List<HttpStatusCode>()
        {
            HttpStatusCode.OK,
            HttpStatusCode.Created,
            HttpStatusCode.NonAuthoritativeInformation,
            HttpStatusCode.NoContent,
            HttpStatusCode.BadRequest,
            HttpStatusCode.Unauthorized,
            HttpStatusCode.Forbidden,
            HttpStatusCode.NotFound,
            HttpStatusCode.PreconditionFailed
        };

        public SendCreditInfoService()
        {
            Logger = DbLoggerConstruct.NewDbLogger();
        }

        //this service is called by some vitrina,
        //after click of "Send data to NBU" 
        //accept big json object properly formed, as a string
        //and url and method of sending and send it to them.
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public ResponseResult SendData(string requestType, string nbuURL, string body)
        {
            Logger.Debug("Початок метода сервісу SendData.", SERVICE_NAME);
            Login();

            var responseToDB = SendDataToNBUService( requestType, nbuURL, body);
            Logger.Debug("Закінчення метода сервісу SendData.", SERVICE_NAME);
            return responseToDB;
        }

        private void Login()
        {
            bool isAuthenticated = false;
            string userName = WsHeaderValue != null ? WsHeaderValue.UserName : String.Empty;
            string password = WsHeaderValue != null ? WsHeaderValue.Password : String.Empty;

            isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);

            if (!isAuthenticated)
            {
                throw new System.Exception("Користувача не аутентифіковано!");
            }
            else
            {
                LoginUser(userName);
            }
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

        private ResponseResult SendDataToNBUService(string requestType, string nbuURL, string body)
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(nbuURL);
            request.Method = requestType;
            request.Credentials = CredentialCache.DefaultCredentials;
            request.ContentType = "application/json";

            string certName = Configuration.ConfigurationSettings.AppSettings["F601.CertificateName"];
            ManageSSlCertification(request, certName);

            if (requestType == "POST" || requestType == "PUT")
            {
                using (StreamWriter newStream = new StreamWriter(request.GetRequestStream()))
                {
                    newStream.Write(body);
                }
            }

            Logger.Debug("Метод SendDataToNBUService. Сформовано запит до НБУ сервісу", SERVICE_NAME);

            //Read response and form result
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            ResponseResult result = new ResponseResult();
            Logger.Debug("Метод SendDataToNBUService. Відповідь на запит від НБУ сервісу з кодом: " + response.StatusCode, SERVICE_NAME);

            if (expectedStatusCodes.Contains(response.StatusCode))
            {
                //fill answer
                result.ResponseCode = response.StatusCode;

                //add content only for requests which expect it - commented as post also returns response JSON string 
                //if (requestType == "PUT" || requestType == "DELETE")
                //{
                    using (var streamReader = new StreamReader(response.GetResponseStream()))
                    {
                        var responseText = streamReader.ReadToEnd();
                        //var result = new JavaScriptSerializer().Deserialize<NBUResponseJson>(responseText);
                        Logger.Debug("Метод SendDataToNBUService. Вміст відповіді (серіалізований): " + responseText, SERVICE_NAME);

                        result.ResponseJSONString = responseText;
                    }
                //}
            }
            else
            {
                throw new System.Exception("Отримано неочікувану відповідь від сервера. Код відповіді: "
                    + response.StatusCode + " Опис відповіді: "
                    + response.StatusDescription);
            }

            return result;
        }
        private void ManageSSlCertification(HttpWebRequest request, string certName)
        {
            Logger.Debug("Метод ManageSSlCertification c SendCreditInfoService. Початок методу по встановленню версії протоколу TLS та пошуку сертифікату з іменем: " + certName, SERVICE_NAME);
            //ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;  -- it is tls 1.0, and we should use 1.2 and higher
            ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072; //TLS 1.2
            ServicePointManager.ServerCertificateValidationCallback += new System.Net.Security.RemoteCertificateValidationCallback((s, ce, ch, ssl) => true);
            
            //Looking for proper sertificate in Local store of sertificates:
            X509Store store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
            store.Open(OpenFlags.ReadOnly);
            var certCollection = store.Certificates.Find(X509FindType.FindBySubjectName, certName, false);
            X509Certificate cert = null;
            try
            {
                cert = certCollection[0];
            }
            catch (System.Exception ex)
            {
                Logger.Error("Метод ManageSSlCertification з сервісу SendCreditInfoService. Не знайдено жодного сертифіката за іменем " + certName +" , текст помилки: " + ex.Message, SERVICE_NAME);
                throw new System.Exception("Сертифікат для запитів до сервісу не знайдено (пошук по імені [" + certName + "]). Текст помилки: " + ex.Message);
            }

            request.ClientCertificates.Add(cert);
        }
    }

    public class ResponseResult
    {
        public ResponseResult() { }

        public HttpStatusCode ResponseCode;

        public string ResponseJSONString;
    }

    public class NBUResponseJson
    {

    }
}
