using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using ibank.core.Exceptions;
using ibank.objlayer;
using ibank.core;
using System.Xml;
using System.Xml.Serialization;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Xml.Linq;
using System.Linq;

namespace barsroot.core
{
    /// <summary>
    /// Вспомогательные функции
    /// </summary>
    public class WebUtility
    {
        public WebUtility() { }

        public static string GetHostName()
        {
            string userHost = string.Empty;
            if (HttpContext.Current != null)
            {
                userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

                if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
                    userHost = HttpContext.Current.Request.UserHostAddress;

                if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
                    userHost += " (" + HttpContext.Current.Request.UserHostName + ")";
            }
            return userHost;
        }

        /// <summary>
        /// Проверка аутентификации
        /// </summary>
        public static bool isUserAuth
        {
            get { return HttpContext.Current.User.Identity.IsAuthenticated; }
        }

        /// <summary>
        /// Вычитка параметра из строки адреса (если не нашло, возвращает умолчательное значение)
        /// </summary>
        /// <param name="param">имя параметра</param>
        /// <param name="defaultValue">умолчательное значение</param>
        /// <returns>значение параметра</returns>
        public static string GetParameter(string param, string defaultValue)
        {
            string stringValue = HttpContext.Current.Request.QueryString[param];
            if (null != stringValue)
            {
                return stringValue;
            }
            else
            {
                return defaultValue;
            }
        }

        /// <summary>
        /// Вычитка параметра из строки адреса (если не нашло, исключение)
        /// </summary>
        /// <param name="param">имя параметра</param>
        /// <returns>значение параметра</returns>
        public static string GetParameter(string param)
        {
            string stringValue = HttpContext.Current.Request.QueryString[param];
            if (null == stringValue)
            {
                throw new BBException(string.Format("Параметр {0} - обязательный", param));
            }
            return stringValue;
        }

        /// <summary>
        /// Проверка наличия параметра в стоке адреса
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        public static bool CheckParameterExist(string param)
        {
            return null != HttpContext.Current.Request.QueryString[param];
        }

        /// <summary>
        /// Добавляем в строку адресса параметр
        /// </summary>
        /// <param name="parName">имя параметра</param>
        /// <param name="parValue">значение параметра</param>
        public static void AddParameter(string parName, string parValue)
        {
            string currentUrl = HttpContext.Current.Request.Url.LocalPath;
            string newUrl = string.Format("{0}{1}{2}", currentUrl, currentUrl.IndexOf('?') >= 0 ? "&" : "?", parName + "=" + parValue);
            HttpContext.Current.Response.Redirect(newUrl, true);
        }

        /// <summary>
        /// Удалаем параметр из адресса
        /// </summary>
        /// <param name="parName">имя параметра</param>
        public static void RemoveParameter(string parName)
        {
            string currentUrl = HttpContext.Current.Request.Url.LocalPath;
            string regExp = string.Format("(&{0}=)[^&]*", parName);
            string newUrl = Regex.Replace(currentUrl, regExp, String.Empty);
            HttpContext.Current.Response.Redirect(newUrl, true);
        }

        /// <summary>
        /// Добавить к странице ссылку на скрипт
        /// </summary>
        /// <param name="page">страница</param>
        /// <param name="jsfile">путь к файлу скрипта</param>
        public static void IncludeJS(Page page, string jsfile)
        {
            HtmlGenericControl include = new HtmlGenericControl("script");
            include.Attributes.Add("type", "text/javascript");
            include.Attributes.Add("src", jsfile);
            page.Header.Controls.Add(include);
        }

        /// <summary>
        /// Проверка на валидность сертификата SSL
        /// </summary>
        /// <returns></returns>
        public static bool IsValidCertificate
        {
            get
            {
                HttpRequest request = HttpContext.Current.Request;
                return request.ClientCertificate.IsPresent && request.ClientCertificate.IsValid;
            }
        }

        /// <summary>
        /// Отключение клиентского кеширования страницы (для страниц с вводом паролей)
        /// </summary>
        public static void DisableBrowserCache()
        {
            if (HttpContext.Current != null)
            {
                HttpContext.Current.Response.Cache.SetExpires(new DateTime(1995, 5, 6, 12, 0, 0, DateTimeKind.Utc));
                HttpContext.Current.Response.Cache.SetNoStore();
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Current.Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
                HttpContext.Current.Response.Cache.AppendCacheExtension("post-check=0,pre-check=0");
            }
        }

        /// <summary>
        /// Версия билда текущей страницы
        /// </summary>
        /// <returns></returns>
        public static string GetBuildVersion()
        {
            Assembly assembly = Assembly.GetExecutingAssembly();
            string version = assembly.GetName().Name.Replace("App_Code.", "");

            return version;
        }

        /// <summary>
        /// 2-x символьное значение текущей локализации клиента
        /// </summary>
        /// <returns></returns>
        public static string GetCurrrentCulture()
        {
            return Thread.CurrentThread.CurrentUICulture.ThreeLetterWindowsLanguageName.ToLower();
        }

        /// <summary>
        /// Версия IE
        /// </summary>
        /// <returns></returns>
        public static float GetInternetExplorerVersion()
        {
            float rv = -1;
            System.Web.HttpBrowserCapabilities browser = HttpContext.Current.Request.Browser;
            if (browser.Browser == "IE")
                rv = (float)(browser.MajorVersion + browser.MinorVersion);
            return rv;
        }

        /// <summary>
        /// Информация о клиентском браузере
        /// </summary>
        /// <returns></returns>
        public static string GetClientBrowserInfo()
        {
            System.Web.HttpBrowserCapabilities browser = HttpContext.Current.Request.Browser;
            return browser.Browser + " v." + browser.Version + " - " + browser.Platform;
        }

        /// <summary>
        /// Обработка исключения и сохранение в сесии отформатированого сообщения об ошибке
        /// </summary>
        /// <param name="ex">Пойманое исключение</param>
        public static void SaveExceptionInSession(Exception ex)
        {
            HttpContext.Current.Session["AppError"] = ex;
        }

        /// <summary>
        /// Превращение объекта из БД в xml для soap-запроса
        /// </summary>
        /// <param name="Т">тип объекта</param>
        /// <param name="objToSerialize">экземпляр объекта</param>
        public static XmlDocument SerializeObject<T>(T objToSerialize)
        {
            XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));
            XmlSerializerNamespaces names = new XmlSerializerNamespaces();
            names.Add("", "");
            XmlDocument xmlDoc = new XmlDocument();
            XmlDocument xmlResult = new XmlDocument();
            using (MemoryStream mStream = new MemoryStream())
            {
                using (XmlWriter writer = XmlWriter.Create(mStream))
                {
                    xmlSerializer.Serialize(writer, objToSerialize, names);
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

        /// <summary>
        /// Добавление к запросу сертификата, если кроме ssl-соединения требуется еще один уровень аутентификации
        /// </summary>
        /// <param name="request">экземпляр запроса</param>
        /// <param name="certName">имя сертификата для поиска в хранилище сертификатов</param>
        public static void ManageSSlCertification(HttpWebRequest request, string certName)
        {
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
            catch (Exception ex)
            {
                throw new Exception("Сертифікат для запитів до сервісу не знайдено (пошук по імені [" + certName + "]). Текст помилки: " + ex.Message);
            }

            request.ClientCertificates.Add(cert);
        }

        public static String ParseResponseWithGeneralWebServiceError(String xml)
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
    }
}
