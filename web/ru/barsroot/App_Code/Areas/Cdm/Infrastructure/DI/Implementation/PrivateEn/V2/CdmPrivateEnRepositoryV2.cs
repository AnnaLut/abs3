using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Xml;
using System.Xml.Serialization;
using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Cdm.Models.Transport.PrivateEn;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Enums;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cdm.Infrastructure.DI.Implementation.PrivateEn
{
    /// <summary>
    /// Summary description for CmlPrivateEnRepositoryV2
    /// </summary>
    public class CdmPrivateEnRepositoryV2 : CdmPrivateEnRepository
    {
        protected const PersonType PrivateEntrepreneur = (PersonType) 2;
        protected CultureInfo Culture = CultureInfo.InvariantCulture;


        public override int SavePersonCardsFast(RequestFromEbkV2 request, int allowedCardsPerRequest)
        {
            UserLogin();

            if (request.Entries.Count <= allowedCardsPerRequest)
                return InternalSavePersonCards(request);

            var errorMsg =
                string.Format(
                    "{0} Отримана кількість карток у одному пакеті cтановить {1} і перевищує допустиму у {2} шт.",
                    _logMessagePrefix, request.Entries.Count, allowedCardsPerRequest);
            Logger.Error(errorMsg);
            throw new Exception(errorMsg);
        }

        public override decimal PackAndSendClientCards(int? cardsCount, int packSize, string kf)
        {
            UserLogin();
            Logger.Info(string.Format("{0} Розпочато надсилання карток клієнтів. Розмір пакету - {1}, KF - {2}.",
                _logMessagePrefix, packSize, kf));

            var apiUrl = ConfigurationManager.AppSettings["ebk.ApiUriPrivateEn"] +
                         ConfigurationManager.AppSettings["ebk.LoadCardsMethodPrivateEn.v2"];
            var xml = string.Empty;

            try
            {
                List<PrivateEnData> packPlaneBody = QueueGetCards(packSize, kf);
                if (!packPlaneBody.Any())
                    throw new ArgumentException("База даних повернула порожню чергу карток на відправку.");

                // мапим плоский клас на иерархию              
                var packBody = packPlaneBody.Select(MapPrivateEnData).ToList();

                //дополним каждую карточку информацие о привязанных особах
                packBody.ForEach(lp => lp.RelatedPersons = ExtractRelatedPersonList(lp.Rnk));

                //получаем параметры пакета
                decimal packNum = GetNextPackNumber();

                //строим пакет
                var package = new PrivateEnCards(kf, packNum.ToString(Culture), HomeRepo.GetUserParam().USER_FULLNAME,
                    packBody);

                xml = package.XmlSerialize(Encoding.UTF8);
                Logger.Info(String.Format("{0} Xml до надсилання: -={1}=-", _logMessagePrefix, xml));

                //отправляем данные в ЕБК
                byte[] bytes = Encoding.UTF8.GetBytes(xml);
                HttpWebResponse httpResponse = MakeRequest(apiUrl, bytes, "POST");

                string responseStr;
                using (Stream responseStream = httpResponse.GetResponseStream())
                {
                    responseStr = new StreamReader(responseStream, Encoding.UTF8).ReadToEnd();
                    Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", _logMessagePrefix,
                        responseStr));
                }

                if (httpResponse.StatusCode == HttpStatusCode.OK)
                {
                    //записываем результаты отправки
                    packBody.ForEach(c => QueueRemoveCard(c.Rnk, c.Kf));

                    Logger.Info(string.Format("{0} Успішно надіслано пакет карток розміром {1} шт.", _logMessagePrefix,
                        packSize));
                }
                else
                {
                    Logger.Error(string.Format("{0} Отримано помилковий код: {1}", _logMessagePrefix,
                        httpResponse.StatusCode));
                }
            }
            catch (Exception ex)
            {
                Logger.Error(string.Format(
                    "{0} Помилка пакетної доставки. {1} --- {2}",
                    _logMessagePrefix,
                    (ex.InnerException != null ? ex.InnerException.Message : ex.Message),
                    ex.StackTrace
                ));
                Logger.Error(string.Format("{0} - {1}", _logMessagePrefix, xml));
            }

            return packSize;
        }

        public override ActionStatus PackAndSendSingleCard(decimal rnk)
        {
            var result = new ActionStatus(ActionStatusCode.Ok);
            var checks = new List<Analytics>();

            Logger.Info(string.Format("{0} Ініційовано он-лайн запит по РНК {1}.", _logMessagePrefix, rnk));

            var apiUrl = ConfigurationManager.AppSettings["ebk.ApiUriPrivateEn"] +
                         ConfigurationManager.AppSettings["ebk.LoadCardMethodPrivateEn.v2"];

            string err;

            try
            {
                PrivateEnData plainCard = QueueGetCard(rnk);
                //если карточки с указанным РНК почемуто в очереди нет - добавим ее туда
                if (null == plainCard)
                {
                    QueuePutCard(rnk);
                    plainCard = QueueGetCard(rnk);
                }

                if (null == plainCard)
                {
                    err = string.Format("{0} Не знайдено картку клієнта з РНК={1} у черзі на відправку до ЄБК.",
                        _logMessagePrefix, rnk);
                    result.Status = ActionStatusCode.Error;
                    result.Message = err;
                    Logger.Error(err);
                    throw new Exception(err);
                }

                PrivateEnPerson card = MapPrivateEnData(plainCard);

                card.RelatedPersons = ExtractRelatedPersonList(card.Rnk);

                decimal packNum = GetNextPackNumber();

                var simpleCard = new PrivateEnCard(card.Kf, packNum.ToString(Culture),
                    HomeRepo.GetUserParam().USER_FULLNAME,
                    card);

                string xml = simpleCard.XmlSerialize(Encoding.UTF8);
                Logger.Info(String.Format("{0} Xml до надсилання: -={1}=-", _logMessagePrefix, xml));

                //отправляем данные в ЕБК
                var bytes = Encoding.UTF8.GetBytes(xml);
                HttpWebResponse httpResponse = MakeRequest(apiUrl, bytes, "PUT");

                string responseStr;
                using (Stream responseStream = httpResponse.GetResponseStream())
                {
                    responseStr = new StreamReader(responseStream, Encoding.UTF8).ReadToEnd();
                    Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", _logMessagePrefix,
                        responseStr));
                }

                if (HttpStatusCode.OK == httpResponse.StatusCode)
                {
                    ResponseV2 ebkResponse = responseStr.XmlDeserialize<ResponseV2>(Encoding.UTF8);

                    if (ResponseStatus.OK.ToString() == ebkResponse.Status)
                    {
                        if (null != ebkResponse.Cards && ebkResponse.Cards.Any() &&
                            !string.IsNullOrEmpty(ebkResponse.Cards.First().Gcif))
                        {
                            //сохраним GCIF пришедший в ответ на он-лайн запрос
                            SaveGcif(new MasterCard
                            {
                                Gcif = ebkResponse.Cards.First().Gcif,
                                Kf = ebkResponse.Cards.First().Kf.ToString(),
                                Rnk = ebkResponse.Cards.First().Rnk.ToString(),
                                SlaveClients = new SlaveClient[0]
                            }, "on-line");
                        }

                        InternalSavePersonCards(AsEbkRequest(ebkResponse));
                        QueueRemoveCard(card.Rnk, card.Kf);

                        result.Message = "Дані відправлені і отримано рекомендації або дублікати по клієнту.";
                        Logger.Info(string.Format(
                            "{0} Отримано рекомендації або дублікати по клієнту з РНК={1} он-лайн.", _logMessagePrefix,
                            rnk));
                    }
                    else if (ResponseStatus.ERROR.ToString() == ebkResponse.Status)
                    {
                        if (null != ebkResponse.Cards && ebkResponse.Cards.Any())
                        {
                            ClientAnalysisV2 cardAnalysis = ebkResponse.Cards.First().CardAnalysis;
                            if (null != cardAnalysis)
                            {
                                checks.AddRange(cardAnalysis.Attributes.Select(attribute => new Analytics
                                {
                                    Descr = attribute.Descr,
                                    Name = attribute.Name,
                                    Quality = attribute.Quality,
                                    RecommendValue = attribute.RecommendValue,
                                    Value = attribute.Value
                                }));
                            }
                        }

                        result.Data = new
                        {
                            checks,
                            status = "Відмова у створенні картки",
                            dupes = (null != ebkResponse.Cards)
                                ? ebkResponse.Cards.First().Duplicates
                                : new List<DuplicatesV2>()
                        };
                        if (checks.Count > 0 || null != ebkResponse.Cards && ebkResponse.Cards.Any() &&
                            null != ebkResponse.Cards.First().Duplicates && ebkResponse.Cards.First().Duplicates.Any())
                        {
                            result.Status = ActionStatusCode.Error;
                            result.Message = "Отримано рекомендації або дублікати по клієнту.";
                        }
                        else
                        {
                            result.Status = ActionStatusCode.Error;
                            result.Message =
                                string.Format("Сервіс відхилив запит. Причина: {0}", ebkResponse.Message);
                        }

                        Logger.Info(string.Format(
                            "{0} Сервіс відхилив запит по клієнту з РНК={1} он-лайн.",
                            _logMessagePrefix, rnk));
                    }
                }
                else
                {
                    err = string.Format(
                        "{0} Віддалений сервіс відхилив он-лайн запит на перевірку картки з РНК={2}: <br />СТАТУС: {1}",
                        _logMessagePrefix, httpResponse.StatusDescription, rnk);
                    Logger.Error(err);
                    throw new Exception(err);
                }
            }
            catch (Exception e)
            {
                err = string.Format("{0} Невідома помилка надсилання картки РНК={2} онлайн:  {1}", _logMessagePrefix,
                    (e.InnerException != null ? e.InnerException.Message : e.Message), rnk);
                Logger.Error(err);
                throw new Exception(string.Format("{0} Невідома помилка надсилання картки РНК={1} ", _logMessagePrefix,
                    rnk));
            }

            return result;
        }

        public override string SendCloseCard(string kf, decimal rnk, string dateOff)
        {
            if (null == kf && null == dateOff)
            {
                kf = _entities
                    .ExecuteStoreQuery<string>("SELECT kf FROM customer where rnk = " + Convert.ToString(rnk), null)
                    .FirstOrDefault().ToString();
                dateOff = _entities.ExecuteStoreQuery<DateTime>("SELECT bankdate FROM dual", null).FirstOrDefault()
                    .ToString("yyyy-MM-dd");
            }

            UserLogin();

            var maker = ConfigurationManager.AppSettings["ebk.UserName"];
            var serviceUrl = ConfigurationManager.AppSettings["ebk.ApiUriPrivateEn"] +
                             ConfigurationManager.AppSettings["ebk.CloseMethodPrivateEn.v2"] + "?kf=" + kf + "&rnk=" +
                             rnk + "&dateOff=" + dateOff + "&maker=" + maker;

            var status = "ERROR";
            string err;
            try
            {
                HttpWebResponse httpResponse = MakeRequest(serviceUrl, null, "PUT");

                string responseStr;
                using (Stream responseStream = httpResponse.GetResponseStream())
                {
                    responseStr = new StreamReader(responseStream, Encoding.UTF8).ReadToEnd();
                    Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", _logMessagePrefix,
                        responseStr));
                }

                if (HttpStatusCode.OK == httpResponse.StatusCode)
                {
                    ResponseV2 ebkResponse = responseStr.XmlDeserialize<ResponseV2>(Encoding.UTF8);

                    if (ResponseStatus.OK.ToString() != ebkResponse.Status)
                    {
                        err = string.Format("{0} Помилка закриття картки клієнта он-лайн. <br />Помилка: {1}",
                            _logMessagePrefix, ebkResponse.Message);
                        Logger.Error(err);
                        return status;
                    }

                    Logger.Info(string.Format("{0} Віддалений сервіс успішно виконав команду закриття клієнта RNK={1}",
                        _logMessagePrefix, rnk));
                    status = "OK";

                    return status;
                }
            }
            catch (Exception ex)
            {
                err = string.Format("{0} Невідома помилка закриття картки РНК={2}  онлайн:  {1}", _logMessagePrefix,
                    (ex.InnerException != null ? ex.InnerException.Message : ex.Message), rnk);
                Logger.Error(err);
                return status;
            }

            return status;
        }

        public override string SynchronizeCard(string kf, decimal rnk)
        {
            UserLogin();

            string serviceUrl = ConfigurationManager.AppSettings["ebk.ApiUriPrivateEn"] +
                                ConfigurationManager.AppSettings["ebk.SyncCardMethodPrivateEn.v2"] + "?kf=" + kf +
                                "&rnk=" + rnk;
            var status = "ERROR";
            string error;
            try
            {
                HttpWebResponse httpResponse = MakeRequest(serviceUrl, null, "GET");

                string responseStr;
                using (Stream responseStream = httpResponse.GetResponseStream())
                {
                    responseStr = new StreamReader(responseStream, Encoding.UTF8).ReadToEnd();
                    Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", _logMessagePrefix,
                        responseStr));
                }

                if (HttpStatusCode.OK == httpResponse.StatusCode)
                {
                    ResponseV2 ebkResponse = responseStr.XmlDeserialize<ResponseV2>(Encoding.UTF8);

                    if (ResponseStatus.OK.ToString() != ebkResponse.Status)
                    {
                        error = string.Format(
                            "{0} Помилка синхронізації картки клієнта ФОП з віддаленим сервісом ЄБК. <br />Помилка: {1}",
                            _logMessagePrefix, ebkResponse.Message);
                        Logger.Error(error);
                    }
                    else
                    {
                        InternalSavePersonCards(AsEbkRequest(ebkResponse));

                        Logger.Info(string.Format(
                            "{0} Віддалений сервіс ЄБК успішно виконав команду синхронізації картки клієнта ФОП з RNK={1}",
                            _logMessagePrefix, rnk));
                        status = "OK";
                    }
                }
                else
                {
                    error = string.Format(
                        "{0} Помилка синхронізації картки клієнта ФОП з віддаленим сервісом ЄБК. <br />Помилка: {1}",
                        _logMessagePrefix, httpResponse.StatusCode);
                    Logger.Error(error);
                }

                return status;
            }
            catch (Exception ex)
            {
                error = string.Format("{0} Невідома помилка синхронізації картки ФОП РНК={2}  онлайн:  {1}",
                    _logMessagePrefix,
                    (ex.InnerException != null ? ex.InnerException.Message : ex.Message), rnk);
                Logger.Error(error);
                return status;
            }
        }

        public override void SaveGcifs(ICard[] cards, string batchId)
        {
            UserLogin();
            var cardsArr = cards as CardDataV2[];
            if (null!=cardsArr)
            {
                foreach (var card in cardsArr)
                {
                    if (null!=card.Gcif)
                    {
                        SaveGcif(card, batchId);
                    }
                }
            }
        }

        public override void SaveGcif(ICard card, string batchId)
        {
            List<EbkSlaveClient> slaveClients=new List<EbkSlaveClient>();
            var masterCard = card as CardDataV2;
            if (null==masterCard) return;

            if (null!=masterCard.Duplicates && masterCard.Duplicates.Any())
            {
                slaveClients = masterCard.Duplicates.Select(c => new EbkSlaveClient()
                {
                    Kf = c.Kf,
                    Rnk = c.Rnk
                }).ToList();
            }

            var sqlParams = new OracleParameter[]{
                new OracleParameter("p_batchId", OracleDbType.Varchar2)
                {
                    Value = (batchId)
                },
                new OracleParameter("p_mod_tms", OracleDbType.TimeStampTZ)
                {
                    Value = (masterCard.ModificationTimestamp)
                }, 
                new OracleParameter("p_kf", OracleDbType.Varchar2)
                {
                    Value = (masterCard.Kf)
                },
                new OracleParameter("p_rnk", OracleDbType.Decimal)
                {
                    Value = (masterCard.Rnk)
                },
                new OracleParameter("p_cust_tp", OracleDbType.Varchar2)
                {
                    Value = PrivateEntrepreneur.ToString()
                }, 
                new OracleParameter("p_gcif", OracleDbType.Varchar2)
                {
                    Value = (masterCard.Gcif)
                },
                new OracleParameter("p_slave_client_ebk", OracleDbType.Array)
                {
                    UdtTypeName = "BARS.T_SLAVE_CLIENT_EBK",
                    Value = slaveClients.ToArray()
                }
            };
            _entities.ExecuteStoreCommand(@"begin 
                BARS.EBK_REQUEST_UTL.REQUEST_GCIF_MASS
                        ( p_batchId
                        , p_mod_tms
                        , p_kf
                        , p_rnk
                        , p_cust_tp
                        , p_gcif
                        , p_slave_client_ebk );
                end;", sqlParams);
        }

        public override void DeleteGcifs(string[] gcifs)
        {
            foreach (var gcif in gcifs)
            {
                DeleteGcif(gcif);
            }
        }

        public override void DeleteGcif(string gcif)
        {
            _entities.ExecuteStoreCommand(
                "begin BARS.EBK_REQUEST_UTL.REQUEST_DEL_GCIF(p_gcif => :p_gcif); end; ",
                new OracleParameter("p_gcif", OracleDbType.Varchar2)
                {
                    Value = (gcif)
                }
            );

        }


        private RequestFromEbkV2 AsEbkRequest(ResponseV2 response)
        {
            return new RequestFromEbkV2
            {
                BatchId = "-1",
                BatchTimestamp = DateTime.Now,
                Entries = new List<ResponseV2> {response}
            };
        }

        private void QueuePutCard(decimal rnk)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_rnk", OracleDbType.Decimal) {Value = rnk}
            };

            _entities.ExecuteStoreCommand(
                "begin bars.ebk_wforms_utl.add_rnk_queue (:p_rnk); end;",
                sqlParams);
        }

        private PrivateEnData QueueGetCard(decimal rnk)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_rnk", OracleDbType.Decimal) {Value = rnk}
            };

            return _entities.ExecuteStoreQuery<PrivateEnData>(
                    "select * from BARS.V_EBKC_QUEUE_UPDCARD_PRIVATE where CUST_ID = :p_rnk",
                    sqlParams)
                .SingleOrDefault();
        }

        private void QueueRemoveCard(decimal? rnk, string kf)
        {
            RemoveCardFromQueue(rnk, kf);
        }

        private HttpWebResponse MakeRequest(string apiUrl, byte[] bytes, string methodName)
        {
            var request = WebRequest.Create(apiUrl);
            request.Method = methodName.ToUpper();
            if (null != bytes)
            {
                request.ContentType = "application/xml;charset='utf-8'";
                request.ContentLength = bytes.Length;
                using (Stream requestStream = request.GetRequestStream())
                {
                    requestStream.Write(bytes, 0, bytes.Length);
                }
            }

            var response = (HttpWebResponse) request.GetResponse();
            return response;
        }

        private List<PrivateEnData> QueueGetCards(int packSize, string kf)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_Size", OracleDbType.Int16)
                {
                    Value = packSize
                },
                new OracleParameter("p_kf", OracleDbType.Varchar2)
                {
                    Value = kf
                }
            };

            return _entities.ExecuteStoreQuery<PrivateEnData>(
                    "select * from v_ebkc_queue_updcard_private where rownum <= :p_Size and kf = :p_kf ",
                    sqlParams)
                .ToList();
        }

        private int InternalSavePersonCards(RequestFromEbkV2 request)
        {
            var cardsCount = 0;
            bool isModifiedCard;
            object[] sqlParams;

            foreach (var entry in request.Entries)
            {
                if (entry.Status != ResponseStatus.OK.ToString()) continue;
                if (null == entry.Cards) continue;

                foreach (var card in entry.Cards)
                {
                    isModifiedCard = false;

                    if (null != card.CardAnalysis)
                    {

                        var checks = new List<Analytics>();
                        checks.AddRange(card.CardAnalysis.Attributes.Select(attribute => new Analytics
                        {
                            Descr = attribute.Descr,
                            Name = attribute.Name,
                            Quality = attribute.Quality,
                            RecommendValue = attribute.RecommendValue,
                            Value = attribute.Value
                        }));

                        sqlParams = new object[]
                        {
                            new OracleParameter(parameterName: "p_batchId", oraType: OracleDbType.Varchar2)
                            {
                                Value = request.BatchId
                            },
                            new OracleParameter(parameterName: "p_mod_tms", oraType: OracleDbType.TimeStampTZ)
                            {
                                Value = card.ModificationTimestamp
                            },
                            new OracleParameter(parameterName: "p_kf",
                                oraType: OracleDbType.Varchar2) {Value = card.Kf},
                            new OracleParameter(parameterName: "p_rnk", oraType: OracleDbType.Decimal)
                            {
                                Value = card.Rnk
                            },
                            new OracleParameter(parameterName: "p_cust_tp", oraType: OracleDbType.Varchar2)
                            {
                                Value = PrivateEntrepreneur.ToString()
                            },
                            new OracleParameter(parameterName: "p_anls_quality", oraType: OracleDbType.Decimal)
                            {
                                Value = card.CardAnalysis.SummaryQuality
                            },
                            new OracleParameter(parameterName: "p_defaultGroupQuality", oraType: OracleDbType.Decimal)
                            {
                                Value = card.CardAnalysis.DefaultQuality
                            },
                            new OracleParameter(parameterName: "p_tab_attr", type: OracleDbType.Array,
                                direction: ParameterDirection.Input)
                            {
                                UdtTypeName = "BARS.T_REC_EBK",
                                Value = checks.ToArray()
                            }
                        };

                        _entities.ExecuteStoreCommand(@"begin 
                                    BARS.EBK_REQUEST_UTL.REQUEST_UPDATECARD_MASS(
                                           :p_batchId
                                         , :p_mod_tms
                                         , :p_kf
                                         , :p_rnk
                                         , :p_cust_tp
                                         , :p_anls_quality
                                         , :p_defaultGroupQuality
                                         , :p_tab_attr);
                                    end;", sqlParams);

                        isModifiedCard = true;
                    }

                    var gcif = card.MasterGcif ?? card.Gcif;

                    if (!string.IsNullOrWhiteSpace(gcif))
                    {
                        sqlParams = new object[]
                        {
                            new OracleParameter(parameterName: "p_batchId", oraType: OracleDbType.Varchar2)
                            {
                                Value = request.BatchId
                            },
                            new OracleParameter(parameterName: "p_mod_tms", oraType: OracleDbType.TimeStampTZ)
                            {
                                Value = card.ModificationTimestamp
                            },
                            new OracleParameter(parameterName: "p_kf",
                                oraType: OracleDbType.Varchar2) {Value = card.Kf},
                            new OracleParameter(parameterName: "p_rnk", oraType: OracleDbType.Decimal)
                            {
                                Value = card.Rnk
                            },
                            new OracleParameter(parameterName: "p_cust_tp", oraType: OracleDbType.Varchar2)
                            {
                                Value = PrivateEntrepreneur.ToString()
                            },
                            new OracleParameter(parameterName: "p_gcif", oraType: OracleDbType.Varchar2)
                            {
                                Value = gcif
                            },
                            new OracleParameter(parameterName: "p_slave_client_ebk", type: OracleDbType.Array,
                                direction: ParameterDirection.Input)
                            {
                                UdtTypeName = "BARS.T_SLAVE_CLIENT_EBK",
                                Value = card.Duplicates.ToArray()
                            }
                        };

                        _entities.ExecuteStoreCommand(@"begin
                                   BARS.EBK_REQUEST_UTL.REQUEST_GCIF_MASS(
                                          :p_batchId          
                                        , :p_mod_tms          
                                        , :p_kf               
                                        , :p_rnk
                                        , :p_cust_tp
                                        , :p_gcif             
                                        , :p_slave_client_ebk);
                                     end;", sqlParams);

                        isModifiedCard = true;
                    }

                    if (isModifiedCard)
                    {
                        ++cardsCount;
                    }
                }
            }

            return cardsCount;
        }
    }
}