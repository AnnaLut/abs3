﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Xml;
using System.Xml.Serialization;
using BarsWeb.Areas.Cdm.Infrastructure.DI.Abstract.PrivateEn;
using Areas.Cdm.Models;
using barsroot.core;
using BarsWeb.Areas.Cdm.Models.Transport;
using BarsWeb.Areas.Cdm.Models.Transport.Legal;
using BarsWeb.Areas.Cdm.Models.Transport.PrivateEn;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Core.Logger;
using BarsWeb.Core.Models;
using BarsWeb.Core.Models.Enums;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Ninject;
using Oracle.DataAccess.Client;
using BarsWeb.Areas.Cdm.Models.Transport.Individual;

namespace BarsWeb.Areas.Cdm.Infrastructure.DI.Implementation.PrivateEn
{
    public class CdmPrivateEnRepository : ICdmPrivateEnRepository
    {
        [Inject]
        public IBanksRepository BanksRepository { get; set; }
        [Inject]
        public IHomeRepository HomeRepo { get; set; }
        [Inject]
        public IDbLogger Logger { get; set; }
        protected readonly CdmModel _entities;
        protected const string _logMessagePrefix = "ЕБК-ФОП.";


        public CdmPrivateEnRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("CdmModel", "Cdm");
            _entities = new CdmModel(connectionStr);
        }


        public virtual void SaveRequestToTempTable(string packName, string packBody)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_Name", OracleDbType.Varchar2) {Value = packName},
                new OracleParameter("p_Body", OracleDbType.Clob) {Value = packBody}
            };
            _entities.ExecuteStoreCommand("insert into BARS.TMP_KLP_CLOB (NAMEF,  C) values (:p_Name, :p_Body)", sqlParams);
        }

        public virtual decimal PackAndSendClientCards(int? cardsCount, int packSize, string kf)
        {
            UserLogin();
            Logger.Info(string.Format("{0} Розпочато надсилання карток ФОП. Розмір пакету - {1}.", _logMessagePrefix, packSize));
            var apiUrl = ConfigurationManager.AppSettings["ebk.ApiUriPrivateEn"] +
                ConfigurationManager.AppSettings["ebk.LoadCardsMethodPrivateEn"];
            byte[] bytes = new byte[] { };

            XmlWriterSettings settings = new XmlWriterSettings { OmitXmlDeclaration = true, CheckCharacters = false };
            XmlSerializerNamespaces names = new XmlSerializerNamespaces();
            names.Add("", "");
            string xml = "";
            try
            {
                var sqlParams = new object[]
                {
                        new OracleParameter("p_Size", OracleDbType.Int16)
                        {
                            Value =  packSize
                        },
                         new OracleParameter("p_kf", OracleDbType.Varchar2)
                        {
                            Value =  kf
                        }
                    };

                var packPlaneBody = _entities.ExecuteStoreQuery<PrivateEnData>("select * from v_ebkc_queue_updcard_private where rownum <= :p_Size and kf = :p_kf ", sqlParams).ToList();
                // мапим плоский клас на иерархию              
                var packBody = packPlaneBody.Select(MapPrivateEnData).ToList();
                //дополним каждую карточку информацие о привязанных особах

                foreach (var lp in packBody)
                {
                    lp.RelatedPersons = ExtractRelatedPersonList(lp.Rnk);
                }

                //получаем параметры пакета
                decimal packNum = GetNextPackNumber();
                //string ourMfo = BanksRepository.GetOurMfo();

                //строим пакет
                PrivateEnCards package = new PrivateEnCards(kf, packNum.ToString(), HomeRepo.GetUserParam().USER_FULLNAME, packBody);
                XmlSerializer ser = new XmlSerializer(typeof(PrivateEnCards));

                MemoryStream ms = new MemoryStream();
                XmlWriter writer = XmlWriter.Create(ms, settings);
                ser.Serialize(writer, package, names);
                writer.Close();
                ms.Flush();
                ms.Seek(0, SeekOrigin.Begin);

                StreamReader sr = new StreamReader(ms);
                xml = sr.ReadToEnd();

                //if (!Directory.Exists(@"C:\Windows\Temp\Cdm\"))
                //    Directory.CreateDirectory(@"C:\Windows\Temp\Cdm\");
                //File.WriteAllText(string.Format(@"C:\Windows\Temp\Cdm\privateEntrepreneurs_{0}.xml", package.BatchId), xml);

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
                    RemoveCardFromQueue(card.Rnk, card.Kf);
                }
                Logger.Info(string.Format("{0} Успішно надіслано пакет карток розміром {1} шт.", _logMessagePrefix, packSize));
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
            return packSize;
        }

        /// <summary>
        /// Отправляет карточку клиента по РНК на сервис ЕБК он-лайн с целью получения рекомендаций
        /// В случае успеха, записывает полученные рекомендации во временную табличку АРМа качества
        /// В случае ошибки - генерится исключение, запись на дальнейшую отправку в очереди оффлайн выгрузки должна остаться
        /// Возвращает онлайн-статус карточки
        /// </summary>
        /// <param name="rnk">РНК клиента</param>
        public virtual ActionStatus PackAndSendSingleCard(decimal rnk)
        {
            var result = new ActionStatus(ActionStatusCode.Ok);
            List<Analytics> checks = new List<Analytics>();
            Logger.Info(string.Format("{0} Ініційовано он-лайн запит по РНК {1}.", _logMessagePrefix, rnk));
            var apiUrl = ConfigurationManager.AppSettings["ebk.ApiUriPrivateEn"] +
                         ConfigurationManager.AppSettings["ebk.LoadCardMethodPrivateEn"];
            XmlWriterSettings settings = new XmlWriterSettings { OmitXmlDeclaration = true, CheckCharacters = false };
            XmlSerializerNamespaces names = new XmlSerializerNamespaces();
            names.Add("", "");
            string err;
            var sqlParams = new object[]
            {
                new OracleParameter("p_rnk", OracleDbType.Decimal)
                {
                    Value = rnk
                }
            };
            try
            {
                const string getCardSql = "select * from BARS.V_EBKC_QUEUE_UPDCARD_PRIVATE where CUST_ID = :p_rnk";
                const string putCardSql = "begin bars.ebk_wforms_utl.add_rnk_queue (:p_rnk); end;";
                var plainCard = _entities.ExecuteStoreQuery<PrivateEnData>(getCardSql, sqlParams).SingleOrDefault();
                //если карточки с указанным РНК почемуто в очереди нет - добавим ее туда
                if (plainCard == null)
                {
                    _entities.ExecuteStoreCommand(putCardSql, sqlParams);
                    plainCard = _entities.ExecuteStoreQuery<PrivateEnData>(getCardSql, sqlParams).SingleOrDefault();
                }

                if (plainCard == null)
                {
                    err = string.Format("{0} Не знайдено картку клієнта з РНК={1} у черзі на відправку до ЄБК.",
                        _logMessagePrefix, rnk);
                    result.Status = ActionStatusCode.Error;
                    result.Message = err;
                    Logger.Error(err);
                    throw new Exception(err);
                }
                decimal packNum = GetNextPackNumber();
                //string ourMfo = BanksRepository.GetOurMfo();
                var card = MapPrivateEnData(plainCard);

                var relatedPerson = ExtractRelatedPersonList(card.Rnk);

                card.RelatedPersons = relatedPerson;

                PrivateEnCard simpleCard = new PrivateEnCard(card.Kf, packNum.ToString(), HomeRepo.GetUserParam().USER_FULLNAME, card);

                XmlSerializer ser = new XmlSerializer(typeof(PrivateEnCard));
                MemoryStream ms = new MemoryStream();
                XmlWriter writer = XmlWriter.Create(ms, settings);
                ser.Serialize(writer, simpleCard, names);
                writer.Close();
                ms.Flush();
                ms.Seek(0, SeekOrigin.Begin);

                StreamReader sr = new StreamReader(ms);
                var xml = sr.ReadToEnd();

                //if (!Directory.Exists(@"C:\Windows\Temp\Cdm\"))
                //    Directory.CreateDirectory(@"C:\Windows\Temp\Cdm\");
                //File.WriteAllText(string.Format(@"C:\Windows\Temp\Cdm\privateEntrepreneur{0}_{1}.xml", rnk, "PUT"), xml);

                //отправляем данные в ЕБК
                var bytes = Encoding.UTF8.GetBytes(xml);

                var request = WebRequest.Create(apiUrl);
                request.Method = "PUT";
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
                        RemoveCardFromQueue(card.Rnk, card.Kf);

                        result.Message = "Дані відправлені і отримано рекомендації або дублікати по клієнту.";
                        Logger.Info( string.Format("{0} Отримано рекомендації або дублікати по клієнту з РНК={1} он-лайн.",_logMessagePrefix, rnk));
                    }
                    if (advisory.Status == "ERROR")
                    {
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

                        result.Data =new { checks = checks, status = advisory.OnlineClientCard.OnlineStatus, dupes = advisory.OnlineClientCard.OnlineDupes };

                        if (checks.Count > 0 ||
                            advisory.OnlineClientCard != null && advisory.OnlineClientCard.OnlineDupes != null &&
                            advisory.OnlineClientCard.OnlineDupes.Duplicate != null &&
                            advisory.OnlineClientCard.OnlineDupes.Duplicate.Any())
                        {
                            result.Status = ActionStatusCode.Error;
                            result.Message = "Отримано рекомендації або дублікати по клієнту.";
                        }
                        else
                        {
                            result.Message = "Сервіс відхилив запит";
                        }
                        Logger.Info(string.Format("{0} Сервіс відхилив запит по клієнту з РНК={1} он-лайн.", _logMessagePrefix, rnk));
                    }
                }
                else
                {
                    err = string.Format("{0} Віддалений сервіс відхилив он-лайн запит на перевірку картки з РНК={2}: <br />СТАТУС: {1}", _logMessagePrefix, response.StatusDescription, rnk);
                    Logger.Error(err);
                    throw new Exception(err);
                }
            }
            catch (Exception e)
            {
                err = string.Format("{0} Невідома помилка надсилання картки РНК={2} онлайн:  {1}", _logMessagePrefix, (e.InnerException != null ? e.InnerException.Message : e.Message), rnk);
                Logger.Error(err);
                throw new Exception(string.Format("{0} Невідома помилка надсилання картки РНК={1} ", _logMessagePrefix, rnk));
            }
            return result;
        }

        public virtual int SaveCardsAdvisoryFast(AdvisoryCards advisory)
        {
            UserLogin();
            return InternalSaveAdvisory(advisory);
        }

        public virtual int SaveCardChangesOnline(SimpleCard card)
        {
            //TODO реализовать если все-таки это нужно и банк не против писать карточку из ЕБК
            return 0;
        }

        public virtual void SaveGcifs(ICard[] cards, string batchId)
        {
            UserLogin();
            var masterCards = cards as MasterCard[];
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

        public virtual void SaveGcif(ICard card, string batchId)
        {
            List<EbkSlaveClient> gcifs = new List<EbkSlaveClient>();
            var masterCard = card as MasterCard;
            if (null == masterCard) return;

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
                bars.ebkc_pack.request_private_gcif_mass(  
                    :p_batchId,                  
                    :p_kf,
                    :p_rnk,
                    :p_gcif,
                    :p_slave_client_ebk);
                end;", sqlParams);
        }

        public virtual void SaveDuplicates(DupPackage[] duplicates, string batchId)
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

        public virtual void SaveDuplicate(DupPackage duplicate, string batchId)
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
                bars.ebkc_pack.request_private_dup_mass( 
                    :p_batchId,                   
                    :p_kf,
                    :p_rnk,                    
                    :p_duplicate_ebk);
                end;", sqlParams);
        }

        public virtual string SendCloseCard(string kf, decimal rnk, string dateOff)
        {
            if (kf == null && dateOff == null)
            {
                kf = _entities.ExecuteStoreQuery<string>("SELECT kf FROM customer where rnk = " + Convert.ToString(rnk), null).FirstOrDefault().ToString();
                dateOff = _entities.ExecuteStoreQuery<DateTime>("SELECT bankdate FROM dual", null).FirstOrDefault().ToString("yyyy-MM-dd");
            }
            UserLogin();
            var Maker = ConfigurationManager.AppSettings["ebk.UserName"];
            var serviceUrl = ConfigurationManager.AppSettings["ebk.ApiUriPrivateEn"] +
                         ConfigurationManager.AppSettings["ebk.CloseMethodPrivateEn"] + "?kf=" + kf + "&rnk=" + rnk + "&dateOff=" + dateOff + "&maker=" + Maker;

            var request = WebRequest.Create(serviceUrl);
            request.Method = "PUT";
            string status = "ERROR";
            string err;
            try
            {
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
                        err = string.Format("{0} Помилка закриття картки клієнта он-лайн. <br />Помилка: {1}",
                            _logMessagePrefix, responce.Msg);
                        Logger.Error(err);
                        return status;
                    }

                    Logger.Info(string.Format("{0} Віддалений сервіс успішно виконав команду закриття клієнта RNK={1}",
                        _logMessagePrefix, rnk));

                    return "OK";
                }
            }
            catch (Exception ex)
            {
                err = string.Format("{0} Невідома помилка закриття картки РНК={2}  онлайн:  {1}", _logMessagePrefix, (ex.InnerException != null ? ex.InnerException.Message : ex.Message), rnk);
                Logger.Error(err);
                return status;
            }
            return status;
        }

        public virtual void DeleteGcif(string gcif)
        {
            _entities.ExecuteStoreCommand(
                "begin bars.ebk_dup_request_utl.request_del_gcif(p_gcif => :p_gcif); end; ",
                new OracleParameter("p_gcif", OracleDbType.Varchar2)
                {
                    Value = (gcif)
                }
                );
        }

        public virtual void DeleteGcifs(string[] gcifs)
        {
            foreach (var gcif in gcifs)
            {
                DeleteGcif(gcif);
            }
        }

        public virtual int SavePersonCardsFast(RequestFromEbkV2 request, int allowedCardsPerRequest)
        {
            throw new NotImplementedException();
        }

        public virtual string SynchronizeCard(string kf, decimal rnk)
        {
            throw new NotImplementedException();
        }


        protected virtual List<RelatedPerson> ExtractRelatedPersonList(decimal? rnk)
        {
            var result = _entities.ExecuteStoreQuery<RelatedPerson>(
                "select * from V_EBKC_PRIVATE_ENT_REL where CUST_ID = :p_Rnk", rnk).ToList();
            return result;
        }

        protected virtual decimal GetNextPackNumber()
        {
            return _entities.ExecuteStoreQuery<decimal>("SELECT EBK_PACKAGE_NMBR.NEXTVAL FROM DUAL").SingleOrDefault();
        }

        protected virtual void RemoveCardFromQueue(decimal? rnk, string kf)
        {
            var sqlUpdParams = new object[]
                        {
                            new OracleParameter("p_rnk", OracleDbType.Decimal) {Value = (rnk)},
                            new OracleParameter("p_kf", OracleDbType.Varchar2) {Value = (kf)}
                        };
            _entities.ExecuteStoreCommand("begin EBKC_PACK.DEQUEUE( ebk_wforms_utl.get_rnk(:p_rnk,:p_kf) ); end;",
                sqlUpdParams);
        }

        protected virtual decimal GetNextCardsCount(int packSize, string kf)
        {
            var sqlParams = new object[]
            {
                new OracleParameter("p_Size", OracleDbType.Int16) {Value = packSize},
                new OracleParameter("p_kf", OracleDbType.Varchar2) {Value = kf}
            };
            return _entities.ExecuteStoreQuery<decimal>("select count(*) from v_ebkc_queue_updcard_private where kf = :p_kf and rownum <= :p_Size", sqlParams).SingleOrDefault();
        }

        protected virtual AdvisoryCards ConvertOnlineAdvisoryToAdvisoryCards(OnlineAdvisory card)
        {
            return new AdvisoryCards()
            {
                BatchId = "-1",
                ClientsAnalysis = new ClientAnalysis[] { card.OnlineClientCard.ClientCard },
                Kf = card.OnlineClientCard.ClientCard.Kf,
                Maker = "automatic"
            };
        }

        protected virtual PrivateEnPerson MapPrivateEnData(PrivateEnData planeBody)
        {
            var bodyItem = new PrivateEnPerson();
            bodyItem.Kf = planeBody.Kf;
            bodyItem.Rnk = planeBody.Rnk;
            bodyItem.LastChangeDt = planeBody.LastChangeDt;
            bodyItem.DateOff = planeBody.DateOff;
            bodyItem.DateOn = planeBody.DateOn;
            bodyItem.fullName = planeBody.FullName;
            bodyItem.fullNameInternational = planeBody.FullNameInternational;
            bodyItem.fullNameAbbreviated = planeBody.FullNameAbbreviated;
            bodyItem.K014 = planeBody.K014;
            bodyItem.K040 = planeBody.K040;
            bodyItem.buildStateRegister = planeBody.BuildStateRegister;
            bodyItem.Okpo = planeBody.Okpo;
            bodyItem.IsOkpoExclusion = planeBody.IsOkpoExclusion == "1" ? true : false;
            bodyItem.K060 = planeBody.K060;
            bodyItem.K010 = planeBody.K010;
            bodyItem.Branch = planeBody.Branch;

            bodyItem.economicRegulations = new EconomicRegulations
            {
                K070 = planeBody.K070,
                K080 = planeBody.k080,
                K110 = planeBody.K110,
                K050 = planeBody.K050,
                K051 = planeBody.K051
            };


            bodyItem.LegalAddress = new PrivateEnAddress
            {
                La_Index = planeBody.La_Index,
                La_TerritoryCode = planeBody.La_TerritoryCode,
                La_Region = planeBody.La_Region,
                La_Area = planeBody.La_Area,
                La_Settlement = planeBody.La_Settlement,
                La_Street = planeBody.La_Street,
                La_HouseNumber = planeBody.La_HouseNumber,
                La_SectionNumber = planeBody.La_SectionNumber,
                La_apartmentsNumber = planeBody.La_ApartmentsNumber,
                La_Notes = planeBody.La_Notes
            };

            bodyItem.ActualAddress = new PrivateEnActualAddress
            {
                Aa_Index = planeBody.Aa_Index,
                Aa_territoryCode = planeBody.Aa_TerritoryCode,
                Aa_Region = planeBody.Aa_Region,
                Aa_Area = planeBody.Aa_Area,
                Aa_Settlement = planeBody.Aa_Settlemet,
                Aa_Street = planeBody.Aa_Street,
                Aa_HouseNumber = planeBody.Aa_HouseNumber,
                Aa_SectionNumber = planeBody.Aa_SectionNumber,
                Aa_ApartmentsNumber = planeBody.Aa_ApartmentsNumber,
                Aa_Notes = planeBody.Aa_Notes
            };

            bodyItem.TaxpayersDetail = new PrivateEnTaxpayersDetail
            {
                RegionalPi = planeBody.RegionalPi,
                AreaPi = planeBody.AreaPi,
                AdmRegAuthority = planeBody.AdmRegAuthority,
                AdmRegDate = planeBody.AdmRegDate,
                Piregdate = planeBody.Piregdate,
                AdmRegNumber = planeBody.AdmRegNumber,
                PiRegNumber = planeBody.PiRegNumber,
                TP_K050 = planeBody.TP_K050
            };

            bodyItem.CustomerDetails = new PrivateEnCustomerDetails
            {
                DocType = planeBody.DocType,
                DocSer = planeBody.DocSer,
                DocNumber = planeBody.DocNumber,
                DocOrgan = planeBody.DocOrgan,
                DocIssueDate = planeBody.DocIssueDate,
                ActualDate = planeBody.ActualDate,
                EddrId = planeBody.EddrId,
                BirthDate = planeBody.BirthDate,
                BirthPlace = planeBody.BirthPlace,
                Sex = planeBody.Sex,
                MobilePhone = planeBody.MobilePhone
            };

            bodyItem.AdditionalInformation = new PrivateEnAdditionalInformation
            {
                BorrowerClass = planeBody.BorrowerClass,
                SmallBusinessBelonging = planeBody.SmallBusinessBelonging
            };

            bodyItem.additionalDetails = new PrivateEnAdditionalDetails
            {
                K013 = planeBody.K013,
                GroupAffiliation = planeBody.GroupAffiliation,
                Email = planeBody.Email,
                EmploymentStatus = planeBody.EmploymentStatus
            };


            return bodyItem;
        }

        protected virtual int InternalSaveAdvisory(AdvisoryCards advisory)
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
                        bars.ebkc_pack.request_private_updcard_mass(
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

        protected virtual void UserLogin()
        {
            if (HttpContext.Current.User == null || HttpContext.Current.User.Identity == null || !HttpContext.Current.User.Identity.IsAuthenticated)
            {
                var userName = ConfigurationManager.AppSettings["ebk.UserName"];
                UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);
                var sqlParams = new object[]
                {
                    new OracleParameter("p_sessionid", OracleDbType.Varchar2)
                    {
                        Value = HttpContext.Current.Session.SessionID
                    },
                    new OracleParameter("p_userid", OracleDbType.Decimal) {Value = userMap.user_id},
                    new OracleParameter("p_hostname", OracleDbType.Varchar2) {Value = "localhost"},
                    new OracleParameter("p_appname", OracleDbType.Varchar2) {Value = "barsroot"}
                };
                _entities.ExecuteStoreCommand(
                    "begin bars.bars_login.login_user(:p_sessionid, :p_userid, :p_hostname, :p_appname); end;",
                    sqlParams);

                HttpContext.Current.Session["UserLoggedIn"] = true;
            }
        }
    }
}