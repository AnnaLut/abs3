using System;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.NetworkInformation;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Xml;
using System.Xml.Serialization;

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
    private XmlDocument result;
    CancellationTokenSource canToken;
    HttpWebRequest webRequest;
    String url;
    String action;
    String SessionID;
    String ip;

    [WebMethod(EnableSession = true)]
    [ScriptMethod(UseHttpGet = false)]
    public XmlDocument CallProxy()
    {
        string xml = string.Empty;
        XmlDocument soapEnvelopeXml = new XmlDocument();
        url = Context.Request.Headers["GloryUrl"];
        ///url = "http://192.168.0.25/axis2/services/GSRService";
        action = Context.Request.Headers["GloryAction"];
        SessionID = Context.Request.Headers["SessionID"];
        ip = Context.Request.Headers["GloryIP"];
        //ip = "192.168.0.25";
        String IsLongRequest = Context.Request.Headers["IsLongRequest"];
        if (!String.IsNullOrEmpty(ip))
        {
            try
            {
                ping(ip);
            }
            catch (Exception e)
            {
                OnException(e);
                return result;
            }
        }
        try
        {
            Context.Request.InputStream.Position = 0;
            using (StreamReader stream = new StreamReader(Context.Request.InputStream))
                xml = HttpUtility.UrlDecode(stream.ReadToEnd());
            
            if (!string.IsNullOrEmpty(xml))
            {
                soapEnvelopeXml.LoadXml(xml);
                webRequest = CreateWebRequest(soapEnvelopeXml);
                
                if (!String.IsNullOrEmpty(IsLongRequest) && IsLongRequest == "1")
                {
                    canToken = new CancellationTokenSource();
                    CancellationToken token = canToken.Token;
                    webRequest.ConnectionGroupName = action;
                    Task.Factory.StartNew(() => GetStatusChange())
                        .ContinueWith(tsk => OnThreadComplete(tsk), 
                        TaskContinuationOptions.None);
                }

                webRequest.BeginGetResponse(new AsyncCallback(ResponseCallback), webRequest);
            }
        }
        catch (Exception ex)
        {
            OnException(ex);
        }
        return result;
    }

    HttpWebRequest CreateWebRequest(XmlDocument soapEnvelopeXml)
    {
        HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(url);
        webRequest.Headers.Add("SOAPAction", action);
        webRequest.ContentType = "text/xml;charset=\"utf-8\"";
        webRequest.Accept = "text/xml";
        webRequest.Method = "POST";
        webRequest.Timeout = 600000;
        webRequest.ReadWriteTimeout = 600000;

        using (Stream stream = webRequest.GetRequestStream())
            soapEnvelopeXml.Save(stream);
        return webRequest;
    }

    void GetStatusChange()
    {
        GSRService gsr = new GSRService();
        gsr.Url = url;
        StatusChangeRequestType scrType = new StatusChangeRequestType
        {
            Id = "1",
            SeqNo = "123",
            SessionID = SessionID
        };

        while(true)
        {
            Thread.Sleep(5000);
            try
            {
                StatusChangeResponseType screspType = gsr.GetStatusChange(scrType);
                if (screspType.desc != "Success")
                    break;
            }
            catch
            {
                break;                
            }
        }
    }

    private void OnThreadComplete(Task tsk)
    {
        webRequest.Abort();
        ServicePointManager.FindServicePoint(new Uri(url)).CloseConnectionGroup(action);
        if (tsk.IsCanceled || tsk.IsFaulted)
            throw new Exception("Operation exception");
    }

    void ResponseCallback(IAsyncResult asyncResult)
    {
        KillTask();
        result = new XmlDocument();
        using (HttpWebResponse response = (asyncResult.AsyncState as HttpWebRequest).EndGetResponse(asyncResult) as HttpWebResponse)
            using(StreamReader reader = new StreamReader(response.GetResponseStream()))
                result.LoadXml(reader.ReadToEnd());
    }

    private void OnException(Exception e)
    {
        Error error = new Error(e);
        SerializeError(error);
    }

    private void OnException(String message, String stackTrace)
    {
        Error error = new Error(message, stackTrace);
        SerializeError(error);
    }

    private void SerializeError(Error err)
    {
        KillTask();
        if (result == null)
            result = new XmlDocument();
        XmlSerializer xmlSerializer = new XmlSerializer(typeof(Error));
        String errorXml = "";

        using (var stringWriter = new StringWriter())
        {
            using (XmlWriter xmlWriter = XmlWriter.Create(stringWriter))
            {
                xmlSerializer.Serialize(xmlWriter, err);
                errorXml = stringWriter.ToString();
            }
        }
        result.LoadXml(errorXml);
    }

    private void KillTask()
    {
        if (canToken != null)
            canToken.Cancel();
    }

    private void ping(String url)
    {
        Ping pinger = new Ping();
        
        PingReply reply = pinger.Send(url, 2000, Encoding.ASCII.GetBytes("test"),new PingOptions(600, false));
        if (reply.Status != IPStatus.Success)
            throw new Exception("Неможливо встановити з'єднання за адресою: " + ip);
    }
}

[Serializable]
public class Error
{
    public string Message { get; set; }
    public string StackTrace { get; set; }

    public Error() { }

    public Error(Exception ex)
    {
        this.Message = ex.Message;
        this.StackTrace = ex.StackTrace;
    }

    public Error(String message, String stackTrace)
    {
        this.Message = message;
        this.StackTrace = stackTrace;
    }
}
