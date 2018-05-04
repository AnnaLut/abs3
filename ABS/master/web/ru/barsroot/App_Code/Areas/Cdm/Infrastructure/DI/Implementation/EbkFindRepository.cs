using Areas.Cdm.Models;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Core.Logger;
using BarsWeb.Models;
using Ninject;
using System;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class EbkFindRepository : IEbkFindRepository
    {
        protected const string _logMessagePrefix = "ЕБК.";
        [Inject]
        public IDbLogger Logger { get; set; }
        protected readonly CdmModel _entities;

        public EbkFindRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("CdmModel", "Cdm");
            _entities = new CdmModel(connectionStr);
        }
        public virtual QualityClientsContainer[] RequestEbkClient(ClientSearchParams searchParams, ErrorMessage errorMessage = null)
        {
            var serviceUrl = string.Empty;

            var maker = ConfigurationManager.AppSettings["ebk.UserName"];
            var kf = _entities.ExecuteStoreQuery<string>("select f_ourmfo from dual").SingleOrDefault();

            // ФО
            if (searchParams.CustomerType == "person")
            {
                serviceUrl = string.Format("{0}{1}?kf={2}&maker={3}", ConfigurationManager.AppSettings["ebk.ApiUri"], ConfigurationManager.AppSettings["ebk.SearchMethod"], kf, maker);

                // ?kf=352457&snFn=ОЛЕКСАНДРА&snLn=ЄРЕМЕНКО&bDay=24-11-2016
                if (searchParams.BirthDate != null)
                {
                    var bDate = searchParams.BirthDate.Value.ToString("dd-MM-yyyy");
                    serviceUrl += string.Format("&{0}={1}&{2}={3}&{4}={5}",
                        ConfigurationManager.AppSettings["ebk.SearchByBirthSuffix"],
                        bDate,
                        ConfigurationManager.AppSettings["ebk.SearchByFirstNameSuffix"],
                        searchParams.FirstName,
                        ConfigurationManager.AppSettings["ebk.SearchByLastNameSuffix"],
                        searchParams.LastName);
                }
                // ?kf={kf}&snFn={snFn}&snLn={snLn}&ser={ser}&numdoc={numdoc}
                if (searchParams.DocNumber != null)
                {
                    serviceUrl += string.Format("&{0}={1}&{2}={3}&{4}={5}",
                        ConfigurationManager.AppSettings["ebk.SearchByDocNumSuffix"],
                        searchParams.DocNumber,
                        ConfigurationManager.AppSettings["ebk.SearchByFirstNameSuffix"],
                        searchParams.FirstName,
                        ConfigurationManager.AppSettings["ebk.SearchByLastNameSuffix"],
                        searchParams.LastName);
                    if (!string.IsNullOrEmpty(searchParams.DocSerial))
                        serviceUrl += string.Format("&{0}={1}", ConfigurationManager.AppSettings["ebk.SearchByDocSerSuffix"],
                            searchParams.DocSerial);
                    if (!string.IsNullOrEmpty(searchParams.EddrId))
                        serviceUrl += string.Format("&{0}={1}", ConfigurationManager.AppSettings["ebk.SearchByEddrIdSuffix"],
                            searchParams.EddrId);
                }
            }
            // ФОП
            else if (searchParams.CustomerType == "personspd")
            {
                serviceUrl = string.Format("{0}{1}?kf={2}&maker={3}", ConfigurationManager.AppSettings["ebk.ApiUriPrivateEn"], ConfigurationManager.AppSettings["ebk.SearchMethodPrivateEn"], kf, maker);
                if (searchParams.FullName != null)
                    serviceUrl += string.Format("&{0}={1}", "fullName", searchParams.FullName);
                if (searchParams.FullNameInternational != null)
                    serviceUrl += string.Format("&{0}={1}", "fullNameInternational", searchParams.FullNameInternational);
                if (searchParams.DateOn != null)
                {
                    var dateOn = searchParams.DateOn.Value.ToString("yyyy-MM-dd");
                    serviceUrl += string.Format("&{0}={1}", "dateOn", dateOn);
                }
            }
            // ЮО
            else if (searchParams.CustomerType == "corp")
            {
                serviceUrl = string.Format("{0}{1}?kf={2}&maker={3}",
                    ConfigurationManager.AppSettings["ebk.ApiUriLegal"],
                    ConfigurationManager.AppSettings["ebk.SearchMethodLegal"], kf, maker);
                if (searchParams.FullName != null)
                    serviceUrl += string.Format("&{0}={1}", "fullName", searchParams.FullName);
                if (searchParams.FullNameInternational != null)
                    serviceUrl += string.Format("&{0}={1}", "fullNameInternational", searchParams.FullNameInternational);
                if (searchParams.DateOn != null)
                {
                    var dateOn = searchParams.DateOn.Value.ToString("yyyy-MM-dd");
                    serviceUrl += string.Format("&{0}={1}", "dateOn", dateOn);
                }
            }
            else
            {
                if(errorMessage != null)
                {
                    errorMessage.Message = "Не вдалося визначити тип клієнта для пошуку";
                }
                return null;
            }

            // ?kf={kf}&okpo={okpo}
            if (!string.IsNullOrEmpty(searchParams.Inn))
            {
                serviceUrl += string.Format("&{0}={1}", ConfigurationManager.AppSettings["ebk.SearchByInnSuffix"], searchParams.Inn);
            }
            // ?kf={kf}&gcif={gcif}
            else if (!string.IsNullOrEmpty(searchParams.Gcif))
            {
                serviceUrl += string.Format("&{0}={1}", ConfigurationManager.AppSettings["ebk.SearchByGcifSuffix"], searchParams.Gcif);
            }
            // ?kf={kf}&rnk={rnk}
            else if (searchParams.Rnk.HasValue)
            {
                serviceUrl += string.Format("&rnk={0}", searchParams.Rnk);
            }

            //if (!Directory.Exists(@"C:\Windows\Temp\Cdm\"))
            //    Directory.CreateDirectory(@"C:\Windows\Temp\Cdm\");
            //File.AppendAllText(@"C:\Windows\Temp\Cdm\search.log", serviceUrl + Environment.NewLine, Encoding.UTF8);

            var request = (HttpWebRequest)WebRequest.Create(serviceUrl);
            request.Method = "GET";
            try
            {
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();

                if (response.StatusCode == HttpStatusCode.OK)
                {
                    Stream responseStream = response.GetResponseStream();
                    string responseStr = new StreamReader(responseStream).ReadToEnd();

                    var reader = new StringReader(responseStr);
                    XmlSerializer ser = new XmlSerializer(typeof(EbkClients));
                    EbkClients clients = (EbkClients)ser.Deserialize(reader);
                    reader.Close();

                    if (clients.Status == "OK")
                    {
                        if (clients.QualityClient != null)
                        {
                            return clients.QualityClient.FindedClientsCards;
                        }
                        return new QualityClientsContainer[] { };
                    }
                    var err = string.Format("{0} Помилка пошуку картки клієнта он-лайн. <br />Помилка: {1}",
                        _logMessagePrefix, clients.Msg);
                    Logger.Error(err);

                    if(errorMessage != null)
                    {
                        errorMessage.Message = err;
                    }
                    return null;
                }
                else
                {
                    var err =
                        string.Format("{0} Віддалений сервіс відхилив он-лайн запит на пошук картки. <br />СТАТУС: {1}",
                            _logMessagePrefix,
                            response.StatusDescription);
                    Logger.Error(err);
                    if (errorMessage != null)
                    {
                        errorMessage.Message = err;
                    }
                    return null;
                }
            }
            catch (Exception e)
            {
                var err = string.Format("{0} Помилка роботи з віддаленим сервісом.", _logMessagePrefix);
                Logger.Error(err + " :" + e.Message);
                if (errorMessage != null)
                {
                    errorMessage.Message = err;
                }
                return null;
            }
        }
    }
}