using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Xml;
using System.Web;
using System.Xml.Serialization;
using Areas.Cdm.Models;
using barsroot.core;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Core.Logger;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Enums;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Ninject;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation
{
    public class CdmRepository : ICdmRepository
    {
        [Inject]
        public IBanksRepository BanksRepository { get; set; }
        [Inject]
        public IHomeRepository HomeRepo { get; set; }
        [Inject]
        public IDbLogger Logger { get; set; }
        private readonly CdmModel _entities;
        private const string _logMessagePrefix = "ЕБК.";
        
        public CdmRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("CdmModel", "Cdm");
            _entities = new CdmModel(connectionStr);
        }

        private void UserLogin()
        {
            var userName = ConfigurationManager.AppSettings["ebk.UserName"];
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);
            var sqlParams = new object[]
            {
                new OracleParameter("p_sessionid", OracleDbType.Varchar2) {Value = HttpContext.Current.Session.SessionID},
                new OracleParameter("p_userid", OracleDbType.Decimal) {Value = userMap.user_id},
                new OracleParameter("p_hostname", OracleDbType.Varchar2) {Value = "localhost"},
                new OracleParameter("p_appname", OracleDbType.Varchar2) {Value = "barsroot"}
            };
            _entities.ExecuteStoreCommand("begin bars.bars_login.login_user(:p_sessionid, :p_userid, :p_hostname, :p_appname); end;", sqlParams);

            HttpContext.Current.Session["UserLoggedIn"] = true;
        }

        public void SaveRequestToTempTable(string packName, string packBody)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_Name", OracleDbType.Varchar2) {Value = packName},
                new OracleParameter("p_Body", OracleDbType.Clob) {Value = packBody}
            };
            _entities.ExecuteStoreCommand("insert into BARS.TMP_KLP_CLOB (NAMEF,  C) values (:p_Name, :p_Body)", sqlParams);
        }

        /// <summary>
        /// Отправляет карточку клиента по РНК на сервис ЕБК он-лайн с целью получения рекомендаций
        /// В случае успеха, записывает полученные рекомендации во временную табличку АРМа качества
        /// В случае ошибки - генерится исключение, запись на дальнейшую отправку в очереди оффлайн выгрузки должна остаться
        /// Возвращает онлайн-статус карточки
        /// </summary>
        /// <param name="rnk">РНК клиента</param>
        /// <param name="httpMethod">Для существующих карточек следует указывать метод PUT</param>
        public ActionStatus PackAndSendSingleCard(decimal rnk, string httpMethod = "POST")
        {
            var result = new ActionStatus(ActionStatusCode.Ok);
            List<Analytics> checks = new List<Analytics>();
            Logger.Info(string.Format("{0} Ініційовано он-лайн запит по РНК {1}.", _logMessagePrefix, rnk));
            var apiUrl = ConfigurationManager.AppSettings["ebk.ApiUri"] +
                         ConfigurationManager.AppSettings["ebk.LoadCardMethod"];
            XmlWriterSettings settings = new XmlWriterSettings { OmitXmlDeclaration = true, CheckCharacters = false };
            XmlSerializerNamespaces names = new XmlSerializerNamespaces();
            names.Add("", "");
            string err = null;
            var sqlParams = new object[]
            {
                new OracleParameter("p_rnk", OracleDbType.Decimal)
                {
                    Value = rnk
                }
            };
            try
            {
                const string getCardSql = "select * from EBK_QUEUE_UPDATECARD_V where rnk = :p_rnk";
                const string putCardSql = "begin bars.ebk_wforms_utl.add_rnk_queue (:p_rnk); end;";
                var card = _entities.ExecuteStoreQuery<BufClientData>(getCardSql, sqlParams).SingleOrDefault();
                //если карточки с указанным РНК почемуто в очереди нет - добавим ее туда
                if (card == null)
                {
                    _entities.ExecuteStoreCommand(putCardSql, sqlParams);
                    card = _entities.ExecuteStoreQuery<BufClientData>(getCardSql, sqlParams).SingleOrDefault();
                }

                if (card == null)
                {
                    err = string.Format("{0} Не знайдено картку клієнта з РНК={1} у черзі на відправку до ЄБК.",
                        _logMessagePrefix, rnk);
                    result.Status = ActionStatusCode.Error;
                    result.Message = err;
                    Logger.Error(err);
                    throw new Exception(err);
                }
                decimal packNum = GetNextPackNumber();
                string ourMfo = BanksRepository.GetOurMfo();

                SimpleCard simpleCard = new SimpleCard(ourMfo, packNum.ToString(), HomeRepo.GetUserParam().USER_FULLNAME, card);

                XmlSerializer ser = new XmlSerializer(typeof(SimpleCard));
                MemoryStream ms = new MemoryStream();
                XmlWriter writer = XmlWriter.Create(ms, settings);
                ser.Serialize(writer, simpleCard, names);
                writer.Close();
                ms.Flush();
                ms.Seek(0, SeekOrigin.Begin);

                StreamReader sr = new StreamReader(ms);
                var xml = sr.ReadToEnd();

                //отправляем данные в ЕБК
                var bytes = Encoding.UTF8.GetBytes(xml);

                //apiUrl = "http://localhost/barsroot/CDMService/TestThisShit";

                var request = WebRequest.Create(apiUrl);
                request.Method = httpMethod;
                request.ContentType = "application/xml;charset='utf-8'";
                request.ContentLength = bytes.Length;
                Stream requestStream = request.GetRequestStream();
                requestStream.Write(bytes, 0, bytes.Length);
                requestStream.Close();
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                if (response.StatusCode == HttpStatusCode.OK)
                {
                    Stream responseStream = response.GetResponseStream();
                    string responseStr = new StreamReader(responseStream).ReadToEnd();

                    var reader = new StringReader(responseStr);
                    XmlSerializer serResp = new XmlSerializer(typeof(OnlineAdvisory));
                    OnlineAdvisory advisory = (OnlineAdvisory)serResp.Deserialize(reader);
                    reader.Close();

                    if (advisory.Status == "OK")
                    {
                        if (!String.IsNullOrEmpty(advisory.OnlineClientCard.Gcif))
                        {
                            //сохраним GCIF пришедший в ответ на он-лайн запрос
                            SaveGcif(new MasterCard()
                            {
                                Gcif = advisory.OnlineClientCard.Gcif,
                                Kf = advisory.OnlineClientCard.ClientCard.Kf,
                                Rnk = advisory.OnlineClientCard.ClientCard.Rnk,
                                SlaveClients = new SlaveClient[0] 
                            }, "on-line");
                        }

                        InternalSaveAdvisory(ConvertOnlineAdvisoryToAdvisoryCards(advisory));
                        RemoveCardFromQueue(card.Rnk);

                        var ebkResult = ConvertOnlineAdvisoryToAdvisoryCards(advisory);
                        if (ebkResult.ClientsAnalysis != null && ebkResult.ClientsAnalysis.Any())
                        {
                            var clientAnalis = ebkResult.ClientsAnalysis[0].AttrAnalysis;
                            if (clientAnalis != null)
                            {
                                foreach (var analysis in clientAnalis.Where(analysis => analysis.Check != null))
                                {
                                    checks.AddRange(analysis.Check.Select(check => new Analytics()
                                    {
                                        Descr = check.Descr,
                                        Name = analysis.Name,
                                        Quality = analysis.Quality,
                                        RecommendValue = check.RecommendValue,
                                        Value = analysis.Value
                                    }));
                                }
                            }
                        }

                        result.Data = new { checks = checks, status = advisory.OnlineClientCard.OnlineStatus, dupes = advisory.OnlineClientCard.OnlineDupes };
                        if (checks.Count > 0 || advisory.OnlineClientCard !=null &&  advisory.OnlineClientCard.OnlineDupes != null && advisory.OnlineClientCard.OnlineDupes.Duplicate != null && advisory.OnlineClientCard.OnlineDupes.Duplicate.Any())
                        {
                            result.Status = ActionStatusCode.Error;
                            result.Message = "Отримано рекомендації або дублікати по клієнту.";
                        }

                        Logger.Info(string.Format("{0} Отримано рекомендації по клієнту з РНК={1} он-лайн.",
                            _logMessagePrefix,
                            rnk));
                    }
                    else
                    {
                        err = string.Format("{0} Помилка обробки он-лайн запиту на перевірку картки з РНК={2}: <br />Помилка: {1}",
                        _logMessagePrefix, advisory.Msg, rnk);
                        Logger.Error(err);
                        throw new Exception(err);
                    }
                }
                else
                {
                    err = string.Format("{0} Віддалений сервіс відхилив он-лайн запит на перевірку картки з РНК={2}: <br />СТАТУС: {1}",
                        _logMessagePrefix, response.StatusDescription, rnk);
                    Logger.Error(err);
                    throw new Exception(err);
                }
            }
            catch (Exception e)
            {
                err = string.Format("{0} Невідома помилка надсилання картки РНК={2} онлайн:  {1}", _logMessagePrefix, (e.InnerException != null ? e.InnerException.Message : e.Message), rnk);
                Logger.Error(err);
                throw new Exception(err + e.StackTrace);
            }
            return result;
        }

        public decimal PackAndSendRcifs(int? rcifsCount, int packSize)
        {
            UserLogin();
            decimal allCardsSended = 0;
            Logger.Info(string.Format("{0} Розпочато надсилання RCIF клієнтів. Розмір пакету - {1}.", _logMessagePrefix, packSize));
            var apiUrl = ConfigurationManager.AppSettings["ebk.ApiUri"] +
                ConfigurationManager.AppSettings["ebk.RcifMethod"];

            XmlWriterSettings settings = new XmlWriterSettings { OmitXmlDeclaration = true, CheckCharacters = false };
            XmlSerializerNamespaces names = new XmlSerializerNamespaces();
            names.Add("", "");
            string xml = "";
            try
            {
                while (rcifsCount == null || allCardsSended < rcifsCount)
                {
                    //посчитаем размер следующего пакета
                    var currentPackSize = GetNextRcifCount(packSize);
                    if (currentPackSize == 0)
                    {
                        Logger.Info(string.Format("{0} Не знайдено Rcif.", _logMessagePrefix));
                        break;
                    }
                    var sqlParams = new object[]
                    {
                        new OracleParameter("p_Size", OracleDbType.Int16)
                        {
                            Value = ((rcifsCount == null || rcifsCount > packSize) ? packSize : rcifsCount)
                        }
                    };

                    var packRcifs = _entities.ExecuteStoreQuery<decimal>(
                        "select rcif from ebk_rcif where rownum <= :p_Size and send = 0", sqlParams).ToList();

                    //получаем параметры пакета
                    decimal packNum = GetNextPackNumber();
                    string ourMfo = BanksRepository.GetOurMfo();

                    //строим пакет
                    Rcif package = new Rcif()
                    {
                        BatchId = packNum.ToString(),
                        Kf = ourMfo,
                        Maker = HomeRepo.GetUserParam().USER_FULLNAME,
                        RcifClients = packRcifs.Select(r =>
                            new RcifClientsContainer()
                            {
                                RcifClient = new RcifClient()
                                {
                                    Kf = ourMfo,
                                    Rcif = r.ToString(),
                                    Rnk = r
                                }
                            }).ToArray()
                    };
                    XmlSerializer ser = new XmlSerializer(typeof(Rcif));

                    MemoryStream ms = new MemoryStream();
                    XmlWriter writer = XmlWriter.Create(ms, settings);
                    ser.Serialize(writer, package, names);
                    writer.Close();
                    ms.Flush();
                    ms.Seek(0, SeekOrigin.Begin);

                    StreamReader sr = new StreamReader(ms);
                    xml = sr.ReadToEnd();

                    //отправляем данные в ЕБК
                    var bytes = Encoding.UTF8.GetBytes(xml);

                    var request = WebRequest.Create(apiUrl);
                    request.Method = "POST";
                    request.ContentType = "application/xml;charset='utf-8'";
                    request.ContentLength = bytes.Length;
                    Stream requestStream = request.GetRequestStream();
                    requestStream.Write(bytes, 0, bytes.Length);
                    requestStream.Close();
                    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        Stream responseStream = response.GetResponseStream();
                        string responseStr = new StreamReader(responseStream).ReadToEnd();
                        Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", _logMessagePrefix,
                            responseStr));
                    }
                    else
                    {
                        Logger.Error(string.Format("{0} Отримано помилковий код: {1}", _logMessagePrefix, response.StatusCode));
                        Logger.Error(String.Format("{0} - {1}", _logMessagePrefix, xml));
                    }

                    //записываем результаты отправки
                    foreach (var rnk in packRcifs)
                    {
                        RemoveRcifFromQueue(rnk);
                    }
                    Logger.Info(string.Format("{0} Успішно надіслано пакет карток розміром {1} шт.", _logMessagePrefix, currentPackSize));

                    allCardsSended = allCardsSended + currentPackSize;

                }
                Logger.Info(string.Format("{0} Успішно надіслано {1} Rcif.", _logMessagePrefix, allCardsSended));
            }
            catch (Exception ex)
            {
                Logger.Error(string.Format(
                    "{0} Помилка пакетної доставки. {1} --- {2}",
                    _logMessagePrefix,
                    (ex.InnerException != null ? ex.InnerException.Message : ex.Message),
                    ex.StackTrace
                    ));
                Logger.Error(String.Format("{0} - {1}", _logMessagePrefix, xml));
            }
            return allCardsSended;
        }

        public decimal PackAndSendClientCards(int? cardsCount, int packSize)
        {
            UserLogin();
            decimal allCardsSended = 0;
            Logger.Info(string.Format("{0} Розпочато надсилання карток клієнтів. Розмір пакету - {1}.", _logMessagePrefix, packSize));
            var apiUrl = ConfigurationManager.AppSettings["ebk.ApiUri"] +
                ConfigurationManager.AppSettings["ebk.LoadCardsMethod"];
            byte[] bytes = new byte[] { };

            XmlWriterSettings settings = new XmlWriterSettings { OmitXmlDeclaration = true, CheckCharacters = false };
            XmlSerializerNamespaces names = new XmlSerializerNamespaces();
            names.Add("", "");
            string xml = "";
            try
            {
                while (cardsCount == null || allCardsSended < cardsCount)
                {
                    //посчитаем размер следующего пакета
                    var currentPackSize = GetNextCardsCount(packSize);
                    if (currentPackSize == 0)
                    {
                        Logger.Info(string.Format("{0} Не знайдено карток клієнтів для відправки у.", _logMessagePrefix));
                        break;
                    }
                    var sqlParams = new object[]
                    {
                        new OracleParameter("p_Size", OracleDbType.Int16)
                        {
                            Value = ((cardsCount == null || cardsCount > packSize) ? packSize : cardsCount)
                        }
                    };

                    var packBody = _entities.ExecuteStoreQuery<BufClientData>(
                        "select * from EBK_QUEUE_UPDATECARD_V where rownum <= :p_Size", sqlParams).ToList();

                    //получаем параметры пакета
                    decimal packNum = GetNextPackNumber();
                    string ourMfo = BanksRepository.GetOurMfo();

                    //строим пакет
                    Card package = new Card(ourMfo, packNum.ToString(), HomeRepo.GetUserParam().USER_FULLNAME, packBody);
                    XmlSerializer ser = new XmlSerializer(typeof(Card));

                    MemoryStream ms = new MemoryStream();
                    XmlWriter writer = XmlWriter.Create(ms, settings);
                    ser.Serialize(writer, package, names);
                    writer.Close();
                    ms.Flush();
                    ms.Seek(0, SeekOrigin.Begin);

                    StreamReader sr = new StreamReader(ms);
                    xml = sr.ReadToEnd();

                    //отправляем данные в ЕБК
                    bytes = Encoding.UTF8.GetBytes(xml);

                    var request = WebRequest.Create(apiUrl);
                    request.Method = "POST";
                    request.ContentType = "application/xml;charset='utf-8'";
                    request.ContentLength = bytes.Length;
                    Stream requestStream = request.GetRequestStream();
                    requestStream.Write(bytes, 0, bytes.Length);
                    requestStream.Close();
                    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        Stream responseStream = response.GetResponseStream();
                        string responseStr = new StreamReader(responseStream).ReadToEnd();
                        Logger.Info(String.Format("{0} - {1}", _logMessagePrefix, xml));
                        Logger.Info(string.Format("{0} Отримано відповідь від сервісу:: {1}", _logMessagePrefix,
                            responseStr));
                    }
                    else
                    {
                        Logger.Error(string.Format("{0} Отримано помилковий код: {1}", _logMessagePrefix, response.StatusCode));
                        Logger.Error(String.Format("{0} - {1}", _logMessagePrefix, xml));
                    }

                    //записываем результаты отправки
                    foreach (var card in packBody)
                    {
                        RemoveCardFromQueue(card.Rnk);
                    }
                    Logger.Info(string.Format("{0} Успішно надіслано пакет карток розміром {1} шт.", _logMessagePrefix, currentPackSize));

                    allCardsSended = allCardsSended + currentPackSize;

                }
                Logger.Info(string.Format("{0} Успішно надіслано {1} карток клієнтів.", _logMessagePrefix, allCardsSended));
            }
            catch (Exception ex)
            {
                Logger.Error(string.Format(
                    "{0} Помилка пакетної доставки. {1} --- {2}",
                    _logMessagePrefix,
                    (ex.InnerException != null ? ex.InnerException.Message : ex.Message),
                    ex.StackTrace
                    ));
                Logger.Error(String.Format("{0} - {1}", _logMessagePrefix, xml));
            }
            return allCardsSended;
        }

        private decimal GetNextPackNumber()
        {
            return _entities.ExecuteStoreQuery<decimal>("SELECT EBK_PACKAGE_NMBR.NEXTVAL FROM DUAL").SingleOrDefault();
        }

        private void RemoveCardFromQueue(decimal? rnk)
        {
            var sqlUpdParams = new object[]
                        {
                            new OracleParameter("p_rnk", OracleDbType.Decimal) {Value = (rnk)}
                        };
            _entities.ExecuteStoreCommand("delete from EBK_QUEUE_UPDATECARD where RNK = :p_rnk",
                sqlUpdParams);
        }
        private void RemoveRcifFromQueue(decimal rnk)
        {
            var sqlUpdParams = new object[]
                        {
                            new OracleParameter("p_rnk", OracleDbType.Decimal) {Value = (rnk)}
                        };
            _entities.ExecuteStoreCommand("update ebk_rcif set send = 1 where rcif = :p_rnk",
                sqlUpdParams);
        }

        private decimal GetNextCardsCount(int packSize)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_Size", OracleDbType.Int16) {Value = packSize}
            };
            return _entities.ExecuteStoreQuery<decimal>("select count(*) from EBK_QUEUE_UPDATECARD_V where rownum <= : p_Size", sqlParams).SingleOrDefault();
        }


        private decimal GetNextRcifCount(int packSize)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_Size", OracleDbType.Int16) {Value = packSize}
            };
            return _entities.ExecuteStoreQuery<decimal>("select count(*) from ebk_rcif where rownum <= : p_Size and send = 0", sqlParams).SingleOrDefault();
        }

        private AdvisoryCards ConvertOnlineAdvisoryToAdvisoryCards(OnlineAdvisory card)
        {
            return new AdvisoryCards()
            {
                BatchId = "-1",
                ClientsAnalysis = new ClientAnalysis[] { card.OnlineClientCard.ClientCard },
                Kf = card.OnlineClientCard.ClientCard.Kf,
                Maker = "automatic"
            };
        }

        private int InternalSaveAdvisory(AdvisoryCards advisory)
        {
            int requestCount = 0;
            foreach (var customer in advisory.ClientsAnalysis)
            {
                List<Analytics> checks = new List<Analytics>();
                if (customer.AttrAnalysis != null)
                {
                    foreach (var analysis in customer.AttrAnalysis)
                    {
                        var reccomendation = analysis.Check != null ? analysis.Check.FirstOrDefault() : null;
                        checks.Add(
                            new Analytics()
                            {
                                Descr = reccomendation != null ? reccomendation.Descr : null,
                                Name = analysis.Name,
                                Quality = analysis.Quality,
                                RecommendValue = reccomendation != null ? reccomendation.RecommendValue : null,
                                Value = analysis.Value
                            }
                            );
                    }
                }

                var sqlParams = new OracleParameter[]
                {
                    new OracleParameter("p_batchId", OracleDbType.Varchar2)
                    {
                        Value = (advisory.BatchId.ToString())
                    },
                    new OracleParameter("p_kf", OracleDbType.Varchar2)
                    {
                        Value = (customer.Kf)
                    },
                    new OracleParameter("p_rnk", OracleDbType.Decimal)
                    {
                        Value = (customer.Rnk)
                    },
                    new OracleParameter("p_anls_quality", OracleDbType.Decimal)
                    {
                        Value = (customer.Quality)
                    },
                    new OracleParameter("p_defaultGroupQuality", OracleDbType.Decimal)
                    {
                        Value = (customer.DefaultGroupQuality)
                    },
                    new OracleParameter(parameterName: "p_tab_attr", type: OracleDbType.Array, direction: ParameterDirection.Input)
                    {
                        UdtTypeName = "BARS.T_REC_EBK",
                        Value = checks.ToArray()
                    },
                    new OracleParameter(parameterName: "p_rec_qlt_grp", type: OracleDbType.Array, direction: ParameterDirection.Input)
                    {
                        UdtTypeName = "BARS.T_REC_QLT_GRP",
                        Value = customer.CustomQualityGroups
                    }                
                };

                _entities.ExecuteStoreCommand(@"begin 
                        bars.ebk_request_utl.request_updatecard_mass(
                            :p_batchId, 
                            :p_kf, 
                            :p_rnk, 
                            :p_anls_quality, 
                            :p_defaultGroupQuality, 
                            :p_tab_attr,
                            :p_rec_qlt_grp); 
                        end;", sqlParams);
                ++requestCount;

            }
            return requestCount;
        }

        public int SaveCardsAdvisoryFast(AdvisoryCards advisory)
        {
            UserLogin();
            return InternalSaveAdvisory(advisory);
        }


        public int SaveCardChangesOnline(SimpleCard card)
        {
            //TODO реализовать если все-таки это нужно и банк не против писать карточку из ЕБК
            return 0;
        }


        public void SaveGcifs(MasterCard[] masterCards, string batchId)
        {
            UserLogin();
            if (masterCards != null)
            {
                foreach (var card in masterCards)
                {
                    if (card.Gcif != null)
                    {
                        SaveGcif(card, batchId);
                    }
                }
            }
            Logger.Info(string.Format("{0} GCIF-и з пакету {1} успішно збережено.", _logMessagePrefix, batchId));
        }

        public void SaveGcif(MasterCard masterCard, string batchId)
        {
            List<EbkSlaveClient> gcifs = new List<EbkSlaveClient>();
            if (masterCard.SlaveClients != null && masterCard.SlaveClients.Any())
            {
                gcifs = masterCard.SlaveClients.Select(c => new EbkSlaveClient()
                {
                    Kf = c.Kf,
                    Rnk = decimal.Parse(c.Rnk)
                }).ToList();
            }
            var sqlParams = new OracleParameter[]{
                new OracleParameter("p_batchId", OracleDbType.Varchar2)
                {
                    Value = (batchId)
                },                
                new OracleParameter("p_kf", OracleDbType.Varchar2)
                {
                    Value = (masterCard.Kf)
                },
                new OracleParameter("p_rnk", OracleDbType.Decimal)
                {
                    Value = (masterCard.Rnk)
                },
                new OracleParameter("p_gcif", OracleDbType.Varchar2)
                {
                    Value = (masterCard.Gcif)
                },
                 new OracleParameter("p_slave_client_ebk", OracleDbType.Array)
                {
                    UdtTypeName = "BARS.T_SLAVE_CLIENT_EBK",
                    Value = gcifs.ToArray()
                }
            };
            _entities.ExecuteStoreCommand(@"begin 
                bars.ebk_dup_request_utl.request_gcif_mass(  
                    :p_batchId,                  
                    :p_kf,
                    :p_rnk,
                    :p_gcif,
                    :p_slave_client_ebk);
                end;", sqlParams);
        }

        public void SaveDuplicates(DupPackage[] duplicates, string batchId)
        {
            UserLogin();
            if (duplicates != null)
            {
                foreach (var duplicate in duplicates)
                {
                    if (duplicate.Duplicates != null && duplicate.Duplicates.Any())
                    {
                        SaveDuplicate(duplicate, batchId);
                    }
                }
            }
            Logger.Info(string.Format("{0} Дублікати з пакету {1} успішно збережено.", _logMessagePrefix, batchId));
        }

        public void SaveDuplicate(DupPackage duplicate, string batchId)
        {
            var duplicates = duplicate.Duplicates.Select(c => new EbkDupeClient()
            {
                Kf = c.Kf,
                Rnk = decimal.Parse(c.Rnk)
            });
            var sqlParams = new OracleParameter[]
            {
                new OracleParameter("p_batchId", OracleDbType.Varchar2)
                {
                    Value = (batchId)
                },
                new OracleParameter("p_kf", OracleDbType.Varchar2)
                {
                    Value = (duplicate.Kf)
                },
                new OracleParameter("p_rnk", OracleDbType.Decimal)
                {
                    Value = (duplicate.Rnk)
                },
                 new OracleParameter("p_duplicate_ebk", OracleDbType.Array)
                {
                    UdtTypeName = "BARS.T_DUPLICATE_EBK",
                    Value = duplicates.ToArray()
                }
            };
            _entities.ExecuteStoreCommand(@"begin 
                bars.ebk_dup_request_utl.request_duplicate_mass( 
                    :p_batchId,                   
                    :p_kf,
                    :p_rnk,                    
                    :p_duplicate_ebk);
                end;", sqlParams);
        }

        public void SendCloseCard(string kf, decimal rnk, string dateOff)
        {
            UserLogin();
            var Maker = ConfigurationManager.AppSettings["ebk.UserName"];
            var serviceUrl = ConfigurationManager.AppSettings["ebk.ApiUri"] +
                         ConfigurationManager.AppSettings["ebk.CloseMethod"] +
                         kf + "/" + rnk + "/" + dateOff + "/" + Maker;

            var request = WebRequest.Create(serviceUrl);
            request.Method = "PUT";
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            if (response.StatusCode == HttpStatusCode.OK)
            {
                Stream responseStream = response.GetResponseStream();
                string responseStr = new StreamReader(responseStream).ReadToEnd();

                var reader = new StringReader(responseStr);
                XmlSerializer ser = new XmlSerializer(typeof(Response));
                Response responce = (Response)ser.Deserialize(reader);
                reader.Close();
                
                if (responce.Status != "OK")
                {
                    var err = string.Format("{0} Помилка закриття картки клієнта он-лайн. <br />Помилка: {1}",
                        _logMessagePrefix, responce.Msg);
                    Logger.Error(err);
                    throw new Exception(err);
                }
                Logger.Info(string.Format("{0} Віддалений сервіс успішно виконав команду закриття клієнта RNK={1}", _logMessagePrefix, rnk));
            }
            else
            {
                var err = string.Format("{0} Віддалений сервіс відхилив он-лайн запит на закриття картки. <br />СТАТУС: {1}", _logMessagePrefix, response.StatusDescription);
                Logger.Error(err);
                throw new Exception(err);
            }
        }


        public void DeleteGcif(string gcif)
        {
            _entities.ExecuteStoreCommand(
                "begin bars.ebk_dup_request_utl.request_del_gcif(p_gcif => :p_gcif); end; ",
                new OracleParameter("p_gcif", OracleDbType.Varchar2)
                    {
                        Value = (gcif)
                    }
                );
        }

        public void DeleteGcifs(string[] gcifs)
        {
            foreach (var gcif in gcifs)
            {
                DeleteGcif(gcif);
            }
        }
    }

}