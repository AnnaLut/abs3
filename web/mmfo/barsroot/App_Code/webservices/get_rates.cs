using System;
using System.Net;
using System.Web.Services;
using System.IO;
using System.Text;


/// <summary>
/// Summary description for get_rates
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class get_rates : WebService
{
     
    [WebMethod]
    public string Get()
    {
        WebRequest req = WebRequest.Create("http://bank.gov.ua/NBUStatService/v1/statdirectory/exchange");
        WebResponse resp = req.GetResponse();
        Stream stream = resp.GetResponseStream();
        StreamReader sr = new StreamReader(stream);
        string Out = sr.ReadToEnd();
        sr.Close();
        return  Out;
    }
}