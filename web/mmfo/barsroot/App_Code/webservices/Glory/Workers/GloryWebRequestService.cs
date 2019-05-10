using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Xml;

namespace Bars.WebServices.Glory
{
    /// <summary>
    /// Создание запросов к АТМ
    /// </summary>
    public class GloryWebRequestService
    {
        CancellationTokenSource cancellationToken;
        XmlDocument response;
        HttpWebRequest webRequest;
        String url;
        String ip;
        String sessionId;
        String action;

        public GloryWebRequestService(String url, String ip, String sessionId)
        {
            this.ip = ip;
            this.url = url;
            this.sessionId = sessionId;
            this.response = new XmlDocument();            
        }

        /// <summary>
        /// Выполнение запроса к АТМ
        /// </summary>
        /// <param name="xml"></param>
        /// <param name="action"></param>
        /// <param name="isLongRequest"></param>
        /// <param name="timeout"></param>
        public void MakeRequest(String xml, String action, Boolean isLongRequest, Int32 timeout = 600000)
        {
            webRequest = CreateWebRequest(xml, action);
            if (isLongRequest)
                InitLongRequestStatus();
            webRequest.BeginGetResponse(new AsyncCallback(ResponseCallback), webRequest);
        }

        public XmlDocument GetResponse()
        {
            return this.response;
        }

        #region Private Methods

        /// <summary>
        /// Получение ответа от АТМ
        /// </summary>
        /// <param name="asyncResult"></param>
        private void ResponseCallback(IAsyncResult asyncResult)
        {
            KillTask();
            using (HttpWebResponse webResponse = (asyncResult.AsyncState as HttpWebRequest).EndGetResponse(asyncResult) as HttpWebResponse)
            using (StreamReader reader = new StreamReader(webResponse.GetResponseStream()))
                response.LoadXml(reader.ReadToEnd());
        }

        /// <summary>
        /// Убить процесс запроса http
        /// </summary>
        public void KillTask()
        {
            if (cancellationToken != null)
                cancellationToken.Cancel();
        }

        /// <summary>
        /// Создание WebRequest
        /// </summary>
        /// <param name="requestXml">Входящий xml</param>
        /// <param name="timeout">Timeout (по умолчанию - 10 минут)</param>
        /// <returns></returns>
        private HttpWebRequest CreateWebRequest(String xml, String action, Int32 timeout = 600000)
        {
            XmlDocument requestXmlDocument = new XmlDocument();
            requestXmlDocument.LoadXml(xml);
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(url);
            webRequest.Headers.Add("SOAPAction", action);
            webRequest.ContentType = "text/xml;charset=\"utf-8\"";
            webRequest.Accept = "text/xml";
            webRequest.Method = "POST";
            webRequest.Timeout = timeout;
            webRequest.ReadWriteTimeout = timeout;

            using (Stream stream = webRequest.GetRequestStream())
                requestXmlDocument.Save(stream);
            return webRequest;
        }

        /// <summary>
        /// Проверка отклика сервера на ping
        /// </summary>
        public void PingATM()
        {
            Ping pinger = new Ping();
            PingReply reply = pinger.Send(ip, 2000, Encoding.ASCII.GetBytes("test"), new PingOptions(600, false));
            if (reply.Status != IPStatus.Success)
                throw new System.Exception("Неможливо встановити з'єднання за адресою: " + ip);
        }

        /// <summary>
        /// Получение ответа от Glory
        /// </summary>
        /// <param name="asyncResult"></param>
        private void ResponseCallbackFromGlory(IAsyncResult asyncResult)
        {
            KillTask();
            using (HttpWebResponse webResponse = (asyncResult.AsyncState as HttpWebRequest).EndGetResponse(asyncResult) as HttpWebResponse)
            using (StreamReader reader = new StreamReader(webResponse.GetResponseStream()))
                response.LoadXml(reader.ReadToEnd());
        }

        /// <summary>
        /// Используется для длинных запросов что бы сервер не заснул и не выбросил ошибку TimeoutException
        /// </summary>
        private void GetStatusChange()
        {
            GSRService gsr = new GSRService();
            gsr.Url = url;
            StatusChangeRequestType scrType = new StatusChangeRequestType
            {
                Id = "1",
                SeqNo = "123",
                SessionID = sessionId
            };

            DateTime start = DateTime.Now;
            while (true)
            {
                TimeSpan diff = DateTime.Now.Subtract(start);
                if (diff.Minutes >= 30)
                    break;
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

        /// <summary>
        /// Запуск процесса запросов для поддержки связи
        /// </summary>
        private void InitLongRequestStatus()
        {
            cancellationToken = new CancellationTokenSource();
            CancellationToken token = cancellationToken.Token;
            webRequest.ConnectionGroupName = action;
            Task.Factory.StartNew(() => GetStatusChange(), token)
                .ContinueWith(tsk => OnThreadComplete(tsk),
                TaskContinuationOptions.None);
        }

        /// <summary>
        /// Окончание запросов для поддержания связи
        /// </summary>
        /// <param name="tsk"></param>
        private void OnThreadComplete(Task tsk)
        {
            webRequest.Abort();
            ServicePointManager.FindServicePoint(new Uri(url)).CloseConnectionGroup(action);
            if (tsk.IsCanceled || tsk.IsFaulted)
                throw new System.Exception("Operation exception");
        }

        #endregion

    }
}