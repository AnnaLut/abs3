using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Xml.Serialization;

using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Core.Logger;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class EbkFindRepository : IEbkFindRepository
    {
        private const string _logMessagePrefix = "ЕБК.";
        private readonly IDbLogger _logger;

        public EbkFindRepository(IDbLogger logger)
        {
            _logger = logger;
        }
        public QualityClientsContainer[] RequestEbkClient(ClientSearchParams searchParams)
        {
            var serviceUrl = ConfigurationManager.AppSettings["ebk.ApiUri"] +
                         ConfigurationManager.AppSettings["ebk.SearchMethod"];
            if (!string.IsNullOrEmpty(searchParams.Gcif))
            {
                serviceUrl = serviceUrl + 
                    ConfigurationManager.AppSettings["ebk.SearchByGcifSuffix"] +
                    searchParams.Gcif;
            }
            else if (!string.IsNullOrEmpty(searchParams.Inn))
            {
                serviceUrl = serviceUrl + 
                    ConfigurationManager.AppSettings["ebk.SearchByInnSuffix"] +
                    searchParams.Inn;
            }
            else if (searchParams.BirthDate != null)
            {
                var bDate = searchParams.BirthDate.Value.ToString("yyyy-MM-dd");
                serviceUrl = serviceUrl + 
                    ConfigurationManager.AppSettings["ebk.SearchByBirthSuffix"] +
                    searchParams.FirstName + "/" +
                    searchParams.LastName + "/" +
                    bDate;
            }
            else
            {
                serviceUrl = serviceUrl + 
                    ConfigurationManager.AppSettings["ebk.SearchByDocSuffix"] +
                    searchParams.FirstName + "/" +
                    searchParams.LastName + "/" +
                    searchParams.DocSerial + "/" +
                    searchParams.DocNumber;
            }
            //serviceUrl = "http://localhost/barsroot/CDMService/TestThisShit";
            
            var request = (HttpWebRequest)WebRequest.Create(serviceUrl);
            request.Method = "GET";
            try
            {
                HttpWebResponse response = (HttpWebResponse) request.GetResponse();

                if (response.StatusCode == HttpStatusCode.OK)
                {
                    Stream responseStream = response.GetResponseStream();
                    string responseStr = new StreamReader(responseStream).ReadToEnd();

                    var reader = new StringReader(responseStr);
                    XmlSerializer ser = new XmlSerializer(typeof (EbkClients));
                    EbkClients clients = (EbkClients) ser.Deserialize(reader);
                    reader.Close();

                    if (clients.Status == "OK")
                    {
                        if (clients.QualityClient != null)
                        {
                            return clients.QualityClient.FindedClientsCards;
                        }
                        return new QualityClientsContainer[] {};
                    }
                    var err = string.Format("{0} Помилка пошуку картки клієнта он-лайн. <br />Помилка: {1}",
                        _logMessagePrefix, clients.Msg);
                    _logger.Error(err);
                    throw new Exception(err);
                }
                else
                {
                    var err =
                        string.Format("{0} Віддалений сервіс відхилив он-лайн запит на пошук картки. <br />СТАТУС: {1}",
                            _logMessagePrefix,
                            response.StatusDescription);
                    _logger.Error(err);
                    throw new Exception(err);
                }
            }
            catch (Exception e)
            {
                var err = string.Format("{0} Помилка роботи віддаленого сервісу ЕБК:  {1}", _logMessagePrefix, (e.InnerException != null ? e.InnerException.Message : e.Message));
                _logger.Error(err);
                throw new Exception(err + e.StackTrace);
            }
        }
    }
}