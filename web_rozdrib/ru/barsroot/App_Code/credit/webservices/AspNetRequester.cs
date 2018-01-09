using System;
using System.Text.RegularExpressions;
using System.Net;
using System.Web;
using System.Text;

class AspNetRequester
{
    CookiedWebClient wc = null;
    
    public AspNetRequester(WebProxy Proxy)
    {
        wc = new CookiedWebClient(Proxy);
    }
    
    public byte[] LoginToPage(Uri uri
        , string login
        , string password)
    {
        string initContent = Encoding.UTF8.GetString(wc.DownloadData(uri));
        Uri actionUri;
        string dataToSend = GrabFormData(initContent, uri, login, password, out actionUri);
        wc.Headers.Add(HttpRequestHeader.Referer, uri.AbsoluteUri);
        wc.Headers.Add(HttpRequestHeader.ContentType, "application/x-www-form-urlencoded");
        byte[] data = Encoding.ASCII.GetBytes(dataToSend);
        return wc.UploadData(actionUri, "POST", data);
    }

    public byte[] GetContentAuthenticated(Uri contentPage)
    {
        wc.Headers.Add(HttpRequestHeader.Referer, contentPage.AbsoluteUri);
        return wc.DownloadData(contentPage);
    }

    public String GetContentAuthenticatedStr(Uri contentPage)
    {
        wc.Headers.Add(HttpRequestHeader.Referer, contentPage.AbsoluteUri);
        return wc.DownloadString(contentPage);
    }


    /*
    public string GetContentAuthenticated(Uri contentPage)
    {
        wc.Headers.Add(HttpRequestHeader.Referer, contentPage.AbsoluteUri);
        return wc.DownloadString(contentPage);
    }
    */
    private string GrabFormData(string content
        , Uri baseUri
        , string login
        , string password
        , out Uri actionUri)
    {
        StringBuilder sbRequestData = new StringBuilder();
        string paramFormatString = "&{0}={1}";

        Match authUri = Regex.Match(content
            , @"<form\s[^>]*?action=[""']([^""'\s]+)[""'][^>]*?>"
            , RegexOptions.IgnoreCase);

        if (!authUri.Success)
            throw new ArgumentNullException("Атрибут action у тега form не обнаружен!");

        string uriString = authUri.Groups[1].Value.Trim();
        Uri tempUri;
        if (Uri.TryCreate(uriString, UriKind.Absolute, out tempUri)
            || Uri.TryCreate(baseUri, uriString, out tempUri))
            actionUri = tempUri;
        else
            throw new ArgumentNullException("Атрибут action у тега form не является корректным адресом: " + uriString);
        foreach (Match m in Regex.Matches(content
            , @"<input\s([^>]+?)>"
            , RegexOptions.IgnoreCase))
        {
            Match attr = Regex.Match(m.Groups[1].Value
                , @"type=[""']?([^""']+)[""']?"
                , RegexOptions.IgnoreCase);
            string type = string.Empty;
            string name = string.Empty;
            string value = string.Empty;
            if (attr.Success)
                type = attr.Groups[1].Value.Trim();
            attr = Regex.Match(m.Groups[1].Value
                , @"name=[""']?([^""']+)[""']?"
                , RegexOptions.IgnoreCase);
            if (attr.Success)
                name = attr.Groups[1].Value.Trim();
            attr = Regex.Match(m.Groups[1].Value
                , @"value=[""']?([^""']+)[""']?"
                , RegexOptions.IgnoreCase);
            if (attr.Success)
                value = attr.Groups[1].Value.Trim();
            if (type.Length == 0 || name.Length == 0)
                continue;
            switch (type.ToLower())
            {
                case "text":
                    if (name.ToUpper().Contains("LOGIN"))
                        sbRequestData.AppendFormat(paramFormatString
                            , name
                            , HttpUtility.UrlEncode(login));
                    break;
                case "password":
                    if (name.ToUpper().Contains("PASS"))
                        sbRequestData.AppendFormat(paramFormatString
                            , name
                            , HttpUtility.UrlEncode(password));
                    break;
                case "submit":
                    if (name.ToUpper().Contains("LOGIN"))
                    {
                        sbRequestData.AppendFormat(paramFormatString
                            , name
                            , HttpUtility.UrlEncode(value));
                    }
                    break;
                default:
                    if (value.Length > 0)
                        sbRequestData.AppendFormat(paramFormatString
                            , name
                            , HttpUtility.UrlEncode(value));
                    break;
            }
        }
        return sbRequestData.ToString().TrimStart('&');
    }

    class CookiedWebClient : WebClient
    {
        CookieContainer _cookies = new CookieContainer();
        private WebProxy _proxy = null;
        public CookiedWebClient(WebProxy Proxy)
        {
            _proxy = Proxy;
        }
        protected override WebRequest GetWebRequest(Uri address)
        {
            WebRequest request = base.GetWebRequest(address);
            if (_proxy != null)
                request.Proxy = _proxy;
            if (request is HttpWebRequest)
            {
                ((HttpWebRequest)request).CookieContainer = _cookies;
                ((HttpWebRequest)request).UserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.1.4322; .NET CLR 2.0.40607)";
                ((HttpWebRequest)request).Accept = "application/x-ms-application, image/jpeg, application/xaml+xml, image/gif, image/pjpeg, application/x-ms-xbap, application/x-shockwave-flash, */*";
                ((HttpWebRequest)request).Headers.Add(HttpRequestHeader.AcceptLanguage, "ru-RU");
                ((HttpWebRequest)request).AllowAutoRedirect = false;
                ((HttpWebRequest)request).AutomaticDecompression = DecompressionMethods.Deflate
                    | DecompressionMethods.GZip;
                ServicePointManager.Expect100Continue = false;
                ServicePointManager.DefaultConnectionLimit = 1000;
                ServicePointManager.ServerCertificateValidationCallback += ((sender
                    , certificate, chain, sslPolicyErrors) => { return true; });
            }
            return request;
        }
    }
}
