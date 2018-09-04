using System;
using System.Web;
using System.Web.Services;
using barsroot.core;
using System.Net;
using System.Text;
using System.IO;
using Newtonsoft.Json.Linq;
using Bars.WebServices.EWAService.Models;
using Bars.WebServices;
using Bars;

[WebService(Namespace = "http://ws.unity-bars-utl.com.ua/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class EWAService : BarsWebService
{
    public WsHeader WsHeaderValue;

    #region Приватные методы
    private string SendAccStatusToEWA(Int32 id, String state)
    {
        //get email for logging to EWA
        string email = Bars.Configuration.ConfigurationSettings.AppSettings["EWA.EWAEMAIL"]; //"43@ewa.ua";
        //get hash password for logging to EWA
        string password = Bars.Configuration.ConfigurationSettings.AppSettings["EWA.EWAHASH"];// "3f2774623a1e0aec808df1ba3000fdc679c6693b";
        //get EWA URL
        var serviceUrl = Bars.Configuration.ConfigurationSettings.AppSettings["EWA.EWAURL"];//"https://clone.ewa.ua/ewa/api/v3/";
        //body for request
        byte[] arrStream = Encoding.UTF8.GetBytes("email=" + email + "&password=" + password);
        try
        {
            //logging to EWA
            var response = Send(arrStream, "POST", "application/x-www-form-urlencoded", serviceUrl + "user/login");
            //sending status to EWA
            var result = Send(null, "POST", "application/json", serviceUrl + "contractpayment/setState?id=" + id + "&state=" + state);
            return result;
        }
        catch (System.Exception ex)
        {
            throw ex;
        }
        finally
        {
            //logout from EWA
            var logout = Send(null, "PUT", "application/json", serviceUrl + "user/logout");
        }
    }

    private string Send(byte[] arrStream, string method, string applicationtype, string url)
    {
        var result = "";

        //build request to EWA
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
        request.Method = method;
        request.ContentType = applicationtype;
        request.ContentLength = (arrStream != null) ? arrStream.Length : 0;
        if (!string.IsNullOrEmpty(cookie))
        {
            request.Headers.Add("Cookie", "JSESSIONID=" + cookie);
        }

        if (arrStream != null)
        {
            using (Stream dataStream = request.GetRequestStream())
            {
                dataStream.Write(arrStream, 0, arrStream.Length);
            }
        }

        //get response from EWA
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();

        using (var rdr = new StreamReader(response.GetResponseStream()))
        {
            //get result from response
            result = rdr.ReadToEnd();
            if (string.IsNullOrEmpty(cookie))
            {
                //parse JSON string to get sessionId
                JObject pointres = JObject.Parse(result);
                cookie = pointres.SelectToken(@"sessionId").Value<string>();
            }
        }
        return result;
    }
    #endregion

    #region методы веб-сервиса
    public string cookie;

    [WebMethod(EnableSession = true)]
    public Result SendAccStatus(Int32 id, String state)
    {
        //ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;
        ServicePointManager.ServerCertificateValidationCallback += (sender, certificate, chain, sslPolicyErrors) => true;

        Result result = new Result();
        try
        {
            //call function for send status to EWA
            string res = SendAccStatusToEWA(id, state);
            result.status = "OK";
            result.message = "Status was sent.";
        }
        catch (WebException ex)
        {
            result.status = "ERROR";
            if (ex.Response != null)
            {
                using (var rdr = new StreamReader(ex.Response.GetResponseStream()))
                {
                    String error = rdr.ReadToEnd();
                    result.message = String.IsNullOrEmpty(error) ? ex.Message : Convert.ToString(JObject.Parse(error)["message"]);
                }
            }
            else
            {
                result.message = ex.Message;
            }
        }
        catch (System.Exception ex)
        {
            result.status = "ERROR";
            result.message = ex.Message + (ex.InnerException == null ? "" : ". " + ex.InnerException.Message);
        }
        return result;
    }
    #endregion
}
