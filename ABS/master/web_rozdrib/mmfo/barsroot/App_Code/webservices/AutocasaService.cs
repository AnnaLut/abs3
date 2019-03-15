using Bars.WebServices.AutocasaService;
using BarsWeb.Core.Logger;
using Ninject;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Serialization.Formatters.Binary;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;

namespace Bars.WebServices.Autocasa
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    //[System.Web.Script.Services.ScriptService]
    public class AutocasaService : Bars.BarsWebService
    {
       //private readonly IDbLogger Logger;
        private string ServiceName { get { return GetType().Name; } }

        public AutocasaService()
        {
            //Logger = DbLoggerConstruct.NewDbLogger();
        }

        [WebMethod]
        public String SaveClientOutcashEnquiry(ClientOutcashEnquiry enquiry, String url)
        {
            if (enquiry == null || url == null)
                return string.Format("{0} Отримано пусті данні: {1}", ServiceName, HttpStatusCode.NotAcceptable);

            XmlDocument xmlDocument = SerializeObject(enquiry);
            String xml = CreateSoapXmlString(xmlDocument, enquiry);
            byte[] bytes = Encoding.UTF8.GetBytes(xml);

            ////String apiUrl = "http://10.1.171.2:9009/Avtokassa/OschadIntegrationService/soap";
            var request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "POST";
            request.Credentials = CredentialCache.DefaultCredentials;
            request.ContentType = "text/xml;charset='utf-8'";
            request.ContentLength = bytes.Length;
            //request.Headers.Add("SOAPAction", "\"http://tempuri.org/SaveClientOutcashEnquiry\"");
            request.Headers.Add("SOAPAction", "http://avtokassa.com/CashDepartment.v4/Integration/OschadIntegrationService/SaveClientOutcashEnquiry");

            string certName = System.Configuration.ConfigurationManager.AppSettings["Autocasa.CertificateName"];
            //comment only for developers local test:
            ManageSSlCertification(request, certName);
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
                                //responseXml = new StreamReader(responseStream).ReadToEnd();
                                responseXml = reader.ReadToEnd();
                                responseXml = HttpUtility.HtmlDecode(responseXml);
                            }

                            if (response.StatusCode == HttpStatusCode.OK)
                            {
                                return string.Format("{0} Отримано відповідь від сервісу: {1}", ServiceName, responseXml);
                            }
                            String message = DeserializeResponseWithError(responseXml);
                            String responseStr = string.Format("{0} Отримано помилку від серверу: StatusCode -{1}, Message - {2}", ServiceName, response.StatusCode, message);
                            //Logger.Error(responseStr, ServiceName);
                            return responseStr;
                        }
                    }
                }
            }
            catch (WebException webEx)
            {
                string responseXml = String.Empty;
                if (webEx.Response == null)
                {
                    String errorMessage = string.Format("{0} Помилка з'єдання з сервером: Статус - {1},  Повідомлення - {2}", ServiceName, webEx.Status, webEx.Message);
                    //Logger.Error(errorMessage, ServiceName);
                    return errorMessage;
                }

                using (Stream stream = webEx.Response.GetResponseStream())
                {
                    using (var reader = new StreamReader(stream))
                    {
                        responseXml = reader.ReadToEnd();
                    }
                }
                String message = DeserializeResponseWithError(responseXml);
                String responseStr = string.Format("{0} Сервер повернув помилку: Статус - {1},  Повідомлення - {2}", ServiceName, webEx.Status, message);
                //Logger.Error(responseStr, ServiceName);
                return responseStr;
            }
            catch (System.Exception e)
            {
                String responseStr = string.Format("{0} Помилка з'єднання з сервером: {1},  {2}", ServiceName, HttpStatusCode.InternalServerError, e.Message);
                //Logger.Error(responseStr, ServiceName);
                return responseStr;
            }
        }

        private String DeserializeResponseWithError(String xml)
        {
            String result = "No message";
            if (String.IsNullOrEmpty(xml))
                return result;
            try
            {
                XDocument document = XDocument.Parse(xml);
                XNode node = document.LastNode;
                XElement status = document.Descendants("faultcode").FirstOrDefault();
                XElement message = document.Descendants("faultstring").FirstOrDefault();
                if (status != null && message != null)
                {
                    return String.Format("Status: {0}, Message: {1}", status.Value, message.Value);
                }
                return result;
            }
            catch (System.Exception e)
            {
                return "No message";
            }

        }

        private String CreateSoapXmlString(XmlDocument document, ClientOutcashEnquiry enquiry)
        {
            StringBuilder strBuilder = new StringBuilder(document.ChildNodes[0].OuterXml);
            strBuilder.Append("<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://avtokassa.com/CashDepartment.v4/Integration/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">");
            strBuilder.Append("<soap:Body>");
            strBuilder.Append("<SaveClientOutcashEnquiry xmlns=\"http://avtokassa.com/CashDepartment.v4/Integration/\">");
            //strBuilder.Append("<SaveClientOutcashEnquiry xmlns =\"http://tempuri.org/\">");]
            strBuilder.Append("<enquiry>");
            //String str = document.ChildNodes[1].InnerXml.Replace("ClientOutcashEnquiry", "enquiry");
            strBuilder.Append(GetClientOutcashEnquiryXml(enquiry));
            strBuilder.Append("</enquiry>");
            strBuilder.Append("</SaveClientOutcashEnquiry>");
            strBuilder.Append("</soap:Body>");
            strBuilder.Append("</soap:Envelope>");
            return strBuilder.ToString();
        }

        private String GetClientOutcashEnquiryXml(ClientOutcashEnquiry enquiry)
        {
            StringBuilder str = new StringBuilder("<Data>");
            foreach (var encData in enquiry.Data)
            {
                str.Append("<EnquiryData>");
                str.Append("<Amount>" + encData.Amount + "</Amount>");
                str.Append("<CurrencyCode>" + encData.CurrencyCode + "</CurrencyCode>");
                str.Append("<NominalBreakdown>");
                foreach (var nomin in encData.NominalBreakdown)
                {
                    str.Append("<Nominal xmlns=\"http://www.elis.dn.ua/CashDepartment.v4/Integration/\">");
                    str.Append("<Count>" + nomin.Count + "</Count>");
                    str.Append("<CountOfDoubtful>" + nomin.CountOfDoubtful + "</CountOfDoubtful>");
                    String isChange = nomin.IsChange ? "true" : "false";
                    str.Append("<IsChange>" + isChange + "</IsChange>");
                    str.Append("<Value>" + nomin.Value + "</Value>");
                    str.Append("</Nominal>");
                }
                str.Append("</NominalBreakdown>");
                str.Append("</EnquiryData>");
            }

            str.Append("</Data>");
            str.Append("<ExpectedDate>" + enquiry.ExpectedDate.ToString("s") + "</ExpectedDate>");
            str.Append("<ExternalId>" + enquiry.ExternalId + "</ExternalId>");
            str.Append("<Notes>" + enquiry.Notes + "</Notes>");
            str.Append("<Priority>" + enquiry.Priority + "</Priority>");
            str.Append("<Source>" + enquiry.Source + "</Source>");
            str.Append("<ClientAccountMfo>" + enquiry.ClientAccountMfo + "</ClientAccountMfo>");
            str.Append("<ClientAccountNum>" + enquiry.ClientAccountNum + "</ClientAccountNum>");
            str.Append("<ClientRegisterCode>" + enquiry.ClientRegisterCode + "</ClientRegisterCode>");
            str.Append("<CollectionPointCode>" + enquiry.CollectionPointCode + "</CollectionPointCode>");
            str.Append("<Document>" + enquiry.Document + "</Document>");
            return str.ToString();
        }

        private XmlDocument SerializeObject(ClientOutcashEnquiry enquiry)
        {
            XmlSerializer xmlSerializer = new XmlSerializer(typeof(ClientOutcashEnquiry));
            XmlSerializerNamespaces names = new XmlSerializerNamespaces();
            names.Add("", "");
            XmlDocument xmlDoc = new XmlDocument();
            XmlDocument xmlResult = new XmlDocument();
            using (MemoryStream mStream = new MemoryStream())
            {
                using (XmlWriter writer = XmlWriter.Create(mStream))
                {
                    xmlSerializer.Serialize(writer, enquiry, names);
                }
                mStream.Flush();
                mStream.Seek(0, SeekOrigin.Begin);
                using (StreamReader sReader = new StreamReader(mStream))
                {
                    xmlDoc.Load(sReader);
                }
            }

            return xmlDoc;
        }

        private void ManageSSlCertification(HttpWebRequest request, string certName)
        {
            //Logger.Debug("Метод ManageSSlCertification c SendCreditInfoService. Початок методу по встановленню версії протоколу TLS та пошуку сертифікату з іменем: " + certName, SERVICE_NAME);
            //ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;  -- it is tls 1.0, and we should use 1.2 and higher
            ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072; //TLS 1.2
            ServicePointManager.ServerCertificateValidationCallback += new System.Net.Security.RemoteCertificateValidationCallback((s, ce, ch, ssl) => true);

            //Looking for proper certificate in Local store of sertificates:
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
                //Logger.Error("Не знайдено жодного сертифіката за іменем " + certName + " , текст помилки: " + ex.Message, ServiceName);
                throw new System.Exception("Сертифікат для запитів до сервісу не знайдено (пошук по імені [" + certName + "]). Текст помилки: " + ex.Message);
            }

            request.ClientCertificates.Add(cert);
        }

        //https://stackoverflow.com/questions/24224226/how-to-fix-soapenvenvelope-issue-in-xsd-schema-while-validating-with-soap-reque


        //private void CopyDocument(ref XmlDocument old, ref XmlDocument newDoc)
        //{
        //    XmlNode parentNode = newDoc.CreateElement("soap:Envelope");
        //    parentNode.Attributes.Append(CreateAttribute(ref newDoc, "xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance"));
        //    parentNode.Attributes.Append(CreateAttribute(ref newDoc, "xmlns:xsd", "http://www.w3.org/2001/XMLSchema"));
        //    parentNode.Attributes.Append(CreateAttribute(ref newDoc, "xmlns:soap", "http://schemas.xmlsoap.org/soap/envelope/"));
        //    XmlNode bodyNode = newDoc.CreateElement("soap:Body");
        //    XmlNode methodNode = newDoc.CreateElement("SaveClientOutcashEnquiry");
        //    methodNode.Attributes.Append(CreateAttribute(ref newDoc, "xmlns", "http://tempuri.org/"));
        //    XmlNode enquiry = newDoc.CreateElement("enquiry");

        //    //XmlNode child = InsertNode(ref newDoc, old.ChildNodes[1], methodNode);
        //    foreach (XmlNode node in old.ChildNodes[1])
        //    {
        //        if (node.NodeType == XmlNodeType.Text)
        //            continue;
        //        XmlNode resp = InsertNode(ref newDoc, node);
        //        enquiry.AppendChild(resp);
        //    }

        //    methodNode.AppendChild(enquiry);
        //    bodyNode.AppendChild(methodNode);
        //    parentNode.AppendChild(bodyNode);
        //    newDoc.AppendChild(parentNode);
        //}

        //private XmlNode InsertNode(ref XmlDocument resultDoc, XmlNode old)
        //{
        //    XmlNode tmp = resultDoc.CreateElement(old.Name);
        //    if (old.ChildNodes.Count == 1 && old.ChildNodes[0].NodeType == XmlNodeType.Text)
        //    {
        //        XmlText txt = resultDoc.CreateTextNode("#text");
        //        txt.Value = old.InnerText;
        //        tmp.AppendChild(txt);
        //    }
        //    if(old.Attributes != null && old.Attributes.Count > 0)
        //    {
        //        foreach(XmlAttribute attr in old.Attributes)
        //        {
        //            XmlAttribute newAttr = CreateAttribute(ref resultDoc, attr.Name, attr.Value);
        //            tmp.Attributes.Append(newAttr);
        //        }
        //    }

        //    if (old.HasChildNodes)
        //    {
        //        foreach(XmlNode child in old.ChildNodes)
        //        {
        //            if (child.NodeType == XmlNodeType.Text)
        //                continue;
        //            XmlNode res = InsertNode(ref resultDoc, child);
        //            tmp.AppendChild(res);
        //        }
        //    }
        //    return tmp;
        //}

        //private XmlAttribute CreateAttribute(ref XmlDocument doc, String name, string value)
        //{
        //    XmlAttribute attribute = doc.CreateAttribute(name);
        //    attribute.Value = value;
        //    return attribute;
        //}


        //        try
        //        {
        //            InitOraConnection(Context);
        //            SetRole(BalansRole);
        //        DateTime dDat = Convert.ToDateTime(SQL_SELECT_scalar("select bankdate from dual"), cinfo);
        //        result[0] = dDat.ToString("dd/MM/yyyy");
        //            SQL_Reader_Exec("select t.tobo, t.name from tobo t where t.tobo=tobopack.gettobo");
        //            if (SQL_Reader_Read())
        //            {
        //                ArrayList list = SQL_Reader_GetValues();
        //        result[1] = Convert.ToString(list[0]);
        //                result[2] = Convert.ToString(list[0]) + " " + Convert.ToString(list[1]);
        //            }
        //            SQL_Reader_Close();
        //}
        //        finally
        //        {
        //            DisposeOraConnection();
        //        }

    }
}