﻿using System;
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
using BarsWeb.Areas.Cdm.Models.Transport.Individual;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Enums;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation.Individual
{
    /// <summary>
    /// Summary description for CdmRepositoryV3
    /// </summary>
    public class CdmRepositoryV2 : CdmRepository
    {
        protected const PersonType IndividualPerson = 0;
        protected CultureInfo Culture = CultureInfo.InvariantCulture;

        protected override string LogMessagePrefix
        {
            get { return base.LogMessagePrefix + "v2"; }
        }

        public override int SavePersonCardsFast(RequestFromEbkV2 request, int allowedCardsPerRequest)
        {
            UserLogin();

            if (request.Entries.Count <= allowedCardsPerRequest)
                return InternalSavePersonCards(request);

            var errorMsg = string.Format("{0} Отримана кількість карток у одному пакеті cтановить {1} і перевищує допустиму у {2} шт.", LogMessagePrefix, request.Entries.Count, allowedCardsPerRequest);
            Logger.Error(errorMsg);
            throw new Exception(errorMsg);
        }

        public override decimal PackAndSendClientCards(int? cardsCount, int packSize, string kf)
        {
            EbkStatusCode resultCode = EbkStatusCode.Ok; // Everything is ok
            UserLogin();
            Logger.Info(string.Format("{0} Розпочато надсилання карток клієнтів. Розмір пакету - {1}, KF - {2}.",
                LogMessagePrefix, packSize, kf));

            var apiUrl = ConfigurationManager.AppSettings["ebk.ApiUri"] +
                ConfigurationManager.AppSettings["ebk.LoadCardsMethod.v2"];
            var xml = string.Empty;

            try
            {
                List<PersonData> packPlaneBody = QueueGetCards(packSize, kf);
                if (!packPlaneBody.Any())
                    throw new ArgumentException("База даних повернула порожню чергу карток на відправку.");

                // мапим плоский класс на иерархию
                var packBody = packPlaneBody.Select(MapPersonData).ToList();

                // дополняем каждую карточку информацией о привязанных особах
                packBody.ForEach(c => c.RelatedPerson = ExtractRelatedPersonList(c.Rnk));

                // получаем параметры пакета
                decimal packNum = GetNextPackNumber();

                // строим пакет
                var package = new Card(kf, packNum.ToString(Culture), HomeRepo.GetUserParam().USER_FULLNAME, packBody);

                xml = package.XmlSerialize(Encoding.UTF8);

                string httpVerb = "POST";
                Logger.Info(String.Format("{0} Метод: {1}, URL: {2}, Xml до надсилання: -={3}=-", LogMessagePrefix, httpVerb, apiUrl, xml));

                // отправляем данные в ЕБК
                byte[] bytes = Encoding.UTF8.GetBytes(xml);
                HttpWebResponse httpResponse = MakeRequest(apiUrl, bytes, "POST");

                string responseStr;
                using (Stream responseStream = httpResponse.GetResponseStream())
                {
                    responseStr = new StreamReader(responseStream, Encoding.UTF8).ReadToEnd();
                    Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", LogMessagePrefix,
                        responseStr));
                }

                if (httpResponse.StatusCode == HttpStatusCode.OK)
                {
                    //записываем результаты отправки
                    packBody.ForEach(c => QueueRemoveCard(c.Rnk, c.Kf));

                    Logger.Info(string.Format("{0} Успішно надіслано пакет карток розміром {1} шт.", LogMessagePrefix, packSize));
                }
                else
                {
                    Logger.Error(string.Format("{0} Отримано помилковий код: {1}", LogMessagePrefix, httpResponse.StatusCode));
                    resultCode = EbkStatusCode.RemoteErrorFromEbk;
                }
            }
            catch (OracleException ex)
            {
                resultCode = EbkStatusCode.DbError;

                Logger.Error(string.Format(
                    "{0} Помилка пакетної доставки. {1} --- {2}",
                    LogMessagePrefix,
                    (ex.InnerException != null ? ex.InnerException.Message : ex.Message),
                    ex.StackTrace
                ));
                Logger.Error(string.Format("{0} - {1}", LogMessagePrefix, xml));
            }
            catch (Exception ex)
            {
                resultCode = EbkStatusCode.OtherError;

                Logger.Error(string.Format(
                    "{0} Помилка пакетної доставки. {1} --- {2}",
                    LogMessagePrefix,
                    (ex.InnerException != null ? ex.InnerException.Message : ex.Message),
                    ex.StackTrace
                ));
                Logger.Error(string.Format("{0} - {1}", LogMessagePrefix, xml));
            }

            return (int)resultCode;
        }

        public override ActionStatus PackAndSendSingleCard(decimal rnk)
        {
            var result = new ActionStatus(ActionStatusCode.Ok);
            var checks = new List<Analytics>();

            Logger.Info(string.Format("{0} Ініційовано он-лайн запит по РНК {1}.", LogMessagePrefix, rnk));

            string apiUrl = ConfigurationManager.AppSettings["ebk.ApiUri"] +
                            ConfigurationManager.AppSettings["ebk.LoadCardMethod.v2"];
            string err;

            try
            {
                PersonData plainCard = QueueGetCard(rnk);
                //если карточки с указанным РНК почемуто в очереди нет - добавим ее туда
                if (null == plainCard)
                {
                    QueuePutCard(rnk);
                    plainCard = QueueGetCard(rnk);
                }
                if (null == plainCard)
                {
                    err = string.Format("{0} Не знайдено картку клієнта з РНК={1} у черзі на відправку до ЄБК.",
                        LogMessagePrefix, rnk);
                    result.Status = ActionStatusCode.Error;
                    result.Message = err;
                    Logger.Error(err);
                    throw new Exception(err);
                }

                BufClientData card = MapPersonData(plainCard);

                card.RelatedPerson = ExtractRelatedPersonList(card.Rnk);

                decimal packNum = GetNextPackNumber();

                var simpleCard =
                    new SimpleCard(card.Kf, packNum.ToString(Culture), HomeRepo.GetUserParam().USER_FULLNAME, card);

                string xml = simpleCard.XmlSerialize(Encoding.UTF8);
                Logger.Info(String.Format("{0} Xml до надсилання: -={1}=-", LogMessagePrefix, xml));


                // отправляем данные в ЕБК
                var bytes = Encoding.UTF8.GetBytes(xml);
                HttpWebResponse httpResponse = MakeRequest(apiUrl, bytes, "PUT");

                string responseStr;
                using (Stream responseStream = httpResponse.GetResponseStream())
                {
                    responseStr = new StreamReader(responseStream, Encoding.UTF8).ReadToEnd();
                    Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", LogMessagePrefix,
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
                            "{0} Отримано рекомендації або дублікати по клієнту з РНК={1} он-лайн.", LogMessagePrefix,
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
                        if (checks.Count > 0 ||
                            null != ebkResponse.Cards && null != ebkResponse.Cards.First().Duplicates &&
                            ebkResponse.Cards.First().Duplicates.Any())
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
                        Logger.Info(
                            string.Format("{0} Сервіс відхилив запит по клієнту з РНК={1} он-лайн.",
                                LogMessagePrefix, rnk));
                    }
                }
                else
                {
                    err = string.Format(
                        "{0} Віддалений сервіс відхилив он-лайн запит на перевірку картки з РНК={2}: <br />СТАТУС: {1}",
                        LogMessagePrefix, httpResponse.StatusDescription, rnk);
                    Logger.Error(err);
                    throw new Exception(err);
                }
            }
            catch (Exception e)
            {
                err = string.Format("{0} Невідома помилка надсилання картки РНК={2} онлайн:  {1}",
                    LogMessagePrefix, (e.InnerException != null ? e.InnerException.Message : e.Message), rnk);
                Logger.Error(err);
                throw new Exception(string.Format("{0} Невідома помилка надсилання картки РНК={1} ",
                    LogMessagePrefix, rnk));
            }
            return result;
        }

        public override string SendCloseCard(string kf, decimal rnk, string dateOff)
        {
            if (kf == null && dateOff == null)
            {
                kf = _entities
                    .ExecuteStoreQuery<string>("SELECT kf FROM customer where rnk = " + Convert.ToString(rnk, Culture), null)
                    .FirstOrDefault();
                dateOff = _entities.ExecuteStoreQuery<DateTime>("SELECT bankdate FROM dual", null).FirstOrDefault()
                    .ToString("yyyy-MM-dd");
            }
            UserLogin();
            var maker = ConfigurationManager.AppSettings["ebk.UserName"];
            var serviceUrl = ConfigurationManager.AppSettings["ebk.ApiUri"] +
                             ConfigurationManager.AppSettings["ebk.CloseMethod.v2"] + "?kf=" + kf + "&rnk=" + rnk +
                             "&dateOff=" + dateOff + "&maker=" + maker;

            var status = "ERROR";
            string err;
            try
            {
                HttpWebResponse httpResponse = MakeRequest(serviceUrl, null, "PUT");

                string responseStr;
                using (Stream responseStream = httpResponse.GetResponseStream())
                {
                    responseStr = new StreamReader(responseStream, Encoding.UTF8).ReadToEnd();
                    Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", LogMessagePrefix,
                        responseStr));
                }

                if (httpResponse.StatusCode == HttpStatusCode.OK)
                {
                    ResponseV2 ebkResponse = responseStr.XmlDeserialize<ResponseV2>(Encoding.UTF8);

                    if (ResponseStatus.OK.ToString() != ebkResponse.Status)
                    {
                        err = string.Format("{0} Помилка закриття картки клієнта он-лайн. <br />Помилка: {1}",
                            LogMessagePrefix, ebkResponse.Message);
                        Logger.Error(err);
                        return status;
                    }

                    Logger.Info(string.Format("{0} Віддалений сервіс успішно виконав команду закриття клієнта RNK={1}",
                        LogMessagePrefix, rnk));
                    status = "OK";

                    return status;
                }
            }
            catch (Exception ex)
            {
                err = string.Format("{0} Невідома помилка закриття картки РНК={2}  онлайн:  {1}", LogMessagePrefix,
                    (ex.InnerException != null ? ex.InnerException.Message : ex.Message), rnk);
                Logger.Error(err);
                return status;
            }
            return status;
        }

        public override string SynchronizeCard(string kf, decimal rnk)
        {
            UserLogin();

            string serviceUrl = ConfigurationManager.AppSettings["ebk.ApiUri"] +
                             ConfigurationManager.AppSettings["ebk.SyncCardMethod.v2"] + "?kf=" + kf + "&rnk=" + rnk;
            var status = "ERROR";
            string error;
            try
            {
                HttpWebResponse httpResponse = MakeRequest(serviceUrl, null, "GET");

                string responseStr;
                using (Stream responseStream = httpResponse.GetResponseStream())
                {
                    responseStr = new StreamReader(responseStream, Encoding.UTF8).ReadToEnd();
                    Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", LogMessagePrefix,
                        responseStr));
                }

                if (HttpStatusCode.OK == httpResponse.StatusCode)
                {
                    ResponseV2 ebkResponse = responseStr.XmlDeserialize<ResponseV2>(Encoding.UTF8);

                    if (ResponseStatus.OK.ToString() != ebkResponse.Status)
                    {
                        error = string.Format(
                            "{0} Помилка синхронізації картки клієнта ФО з віддаленим сервісом ЄБК. <br />Помилка: {1}",
                            LogMessagePrefix, ebkResponse.Message);
                        Logger.Error(error);
                    }
                    else
                    {
                        int processedCardsCount = InternalSavePersonCards(AsEbkRequest(ebkResponse));

                        Logger.Info(string.Format(
                            "{0} Віддалений сервіс ЄБК успішно виконав команду синхронізації картки клієнта  ФО з RNK={1}",
                            LogMessagePrefix, rnk));
                        status = processedCardsCount.ToString();
                    }
                }
                else
                {
                    error = string.Format(
                        "{0} Помилка синхронізації картки клієнта ФО з віддаленим сервісом ЄБК. <br />Помилка: {1}",
                        LogMessagePrefix, httpResponse.StatusCode);
                    Logger.Error(error);
                }
                return status;
            }
            catch (Exception ex)
            {
                error = string.Format("{0} Невідома помилка синхронізації картки ФО РНК={2}  онлайн:  {1}", LogMessagePrefix,
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
            //List<EbkSlaveClient> slaveClients=new List<EbkSlaveClient>(); DuplicatesV2Dto
            List<DuplicatesV2Dto> slaveClients=new List<DuplicatesV2Dto>(); 
            var masterCard = card as CardDataV2;
            if (null==masterCard) return;

            if (null!=masterCard.Duplicates && masterCard.Duplicates.Any())
            {
                slaveClients = masterCard.Duplicates.Select(c => new DuplicatesV2Dto() //EbkSlaveClient
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
                    Value = IndividualPerson.ToString()
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


        private RequestFromEbkV2 AsEbkRequest(ResponseV2 ebkResponse)
        {
            return new RequestFromEbkV2
            {
                BatchId = "-1",
                BatchTimestamp = DateTime.Now,
                Entries = new List<ResponseV2> { ebkResponse }
            };
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
            var response = (HttpWebResponse)request.GetResponse();
            return response;
        }

        private PersonData QueueGetCard(decimal rnk)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_rnk", OracleDbType.Decimal){ Value = rnk }
            };

            return _entities.ExecuteStoreQuery<PersonData>(
                    "select * from EBK_QUEUE_UPDATECARD_V where rnk = bars.ebk_wforms_utl.cut_rnk(:p_rnk)",
                    sqlParams)
                .SingleOrDefault();
        }

        private List<PersonData> QueueGetCards(int packSize, string kf)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_Size", OracleDbType.Int16) { Value = packSize },
                new OracleParameter("p_kf", OracleDbType.Varchar2) { Value = kf }
            };

            return _entities.ExecuteStoreQuery<PersonData>(
                    "select * from EBK_QUEUE_UPDATECARD_V where rownum <= :p_Size and kf = :p_kf",
                    sqlParams)
                .ToList();
        }

        private void QueuePutCard(decimal rnk)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_rnk", OracleDbType.Decimal) { Value = rnk }
            };

            _entities.ExecuteStoreCommand(
                "begin bars.ebk_wforms_utl.add_rnk_queue(:p_rnk); end;",
                sqlParams);
        }

        private void QueueRemoveCard(decimal? objRnk, string objKf)
        {
            RemoveCardFromQueue(objRnk, objKf);
        }

        private int InternalSavePersonCards(RequestFromEbkV2 request)
        {
            var cardsCount = 0;
            bool isModifiedCard;
            object[] sqlParams;

            foreach (var entry in request.Entries)
            {
                if (entry.Status != ResponseStatus.OK.ToString())
                {
                    if (null != entry.Cards)
                    {
                        foreach (var card in entry.Cards)
                        {
                            Logger.Info(string.Format("card: kf={0}, rnk={1}, status={2}, message={3}",
                                card.Kf, card.Rnk, entry.Status, entry.Message));
                        }
                    }

                    continue;
                }

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
                                Value = IndividualPerson.ToString()
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
                        var duplicates=new List<DuplicatesV2Dto>();
                        duplicates.AddRange(card.Duplicates.Select(d=>new DuplicatesV2Dto()
                        {
                            Gcif = d.Gcif,
                            Kf = d.Kf,
                            MasterGcif = d.MasterGcif,
                            Rnk = d.Rnk
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
                                Value = IndividualPerson.ToString()
                            },
                            new OracleParameter(parameterName: "p_gcif", oraType: OracleDbType.Varchar2)
                        {
                                Value = gcif
                            },
                            new OracleParameter(parameterName: "p_slave_client_ebk", type: OracleDbType.Array,
                                direction: ParameterDirection.Input)
                            {
                                UdtTypeName = "BARS.T_SLAVE_CLIENT_EBK",
                                Value = duplicates.ToArray()
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

    enum EbkStatusCode
    {
        Ok=0,
        RemoteErrorFromEbk=1,
        DbError=2,
        OtherError=3
    }
}