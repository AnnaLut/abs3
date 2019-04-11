using System.Net;
using BarsWeb.Areas.WebApi.OnlineWay4.Models;
using System.IO;
using System.Xml;

namespace BarsWeb.Areas.WebApi.OnlineWay4.Infrastructure.DI.Implementation
{
    public static class SOAPHelper
    {
        public static string SendSOAPRequest(RequestModel req)
        {
            string xml = string.Format(@"<soapenv:Envelope xmlns:soapenv=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:{1}=""{0}"">
                                                <soapenv:Header>
                                                    {2}
                                                </soapenv:Header>
                                            <soapenv:Body>
                                                <wsint:{4} xmlns:{1}=""{0}"">
                                                    {3}
                                                </wsint:{4}>
                                             </soapenv:Body>
                                         </soapenv:Envelope>",
                                        req.NameSpace, req.Prefix, req.Header, req.Data, req.Method);

            using (HttpWebResponse a = SendRequest(xml, req.Url, req.Timeout))
            {
                string resTagName = req.Method + "Result";
                string soapResult = "";
                using (StreamReader rd = new StreamReader(a.GetResponseStream()))
                {
                    soapResult = rd.ReadToEnd();
                    if (a.StatusCode != HttpStatusCode.OK)
                        return (new W4Response() { RetCode = -1, RetMsg = soapResult }).XmlSerialize("response");
                }

                XmlDocument doc = new XmlDocument();
                doc.LoadXml(soapResult);

                XmlNodeList resultNodeList = doc.GetElementsByTagName(resTagName);
                XmlNode resultNode = resultNodeList.Item(0);
                string tmpStr = resultNode.InnerXml;

                return "<response>" + tmpStr + "</response>";
            }
        }

        public static HttpWebResponse SendRequest(string xml, string address, string timeout)
        {
            int t = 30000;
            int.TryParse(timeout, out t);

            HttpWebRequest request = CreateWebRequest(address, t);
            XmlDocument soapEnvelopeXml = new XmlDocument();
            soapEnvelopeXml.LoadXml(xml);

            using (Stream stream = request.GetRequestStream())
            {
                soapEnvelopeXml.Save(stream);
            }
            return (HttpWebResponse)request.GetResponse();
        }

        public static HttpWebRequest CreateWebRequest(string url, int timeout)
        {
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(url);
            webRequest.Timeout = timeout;
            webRequest.ContentType = "text/xml;charset=\"utf-8\"";
            webRequest.Accept = "text/xml";
            webRequest.Method = "POST";
            return webRequest;
        }
    }
}
