using System;
using System.IO;
using System.Net;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Xml;
using System.Xml.Serialization;
using Bars.WebServices.Glory;

/// <summary>
/// Summary description for Glory
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[ScriptService]
public class Glory : WebService
{
    public Glory() { }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(UseHttpGet = false)]
    public XmlDocument CallProxy()
    {
        GloryRequestWorker worker = new GloryRequestWorker(Context.Request.Headers, Context.Request.InputStream);
        return worker.InitModels()
            .TestConnection()
            .MakeRequest()
            .Execute();
        //url = "http://192.168.0.25/axis2/services/GSRService";
    }
}


