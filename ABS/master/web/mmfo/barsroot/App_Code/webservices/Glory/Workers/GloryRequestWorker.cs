using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.SessionState;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;

namespace Bars.WebServices.Glory
{
    /// <summary>
    /// Работяга для отправки запросов/получения статусов от АТМ
    /// </summary>
    public class GloryRequestWorker
    {
        private RequestModel requestModel; // Модель для инициализации входящими данными
        private Stream requestInputStream; // Тело входящего запроса
        private NameValueCollection headers; // Заголовки входящего запроса
        XmlDocument response; // Объект ответа
        Boolean isException = false; // true - в случае ошибки или обрыва связи. Используется для отмены дальнейших запросов к АТМ
        GloryWebRequestService requestService; // Сервис для отправки/получения данных к АТМ
        GloryDBExecutor dBExecutor; // Сервис для общения с БД
        String[] errorList; // Список ошибок полученных от АТМ
        HttpSessionState session; // ИД Сессии

        /// <summary>
        /// Работяга для отправки запросов/получения статусов от АТМ
        /// </summary>
        /// <param name="headers">Заголовки входящего запроса</param>
        /// <param name="requestInputStream">Тело входящего запроса</param>
        public GloryRequestWorker(NameValueCollection headers, Stream requestInputStream, HttpSessionState session)
        {
            this.headers = headers;
            this.requestInputStream = requestInputStream;
            this.requestModel = new RequestModel();
            this.response = new XmlDocument();
            this.dBExecutor = new GloryDBExecutor();
            this.errorList = new String[] { "COM ERROR" };
            this.session = session;
        }

        /// <summary>
        /// Инициализация данных
        /// </summary>
        /// <returns></returns>
        public GloryRequestWorker InitModels()
        {
            requestModel.Url = headers["GloryUrl"];
            requestModel.Action = headers["GloryAction"];
            requestModel.SessionId = headers["SessionID"];
            requestModel.IP = headers["GloryIP"];
            requestModel.IsLongRequest = headers["IsLongRequest"];
            requestModel.User = headers["User"];
            requestInputStream.Position = 0;
            try
            {
                using (StreamReader reader = new StreamReader(requestInputStream))
                    requestModel.Xml = HttpUtility.UrlDecode(reader.ReadToEnd());
            }
            catch (System.Exception e){ OnException(e); }
            requestService = new GloryWebRequestService(requestModel.Url, requestModel.IP, requestModel.SessionId);
            return this;
        }

        /// <summary>
        /// Проверка соединения
        /// </summary>
        /// <returns></returns>
        public GloryRequestWorker TestConnection()
        {
            try
            {
                requestService.PingATM();
                requestService.MakeRequest(GetStatusChangeXml(), "GetStatus", false, 10000);
                ParseGetStatusResponse();
            }
            catch (WebException e)
            {
                dBExecutor.ExecuteATMDisconnect(e.Message, session, requestModel.User);
            }
            catch (System.Exception e)
            {
                dBExecutor.ExecuteATMDisconnect(e.Message, session, requestModel.User);
                OnException(e);
            }
            return this;
        }

        /// <summary>
        /// Отправка запроса к АТМ
        /// </summary>
        /// <returns></returns>
        public GloryRequestWorker MakeRequest()
        {
            if (isException)
                return this;
            try
            {
                Boolean isLongRequest = !String.IsNullOrEmpty(requestModel.IsLongRequest) && requestModel.IsLongRequest == "1";
                requestService.MakeRequest(requestModel.Xml, requestModel.Action, isLongRequest);
            }
            catch(System.Exception e)
            {
                dBExecutor.ExecuteATMDisconnect(e.Message, session, requestModel.User);
                OnException(e);
            }
            return this;
        }

        /// <summary>
        /// Получение результата
        /// </summary>
        /// <returns></returns>
        public XmlDocument Execute()
        {
            if (this.response == null || String.IsNullOrEmpty(this.response.InnerXml))
                this.response = requestService.GetResponse();
            return this.response;
        }



        #region Private Methods

        /// <summary>
        /// Перегруженый метод сохранения данных об ошибке в ответ
        /// </summary>
        /// <param name="e"></param>
        private void OnException(System.Exception e)
        {
            Error error = new Error(e);
            SerializeError(error);
        }

        /// <summary>
        /// Перегруженый метод сохранения данных об ошибке в ответ
        /// </summary>
        /// <param name="message"></param>
        /// <param name="stackTrace"></param>
        private void OnException(String message, String stackTrace)
        {
            Error error = new Error(message, stackTrace);
            SerializeError(error);
        }

        /// <summary>
        /// Сериализация ошибки в xml
        /// </summary>
        /// <param name="err"></param>
        private void SerializeError(Error err)
        {
            requestService.KillTask();
            if (response == null)
                response = new XmlDocument();
            this.isException = true;
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
            response.LoadXml(errorXml);
        }

        /// <summary>
        /// Получение XML для тестового запроса
        /// </summary>
        /// <returns></returns>
        private String GetStatusChangeXml()
        {
            StringBuilder stringBuilder = new StringBuilder("<?xml version=\"1.0\" encoding=\"WINDOWS-1251\"?>");
            stringBuilder.Append("<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:gsr=\"http://www.glory.co.jp/gsr.xsd\">");
            stringBuilder.Append("<soapenv:Body>");
            stringBuilder.Append("<gsr:StatusRequest>");
            stringBuilder.Append("<gsr:Id>");
            stringBuilder.Append(requestModel.Url);
            stringBuilder.Append("</gsr:Id>");
            stringBuilder.Append("<gsr:SeqNo>TEST</gsr:SeqNo>");
            stringBuilder.Append("<gsr:SessionID>");
            stringBuilder.Append(requestModel.SessionId);
            stringBuilder.Append("</gsr:SessionID>");
            stringBuilder.Append("<Option gsr:type=\"1\"/>");
            stringBuilder.Append("</gsr:StatusRequest>");
            stringBuilder.Append("</soapenv:Body>");
            stringBuilder.Append("</soapenv:Envelope>");
            return stringBuilder.ToString();
        }

        /// <summary>
        /// Зазбор ответа на получение статуса (проверка связи)
        /// В случае не соответствия ответа или наличия ошибки в ответе - выбрасываем Exception
        /// </summary>
        private void ParseGetStatusResponse()
        {
            XmlDocument xmlDocument = requestService.GetResponse();
            XmlNodeList xmlNodeList = xmlDocument.GetElementsByTagName("DevStatus");
            String deviceStatus = String.Empty;
            if (xmlNodeList.Count > 0)
            {
                XmlNode descriptionAttr = xmlNodeList.Item(0).Attributes["n:desc"];
                if (descriptionAttr != null)
                    deviceStatus = descriptionAttr.Value;
            }
            if (errorList.Contains(deviceStatus))
                throw new SystemException(String.Format("Неможливо з'єднатися з АТМ: {0}", deviceStatus));
            if(String.IsNullOrEmpty(deviceStatus))
                throw new SystemException("Неможливо з'єднатися з АТМ за адресою: " + requestModel.IP);

        }

        #endregion
    }
}