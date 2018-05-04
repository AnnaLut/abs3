using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Cdm.Models.Transport.Individual;
using BarsWeb.Areas.Cdm.Models.Transport.Legal;
using BarsWeb.Areas.Cdm.Models.Transport.PrivateEn;
using Kendo.Mvc.Extensions;
using System;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation
{
    /// <summary>
    /// Summary description for EbkFindRepositoryV2
    /// </summary>
    public class EbkFindRepositoryV2:EbkFindRepository
    {
        protected readonly string DateStyle = "dd-MM-yyyy";

        public override QualityClientsContainer[] RequestEbkClient(ClientSearchParams searchParams, ErrorMessage errorMessage = null)
        {
            string serviceUrl;

            var maker = ConfigurationManager.AppSettings["ebk.UserName"];
            var kf = _entities.ExecuteStoreQuery<string>("select f_ourmfo from dual").SingleOrDefault();

            // ФО
            if (searchParams.CustomerType == "person")
            {
                serviceUrl = string.Format("{0}{1}?kf={2}&maker={3}",
                    ConfigurationManager.AppSettings["ebk.ApiUri"],
                    ConfigurationManager.AppSettings["ebk.SearchMethod.v2"], kf, maker);

                // ?kf=352457&snFn=ОЛЕКСАНДРА&snLn=ЄРЕМЕНКО&bDay=24-11-2016
                if (searchParams.BirthDate != null)
                {
                    var bDate = searchParams.BirthDate.Value.ToString(DateStyle);
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
                serviceUrl = string.Format("{0}{1}?kf={2}&maker={3}",
                    ConfigurationManager.AppSettings["ebk.ApiUriPrivateEn"],
                    ConfigurationManager.AppSettings["ebk.SearchMethodPrivateEn.v2"],
                    kf, maker);
                if (searchParams.FullName != null)
                    serviceUrl += string.Format("&{0}={1}",
                        ConfigurationManager.AppSettings["ebk.SearchByFullNameSuffix"],
                        searchParams.FullName);
                if (searchParams.FullNameInternational != null)
                    serviceUrl += string.Format("&{0}={1}",
                        ConfigurationManager.AppSettings["ebk.SearchByFullNameInternationalSuffix"],
                        searchParams.FullNameInternational);
                if (searchParams.DateOn != null)
                {
                    var dateOn = searchParams.DateOn.Value.ToString(DateStyle);
                    serviceUrl += string.Format("&{0}={1}",
                        ConfigurationManager.AppSettings["ebk.SearchByDateOnSuffix"],
                        dateOn);
                }
            }
            // ЮО
            else if (searchParams.CustomerType == "corp")
            {
                serviceUrl = string.Format("{0}{1}?kf={2}&maker={3}",
                    ConfigurationManager.AppSettings["ebk.ApiUriLegal"],
                    ConfigurationManager.AppSettings["ebk.SearchMethodLegal.v2"], kf, maker);
                if (searchParams.FullName != null)
                    serviceUrl += string.Format("&{0}={1}",
                        ConfigurationManager.AppSettings["ebk.SearchByFullNameSuffix"],
                        searchParams.FullName);
                if (searchParams.FullNameInternational != null)
                    serviceUrl += string.Format("&{0}={1}",
                        ConfigurationManager.AppSettings["ebk.SearchByFullNameInternationalSuffix"],
                        searchParams.FullNameInternational);
                if (searchParams.DateOn != null)
                {
                    var dateOn = searchParams.DateOn.Value.ToString(DateStyle);
                    serviceUrl += string.Format("&{0}={1}",
                        ConfigurationManager.AppSettings["ebk.SearchByDateOnSuffix"],
                        dateOn);
                }
            }
            else
            {
                if (errorMessage != null)
                {
                    errorMessage.Message = "Не вдалося визначити тип клієнта для пошуку";
                }
                return null;
            }

            // ?kf={kf}&okpo={okpo}
            if (!string.IsNullOrEmpty(searchParams.Inn))
            {
                serviceUrl += string.Format("&{0}={1}",
                    ConfigurationManager.AppSettings["ebk.SearchByInnSuffix"],
                    searchParams.Inn);
            }
            // ?kf={kf}&gcif={gcif}
            else if (!string.IsNullOrEmpty(searchParams.Gcif))
            {
                serviceUrl += string.Format("&{0}={1}",
                    ConfigurationManager.AppSettings["ebk.SearchByGcifSuffix"],
                    searchParams.Gcif);
            }
            // ?kf={kf}&rnk={rnk}
            else if (searchParams.Rnk.HasValue)
            {
                serviceUrl += string.Format("&{0}={1}",
                    ConfigurationManager.AppSettings["ebk.SearchByRnkSuffix"],
                    searchParams.Rnk);
            }

            //if (!Directory.Exists(@"C:\Windows\Temp\Cdm\"))
            //    Directory.CreateDirectory(@"C:\Windows\Temp\Cdm\");
            //File.AppendAllText(@"C:\Windows\Temp\Cdm\search.log", serviceUrl + Environment.NewLine, Encoding.UTF8);

            var request = (HttpWebRequest)WebRequest.Create(serviceUrl);
            request.Method = "GET";
            try
            {
                HttpWebResponse httpResponse = (HttpWebResponse)request.GetResponse();

                string responseStr;

                using (Stream responseStream = httpResponse.GetResponseStream())
                {
                    responseStr = new StreamReader(responseStream).ReadToEnd();
                    Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", _logMessagePrefix,
                        responseStr));
                }

                if (httpResponse.StatusCode == HttpStatusCode.OK)
                {
                    ResponseV2 ebkResponse = responseStr.XmlDeserialize<ResponseV2>(Encoding.UTF8);

                    if (ResponseStatus.OK.ToString()==ebkResponse.Status)
                    {
                        if (null!=ebkResponse.Cards)
                        {
                            var cards = ebkResponse.Cards;
                            QualityClientsContainer[] qcContainer = cards.Select(MapCardDataV2).ToArray();
                            return qcContainer;
                        }
                    }

                    var err = string.Format("{0} Помилка пошуку картки клієнта он-лайн.",
                        _logMessagePrefix);
                    Logger.Error(err);

                    if (errorMessage != null)
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
                            httpResponse.StatusDescription);
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

        private static QualityClientsContainer MapCardDataV2(CardDataV2 card)
        {
            var qcc = new QualityClientsContainer();
            if (null != card.Person)
            {
                if (card.Person is IndividualPersonV2)
                {
                    qcc.ClientCard = card.ToBufClientData();
                }
                else if (card.Person is LegalPersonV2)
                {
                    qcc.ClientLegalCard = card.ToLegalPerson();
                }
                else if (card.Person is PrivateEntrepreneurV2)
                {
                    qcc.ClientPrivateEnCard = card.ToPrivateEnPerson();
                }
            }
            return qcc;
        }
    }
}