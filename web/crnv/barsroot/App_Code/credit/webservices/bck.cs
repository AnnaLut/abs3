using System;
using System.Collections.Generic;
using System.Configuration;
using System.Xml;
using System.IO;
using System.Web;
using System.Net;
using System.Text;
using System.Web.Services;
using System.Security.Cryptography.X509Certificates;
using System.Globalization;

public enum PvbkiClientType
{
    Individual = 2,
    Company = 12
}

public class bki
{
    protected ProxySettingsClass ProxySettings = new ProxySettingsClass();

    public bki()
    {
        loadProxySettings();
        loadConfig();
    }

    private void loadProxySettings()
    {
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["proxy.Active"]))
            ProxySettings.ProxyActive = ConfigurationManager.AppSettings["proxy.Active"].ToLower() == "true";
        ProxySettings.ProxyAddress = ConfigurationManager.AppSettings["proxy.Address"];
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["proxy.Auth"]))
            ProxySettings.ProxyAuth = ConfigurationManager.AppSettings["proxy.Auth"].ToLower() == "true";
        ProxySettings.ProxyDomain = ConfigurationManager.AppSettings["proxy.Domain"];
        ProxySettings.ProxyPassword = ConfigurationManager.AppSettings["proxy.Password"];
        if (!String.IsNullOrEmpty(ConfigurationManager.AppSettings["proxy.Port"]))
            ProxySettings.ProxyPort = Convert.ToInt16(ConfigurationManager.AppSettings["proxy.Port"]);
        ProxySettings.ProxyUser = ConfigurationManager.AppSettings["proxy.User"];
    }

    protected virtual void loadConfig()  { }

    /// <summary>
    /// Прокси
    /// </summary>
    protected WebProxy Proxy
    {
        get
        {
            if (ProxySettings.ProxyActive)
            {
                NetworkCredential cred;
                WebProxy proxy = new WebProxy(ProxySettings.ProxyAddress, Convert.ToInt16(ProxySettings.ProxyPort));
                if (ProxySettings.ProxyAuth)
                {
                    if (String.IsNullOrEmpty(ProxySettings.ProxyDomain))
                        cred = new NetworkCredential(ProxySettings.ProxyUser, ProxySettings.ProxyPassword);
                    else
                        cred = new NetworkCredential(ProxySettings.ProxyUser, ProxySettings.ProxyPassword, ProxySettings.ProxyDomain);
                    proxy.Credentials = cred;
                }
                return proxy;
            }
            else
                return null;

        }
    }
}

/// <summary>
/// Параметры подключения через прокси
/// </summary>
public class ProxySettingsClass
{
    public bool ProxyActive { get; set; }
    public string ProxyAddress { get; set; }
    public int ProxyPort { get; set; }
    public bool ProxyAuth { get; set; }
    public string ProxyUser { get; set; }
    public string ProxyPassword { get; set; }
    public string ProxyDomain { get; set; }
}

/// <summary>
/// Проверка сертификата
/// </summary>
public class MyCertificateValidation : ICertificatePolicy
{
    public bool CheckValidationResult(ServicePoint sp, X509Certificate cert,
    WebRequest request, int problem)
    {
        return true;
    }
}

public class pvbki : bki
{
    /// <summary>
    /// Параметры отчета
    /// </summary>
    private class ReportInfo
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string UserId { get; set; }
        public ReportInfo(String Id, String Name, String UserId)
        {
            this.Id = Id;
            this.Name = Name;
            this.UserId = UserId;
        }
    }

    private String _reportServiceUrl;
    private String _reportServiceHttpUrl;
    private String _reportServiceUserName;
    private String _reportServicePassword;
    private String _cientCertificateFileName;

    protected override void loadConfig()
    {
        _reportServiceUrl = ConfigurationManager.AppSettings["pvbki.ReportServiceUrl"];
        _reportServiceHttpUrl = ConfigurationManager.AppSettings["pvbki.ReportServiceHttpUrl"];
        _reportServiceUserName = ConfigurationManager.AppSettings["pvbki.ReportServiceUserName"];
        _reportServicePassword = ConfigurationManager.AppSettings["pvbki.ReportServicePassword"];
        _cientCertificateFileName = ConfigurationManager.AppSettings["pvbki.ClientCertificateFileName"];
    }

    /// <summary>
    /// Создает экземпляр веб-сервиса отчетов
    /// </summary>
    /// <returns>CigReports instance</returns>
    private CigReports createReportService()
    {
        CigReports reportService = new CigReports();
        reportService.Url = _reportServiceUrl;
        if (ProxySettings.ProxyActive)
            reportService.Proxy = Proxy;
        CigWsHeader header = new CigWsHeader();
        header.UserName = _reportServiceUserName;
        header.Password = _reportServicePassword;
        header.Version = "1_0";
        header.Culture = "uk-UA";
        reportService.CigWsHeaderValue = header;
        if (!String.IsNullOrEmpty(_cientCertificateFileName))
        {
            reportService.ClientCertificates.Add(X509Certificate.CreateFromCertFile(HttpContext.Current.Server.MapPath(_cientCertificateFileName)));
            System.Net.ServicePointManager.CertificatePolicy = new MyCertificateValidation();
        }
        return reportService;
    }

    /// <summary>
    /// Возвращает список доступных пользоватлею отчетов
    /// </summary>
    /// <param name="SubjectIdNumber">Ид.код</param>
    /// <param name="SubjectNumberType">Тип кода</param>
    /// <returns>Список отчетов</returns>
    private List<ReportInfo> GetAvaliableReports(string SubjectIdNumber, string SubjectNumberType)
    {
        CigReports reports = createReportService();
        XmlNode repList = reports.GetAvailableReportsForId(SubjectIdNumber, SubjectNumberType);

        XmlDocument doc = new XmlDocument();
        doc.LoadXml(repList.OuterXml);

        XmlNode reps = doc.SelectSingleNode("/CigResult/Result/AvailableReports");
        string userName = reps.Attributes["user"].Value;
        string userid = reps.Attributes["creditinfoId"].Value;

        XmlNodeList nodeList = doc.SelectNodes("/CigResult/Result/AvailableReports/Report");

        List<ReportInfo> list = new List<ReportInfo>();
        foreach (XmlNode node in nodeList)
        {
            ReportInfo rep = new ReportInfo(node.Attributes["id"].Value, node.Attributes["name"].Value, userid);
            list.Add(rep);
        }
        return list;
    }

    /// <summary>
    /// Получает HTML отчета (byte)
    /// </summary>
    /// <param name="ClientType">Тип клиента</param>
    /// <param name="Identification">Ид.код клиента</param>
    /// <returns>HTML отчета</returns>
    public byte[] GetReport(PvbkiClientType ClientType, String Identification)
    {
        List<ReportInfo> reports = GetAvaliableReports(Identification, ((int)ClientType).ToString());

        if (reports.Count == 0) return new byte[0];
        ReportInfo report = reports[reports.Count - 1];

        string report_type = String.Empty;
        switch (report.Id)
        {
            case "BLANK_IND":
                report_type = "200046";
                break;
            case "BLANK_COMP":
                report_type = "200045";
                break;
            case "BASIC_IND":
                report_type = "200000";
                break;
            case "BASIC_COMP":
                report_type = "99993";
                break;
            case "STANDARD_IND":
                report_type = "200017";
                break;
            case "STANDARD_COMP":
                report_type = "200014";
                break;
            case "ADVANCED_IND":
                report_type = "200019";
                break;
            case "ADVANCED_COMP":
                report_type = "200018";
                break;
            case "UNIVERSAL_IND":
                report_type = "200049";
                break;
            case "UNIVERSAL_COMP":
                report_type = "200048";
                break;
        }

        string loginUri = _reportServiceHttpUrl + "?ReturnUrl=%2fFrontOffice%2fdefault.aspx";
        string reportUri = loginUri.Replace("Login.aspx?ReturnUrl=%2fFrontOffice%2fdefault.aspx", "DisplayReport.aspx") + "?ReportId=" + report.UserId + "&ReportType=" + report_type;

        AspNetRequester anr = new AspNetRequester(Proxy);
        anr.LoginToPage(new Uri(loginUri), _reportServiceUserName, _reportServicePassword);
        String buf = Encoding.UTF8.GetString(anr.GetContentAuthenticated(new Uri(reportUri)));
        buf = buf.Replace("</head>", "<link href='/Common/CSS/pvbki.css' type='text/css' rel='stylesheet'/></head>");
        return Encoding.UTF8.GetBytes(buf);

    }

    /// <summary>
    /// Получает HTML отчета (string)
    /// </summary>
    /// <param name="ClientType">Тип клиента</param>
    /// <param name="Identification">Ид.код клиента</param>
    /// <returns>HTML отчета</returns>
    public string GetReportString(PvbkiClientType ClientType, String Identification)
    {
        return Encoding.UTF8.GetString(GetReport(ClientType, Identification));
    }

}

public class ubki : bki
{
    private string _serviceUrl;
    private string _serviceUserName;
    private string _servicePassword;
    enum TypeRequests
    {
        ALL, ALB, BLC
    }
    protected override void loadConfig()
    {
        _servicePassword = ConfigurationManager.AppSettings["ubki.Password"];
        _serviceUrl = ConfigurationManager.AppSettings["ubki.ServiceUrl"];
        _serviceUserName = ConfigurationManager.AppSettings["ubki.UserName"];
    }
    public XmlNode GetReport(String ReportType, String TaxId, String PSerial, String PNumber)
    {
        ASCIIEncoding encoding = new ASCIIEncoding();

        string queryString =
            String.Format(HttpContext.Current.Server.UrlDecode(_serviceUrl),
                _serviceUserName, _servicePassword, ReportType,
                TaxId, Resources.bck.Encoding,
                PSerial, PNumber);

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(queryString);
        //request.Accept = "application/soap+xml";
        request.Proxy = this.Proxy;
        request.Method = "GET";

        // Assign the response object of 'HttpWebRequest' to a 'HttpWebResponse' variable.
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();

        // Display the contents of the page to the console.
        Stream streamResponse = response.GetResponseStream();

        // Get stream object
        StreamReader streamRead = new StreamReader(streamResponse);

        Char[] readBuffer = new Char[256];

        // Read from buffer
        int count = streamRead.Read(readBuffer, 0, 256);

        string resultData = String.Empty;

        while (count > 0)
        {
            // get string
            resultData += new String(readBuffer, 0, count);

            // Read from buffer
            count = streamRead.Read(readBuffer, 0, 256);
        }

        // Release the response object resources.
        streamRead.Close();
        streamResponse.Close();
        // Close response
        response.Close();
        XmlDocument doc = new XmlDocument();
        doc.LoadXml(resultData);
        return doc;
    }
}

public class pvbkipassp : bki
{
    public class PasspResponse
    {
        public int Parcel = -1;
        public int State = -1;
        public bool Recognized;
        public bool Accepted;
        public string Messages = string.Empty;
        public string Errors = string.Empty;
        public Int32 RequestId = -1;
        public int? Response = null;
    }

    private const string CODE_SUCC = "00";
    private const string CODE_ERR = "FF";

    private const string PASSP_OK = "OK";
    private const string PASSP_LOST = "LOST";
    private const string PASSP_UNKNOWN = "UNKNOWN";

    private const string SEP = "~~";

    private string _passpServiceUrl;
    private int _passpServiceAbonent;
    private string _passpServiceUserName;
    private string _passpServicePassword;
    private string _cientCertificateFileName;
    private string _endpointName;
    private string _endpointKeyPath;
    private int _notifyWaitTimeout;
    private int _notifyIteration;

    protected override void loadConfig()
    {
        _passpServiceUrl = ConfigurationManager.AppSettings["pvbki.PasspServiceUrl"];
        _passpServiceAbonent = Convert.ToInt16(ConfigurationManager.AppSettings["pvbki.PasspServiceAbonent"]);
        _passpServiceUserName = ConfigurationManager.AppSettings["pvbki.PasspServiceUserName"];
        _passpServicePassword = ConfigurationManager.AppSettings["pvbki.PasspServicePassword"];
        _cientCertificateFileName = ConfigurationManager.AppSettings["pvbki.PasspClientCertificateFileName"];
        _endpointName = ConfigurationManager.AppSettings["pvbki.PasspEndpointName"];
        _endpointKeyPath = ConfigurationManager.AppSettings["pvbki.PasspEndpointKeyPath"];
        _notifyIteration = Convert.ToInt16(ConfigurationManager.AppSettings["pvbki.PasspNotifyIteration"]);
        _notifyWaitTimeout = Convert.ToInt16(ConfigurationManager.AppSettings["pvbki.PasspNotifyWaitTimeout"]);
    }

    private byte[] getEndpointKey()
    {
        byte[] res = null;
        FileStream fs = new FileStream(HttpContext.Current.Server.MapPath(_endpointKeyPath), FileMode.Open);
        try
        {
            res = new byte[fs.Length];
            fs.Read(res, 0, (int)fs.Length);
            return res;
        }
        finally
        {
            fs.Close();
            fs.Dispose();
            fs = null;
        }
    }

    public PasspResponse ParseResponse(byte[] data)
    {
        PasspResponse res = new PasspResponse();
        string xml = Encoding.GetEncoding(1251).GetString(data);
        XmlDocument doc = new XmlDocument();
        doc.LoadXml(xml);
        res.Parcel = Convert.ToInt32(doc.SelectSingleNode("/MVD/Request/parcel").InnerText);
        res.Accepted = Convert.ToInt16(doc.SelectSingleNode("/MVD/Request/accepted").InnerText) == 1;
        res.Recognized = Convert.ToInt16(doc.SelectSingleNode("/MVD/Request/recognized").InnerText) == 1;
        res.State = Convert.ToInt16(doc.SelectSingleNode("/MVD/Request/state").InnerText);

        XmlNodeList messages = doc.SelectNodes("/MVD/Message");
        foreach (XmlNode node in messages)
        {
            res.Messages +=
                "[" + node.SelectSingleNode("code").InnerText + "] " +
                node.SelectSingleNode("kind").InnerText + ": " +
                node.SelectSingleNode("message").InnerText + "\r\n";
        }

        XmlNodeList errors = doc.SelectNodes("/MVD/Error");
        foreach (XmlNode node in errors)
        {
            res.Errors +=
                (node.SelectSingleNode("field") != null ? node.SelectSingleNode("field").InnerText + " " : String.Empty)+
                node.SelectSingleNode("report").InnerText + "\r\n";
        }

        XmlNode reqid = doc.SelectSingleNode("/MVD/Detail/requestid");
        if (reqid != null)
        {
            res.RequestId = Convert.ToInt32(reqid.InnerText);
        }

        XmlNode resp = doc.SelectSingleNode("/MVD/Detail/response");
        if (resp != null)
        {
            res.Response = Convert.ToInt32(resp.InnerText);
        }

        return res;
    }

    public PVBKIPassportWebService createPasspService()
    {
        
        InnerAuthHeader h1 = new InnerAuthHeader();
        h1.Abonent = _passpServiceAbonent;
        h1.UserName = _passpServiceUserName;
        h1.Password = _passpServicePassword;

        AdaptiveTuningHeader h2 = new AdaptiveTuningHeader();
        h2.Culture = 0;
        h2.OSInfo = "";
        h2.RuntimeVersion = "";
        h2.IpAddress = "";
        h2.SoapVersion = SoapProtocolVersion.Default;
        h2.UserAgent = "unity-bars.bck";
        h2.RequestSize = 0;

        OuterAuthHeader h3 = new OuterAuthHeader();
        h3.Name = _endpointName; //Имя точки доступа клиента к службе
        h3.Credential = getEndpointKey(); //Ключ доступа клиента к службе (генерируется и выдаётся в ПВБКИ)

        InvokeEscortHeader h4 = new InvokeEscortHeader();
        h4.Passed = 1; //Количество паспортов во входной посылке
        h4.MaxErrors = 1024; //Пороговое количество ошибочных записей при достижении/превышении которого, вся посылка будет отклонена, несмотря на наличие некоторого количества абсолютно корректных записей

        PVBKIPassportWebService service = new PVBKIPassportWebService();
        service.InnerAuthentication = h1;
        service.AdaptiveTuning = h2;
        service.OuterAuthentication = h3;
        service.PassInvoke = h4;
        service.Url = _passpServiceUrl;
        service.Proxy = this.Proxy;

        return service;
    }

    public string FromHex(string hex)
    {
        byte[] raw = new byte[hex.Length / 2];
        for (int i = 0; i < raw.Length; i++)
        {
            raw[i] = Convert.ToByte(hex.Substring(i * 2, 2), 16);
        }
        return Encoding.UTF8.GetString(raw);
    }

    public string MvdRequest(string Ser, string Num, string Okpo, string F, string I, string O, string BirthDate)
    {
        PVBKIPassportWebService service = createPasspService();
        XmlDocument doc = new XmlDocument();

        XmlNode node = doc.CreateNode(XmlNodeType.XmlDeclaration, String.Empty, String.Empty);
        doc.AppendChild(node);
        XmlDeclaration decl = (XmlDeclaration)doc.FirstChild;
        decl.Encoding = "windows-1251";

        XmlElement mvd = doc.CreateElement("MVD");
        XmlElement reqvest = doc.CreateElement("Request");
        mvd.AppendChild(reqvest);
        doc.AppendChild(mvd);

        if (!string.IsNullOrEmpty(Okpo))
        {
            XmlElement drfo = doc.CreateElement("drfo");
            reqvest.AppendChild(drfo);
            drfo.InnerText = FromHex(Okpo);
        }

        if (!string.IsNullOrEmpty(Ser))
        {
            XmlElement ptseria = doc.CreateElement("ptseria");
            reqvest.AppendChild(ptseria);
            ptseria.InnerText = FromHex(Ser);
        }

        if (!string.IsNullOrEmpty(Num))
        {
            XmlElement ptnum = doc.CreateElement("ptnum");
            reqvest.AppendChild(ptnum);
            ptnum.InnerText = FromHex(Num);
        }

        if (!string.IsNullOrEmpty(F))
        {
            XmlElement f = doc.CreateElement("f");
            reqvest.AppendChild(f);
            f.InnerText = FromHex(F);
        }

        if (!string.IsNullOrEmpty(I))
        {
            XmlElement i = doc.CreateElement("i");
            reqvest.AppendChild(i);
            i.InnerText = FromHex(I);
        }

        if (!string.IsNullOrEmpty(O))
        {
            XmlElement o = doc.CreateElement("o");
            reqvest.AppendChild(o);
            o.InnerText = FromHex(O);
        }

        if (!string.IsNullOrEmpty(BirthDate))
        {
            XmlElement birthdate = doc.CreateElement("birthdate");
            reqvest.AppendChild(birthdate);
            birthdate.InnerText = XmlConvert.ToString(
                DateTime.ParseExact(BirthDate, "dd.MM.yyyy", DateTimeFormatInfo.InvariantInfo)
            );

        }

        byte[] buffer = Encoding.Convert(Encoding.UTF8, Encoding.GetEncoding(1251), Encoding.UTF8.GetBytes(doc.OuterXml));
        
        /*
        FileStream fs = new FileStream("e:\\req.xml", FileMode.Create);
        fs.Write(buffer, 0, buffer.Length);
        fs.Close();
        */
       
        
        byte[] reqResBuf = service.RequestToMVD(buffer);

        /*
        FileStream fs2 = new FileStream("e:\\resp.xml", FileMode.Create);
        fs2.Write(reqResBuf, 0, reqResBuf.Length);
        fs2.Close();
        */

        PasspResponse reqRes = this.ParseResponse(reqResBuf);

        if (reqRes.State != 7)
            return
                Convert.ToString(reqRes.RequestId) + SEP +
                CODE_ERR + SEP +
                PASSP_UNKNOWN + SEP +
                reqRes.Errors + reqRes.Messages;

        byte[] frResBuf = null;
        PasspResponse frRes = null;

        for (int n = 0; n < _notifyIteration; n++)
        {
            System.Threading.Thread.Sleep(_notifyWaitTimeout);

            frResBuf = service.FreshMVDNotify(reqRes.Parcel);
            frRes = this.ParseResponse(frResBuf);

            /*
            FileStream fs3 = new FileStream("e:\\notify.xml", FileMode.Create);
            fs3.Write(frResBuf, 0, frResBuf.Length);
            fs3.Close();
            */

            if (frRes.State == 9)
                return
                    Convert.ToString(reqRes.RequestId) + SEP +
                    CODE_SUCC + SEP +
                    (frRes.Response == 0 ? PASSP_OK : PASSP_LOST) + SEP +
                    "Done! Response is " + (frRes.Response == 0 ? PASSP_OK : PASSP_LOST);                    
                    
        }

        return
            Convert.ToString(reqRes.RequestId) + SEP +
            CODE_ERR + SEP + 
            PASSP_UNKNOWN + SEP +
            "Timeout (" + _notifyWaitTimeout.ToString() + "x" + _notifyIteration.ToString() + ") expired";
    }
}

[WebService(Namespace = "http://ws.unity-bars.com.ua/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class bck : System.Web.Services.WebService
{

    [WebMethod]
    public string GetReportPVBKI(String ReportType, String TaxId, String PSerial, String PNumber)
    {
        pvbki svc = new pvbki();
        PvbkiClientType type;
        if (ReportType == "12")
            type = PvbkiClientType.Company;
        else if (ReportType == "2")
            type = PvbkiClientType.Individual;
        else
            throw new ArgumentException(String.Format("Unknown report type {0}", ReportType));

        return svc.GetReportString(type, TaxId); ;
    }

    [WebMethod]
    public string CheckPasspPVBKI(string Ser, string Num, string Okpo, string F, string I, string O, string BirthDate)
    {
        pvbkipassp svc = new pvbkipassp();
        return svc.MvdRequest(Ser, Num, Okpo, F, I, O, BirthDate);
    }

    [WebMethod]
    public string GetReportUBKI(String ReportType, String TaxId, String PSerial, String PNumber)
    {
        ubki svc = new ubki();
        return svc.GetReport(ReportType, TaxId, PSerial, PNumber).OuterXml;
    }
}

