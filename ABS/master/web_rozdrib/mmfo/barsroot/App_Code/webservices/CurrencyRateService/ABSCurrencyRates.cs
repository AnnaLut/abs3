using System;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Xml;
using System.Xml.Linq;
using Bars.WebServices.CurrencyRate;

/// <summary>
/// Summary description for ABSCurrencyRates
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class ABSCurrencyRates : WebService
{
    public ABSCurrencyRates() { }

    private string ServiceName
    {
        get { return GetType().Name; }
    }

    [WebMethod]
    public Response GetCurrencyRate(BaseRequestType requestBody, string url)
    {
        Response responseToDB = new Response();
        responseToDB.Result = false;
        if (requestBody == null || url == null)
        {
            responseToDB.Result = false;
            responseToDB.ErrorMessage = ServiceName + ": отримано порожні данні";
            return responseToDB;
        }

        //have doubts serialization here is neccesary: 
        XmlDocument xmlDocument = barsroot.core.WebUtility.SerializeObject(requestBody);
        String xml = CreateSoapXmlString(xmlDocument, requestBody);
        byte[] bytes = Encoding.UTF8.GetBytes(xml);

        var request = (HttpWebRequest)WebRequest.Create(url);
        request.Method = "POST";
        request.Credentials = CredentialCache.DefaultCredentials;
        request.ContentType = "text/xml;charset='utf-8'";
        request.ContentLength = bytes.Length;
        request.Headers.Add("SOAPAction", "http://oshb.currency.rates.ua/GetCurrencyRates");

        string certName = System.Configuration.ConfigurationManager.AppSettings["ABSCurrencyRates.CertificateName"];
        //comment here for developers local test:
        barsroot.core.WebUtility.ManageSSlCertification(request, certName);
        try
        {
            using (Stream requestStream = request.GetRequestStream())
            {
                requestStream.Write(bytes, 0, bytes.Length);

                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                {
                    using (Stream responseStream = response.GetResponseStream())
                    {
                        string responseXml = String.Empty;
                        using (StreamReader reader = new StreamReader(responseStream))
                        {
                            responseXml = reader.ReadToEnd();
                            responseXml = HttpUtility.HtmlDecode(responseXml);
                        }

                        //якщо запит дійшов, то треба розібрати текст відповіді: 
                        if (response.StatusCode == HttpStatusCode.OK)
                        {
                            ParseErrorResponse(responseXml, responseToDB);
                        }
                    }
                }
            }
        }
        catch (WebException webEx)
        {
            if (webEx.Response == null)
            {
                responseToDB.ErrorMessage = string.Format("{0} Помилка з'єдання з сервером: Статус - {1},  Повідомлення - {2}", ServiceName, webEx.Status, webEx.Message);
            }
            else
            {
                using (Stream stream = webEx.Response.GetResponseStream())
                {
                    using (var reader = new StreamReader(stream))
                    {
                        string responseXml = reader.ReadToEnd();
                        responseToDB.ErrorMessage = barsroot.core.WebUtility.ParseResponseWithGeneralWebServiceError(responseXml); ;
                    }
                }
            }
        }
        catch (Exception e)
        {
            responseToDB.ErrorMessage = "Помилка з'єднання з сервером: " + e.Message;
        }

        return responseToDB;
    }

    private String CreateSoapXmlString(XmlDocument document, BaseRequestType requestObj)
    {
        StringBuilder strBuilder = new StringBuilder(document.ChildNodes[0].OuterXml);
        strBuilder.Append("<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:oshb=\"http://oshb.currency.rates.ua\">");
        strBuilder.Append("<soapenv:Header/>");
        strBuilder.Append("<soapenv:Body>");
        strBuilder.Append("<oshb:GetCurrencyRatesRequest>");
        //strBuilder.Append("<GetCurrencyRatesRequest xmlns=\"http://oshb.currency.rates.ua\">");
        strBuilder.Append(GetRequestObjectInXML(requestObj));
        //strBuilder.Append("</oshb:GetCurrencyRatesRequest>");
        strBuilder.Append("</oshb:GetCurrencyRatesRequest>");
        strBuilder.Append("</soapenv:Body>");
        strBuilder.Append("</soapenv:Envelope>");
        return strBuilder.ToString();
    }

    private String GetRequestObjectInXML(BaseRequestType requestObj)
    {
        StringBuilder strBuilder = new StringBuilder();
        strBuilder.Append("<MsgID>"+requestObj.MsgID + "</MsgID>");
        strBuilder.Append("<RateType>" + requestObj.RateType + "</RateType>");
        //strBuilder.Append("<Timestamp>" + requestObj.TimeStamp.ToString("yyyy-MM-ddTHH-mm-ss") + "</Timestamp>");
        strBuilder.Append("<Timestamp>" + requestObj.TimeStamp + "</Timestamp>");
        return strBuilder.ToString();
    }

    private void ParseErrorResponse(String xml, Response response)
    {
        try
        {
            XDocument document = XDocument.Parse(xml);
            XNode node = document.LastNode;
            var value = document.Descendants("Result").FirstOrDefault().Descendants("Result").FirstOrDefault().Value;
            response.Result = Convert.ToBoolean(value);
            if (!response.Result)
            {
                response.ErrorId = Convert.ToInt32(document.Descendants("ErrorId").FirstOrDefault().Value);
                response.ErrorMessage = document.Descendants("ErrorMessage").FirstOrDefault().Value;
            }
        }
        catch (Exception e)
        {
            response.ErrorMessage = "Текст відповіді сервісу не відповідає заявленій структурі: "+ xml;
        }

    }
}
