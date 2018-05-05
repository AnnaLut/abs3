using System;
using System.Data;
using System.Web.Services;
using System.Web.Services.Protocols;
using Oracle.DataAccess.Client;
using BarsWeb.Core.Logger;
using System.Xml;
using System.Collections.Generic;
using System.Xml.Serialization;
using Bars.WebServices.XRM.Services.Card;
using Bars.WebServices.XRM.Models;
using Bars.WebServices.XRM.Services.Card.Models;

/// <summary>
/// XRMIntegrationCar сервис интеграции с Единым окном (открытие картсчета и депозитного договора)
/// v. 2017-01-30 + XRMCardCreditReq, XRMCardCreditRes
/// </summary>
/// 
namespace Bars.WebServices.XRM.Services.Card
{
    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-card.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class XRMIntegrationCard : BarsWebService
    {
        private const int ErrorResCode = -1;
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;
        static Dictionary<string, int> kfru;

        public static int Kfru(string _mfo)
        {
            if (kfru == null)
                kfru = new Dictionary<string, int>();

            if (kfru.Count == 0)
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                using (OracleCommand command = con.CreateCommand())
                {
                    command.CommandText = "select kf, to_number(ru) ru from kf_ru";
                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        int kf_index = reader.GetOrdinal("KF");
                        int ru_index = reader.GetOrdinal("RU");
                        if (!reader.HasRows) throw new System.Exception("Невдалося визначити код регіону");
                        while (reader.Read())
                        {
                            kfru[reader.GetString(kf_index)] = reader.GetInt32(ru_index);
                        }
                    }
                }
            }

            if (kfru.ContainsKey(_mfo))
                return kfru[_mfo];

            return 0;

        }
        public XRMIntegrationCard()
        {
            moduleName = "XRMIntegrationCard";
        }

        #region card_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMOpenCardResult> CreateCardMethod(XRMOpenCardReq[] XRMOpenCard)
        {
            List<XRMOpenCardResult> resList = new List<XRMOpenCardResult>();
            try
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    LoginADUserIntSingleCon(con, XRMOpenCard[0].UserLogin);
                    foreach (var CardReq in XRMOpenCard)
                    {
                        XRMOpenCardResult CardRes = new XRMOpenCardResult();
                        Byte[] responseBytes = null;
                        try
                        {
                            ProcessTransactions(con, CardReq.TransactionId, CardReq.UserLogin, CardReq.OperationType, out responseBytes, moduleName);

                            if (null != responseBytes)
                            {
                                String errorMsg = String.Format(TransactionExistsMessage, CardReq.TransactionId);
                                CardRes = ToResponse<XRMOpenCardResult>(responseBytes);
                                CardRes.ResultMessage = errorMsg + "\r" + CardRes.ResultMessage;
                            }
                            else
                            {
                                CardRes = CardWorker.ProcOpenCard(CardReq, con);
                                WriteRequestResponseToLog(con, CardReq.TransactionId, CardReq, CardRes);
                            }
                        }
                        catch (System.Exception e)
                        {
                            CardRes.ResultMessage = e.Message;
                            CardRes.ResultCode = ErrorResCode;
                        }
                        resList.Add(CardRes);
                    }
                }
            }
            catch (System.Exception ex)
            {
                resList.Add(new XRMOpenCardResult
                {
                    ResultMessage = (ex is Exception.AutenticationException) ? String.Format("Помилка авторизації: {0}", ex.Message) : ex.Message,
                    ResultCode = ErrorResCode,
                    nd = -1
                });
            }

            return resList;
        }
        #endregion card_method

        #region getInstantDict
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMInstantDict> GetInstantDictMethod()
        {
            var XRMInstantDictionary = new List<XRMInstantDict>();
            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginUserIntSingleCon(con, System.Configuration.ConfigurationManager.AppSettings["XRM_USER"], false);
                    XRMInstantDictionary = CardWorker.XRMGetInstantDict(con);
                }
                catch { }
            }
            return XRMInstantDictionary;
        }
        #endregion getInstantDict

        #region OrderInstant
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMInstantList> OrderInstant(XRMInstantOrderReq XRMInstantOrderReq)
        {
            var XRMInstantList = new XRMInstantList();
            var XRMInstantListSet = new List<XRMInstantList>();
            decimal TransSuccess = 0;
            Byte[] responseBytes;

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMInstantOrderReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMInstantOrderReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMInstantOrderReq.TransactionId, XRMInstantOrderReq.UserLogin, XRMInstantOrderReq.OperationType);
                        XRMInstantListSet = CardWorker.OrderInstant(XRMInstantOrderReq.TransactionId, XRMInstantOrderReq.CardCode, XRMInstantOrderReq.Branch, XRMInstantOrderReq.CardCount, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMInstantOrderReq.TransactionId) : String.Format(TransactionErrorMessage, XRMInstantOrderReq.TransactionId);
                        XRMInstantListSet = ToResponse<List<XRMInstantList>>(responseBytes);
                        foreach (var itemRes in XRMInstantListSet)
                        {
                            itemRes.ErrorMessage = errorMsg + "\r" + itemRes.ErrorMessage;
                        }
                        return XRMInstantListSet;
                    }
                }
                catch (Exception.AutenticationException ex)
                {
                    XRMInstantList.ErrorMessage = ex.Message;
                    XRMInstantListSet.Add(XRMInstantList);
                }

                WriteRequestResponseToLog(con, XRMInstantOrderReq.TransactionId, XRMInstantOrderReq, XRMInstantListSet);
            }

            return XRMInstantListSet;
        }
        #endregion OrderInstant

        #region CardParams
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        //public List<XRMCardParam> SetCardParam(XRMCardParams XRMCardParamReq)
        public XRMResponseDetailed<List<XRMCardParam>> SetCardParam(XRMCardParams XRMCardParamReq)
        {
            var response = new XRMResponseDetailed<List<XRMCardParam>>() { Results = new List<XRMCardParam>() };
            decimal TransSuccess = 0;
            Byte[] responseBytes;

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMCardParamReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMCardParamReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMCardParamReq.TransactionId, XRMCardParamReq.UserLogin, XRMCardParamReq.OperationType);
                        response.Results = CardWorker.SetGetCardParam(XRMCardParamReq.TransactionId, XRMCardParamReq, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMCardParamReq.TransactionId) : String.Format(TransactionErrorMessage, XRMCardParamReq.TransactionId);
                        response = ToResponse<XRMResponseDetailed<List<XRMCardParam>>>(responseBytes);
                        response.ResultMessage = errorMsg + "\r" + response.ResultMessage;
                    }
                }
                catch (System.Exception ex)
                {
                    response.ResultCode = -1;
                    response.ResultMessage = ex.Message;
                }

                WriteRequestResponseToLog(con, XRMCardParamReq.TransactionId, XRMCardParamReq, response);
            }

            return response;
        }
        #endregion CardParams

        #region CardCreditParams+Print
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMCardCreditRes SetCardCreditParam(XRMCardCreditReq XRMCardCreditReq)
        {
            var XRMCardCreditRes = new XRMCardCreditRes();
            decimal TransSuccess = 0;
            Byte[] responseBytes;

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMCardCreditReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMCardCreditReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        int k_ru = Kfru(XRMCardCreditReq.KF.ToString());
                        for (int i = 0; i < XRMCardCreditReq.acc.Length; i++)
                        {
                            XRMCardCreditReq.acc[i] = XRMCardCreditReq.acc[i] * 100 + k_ru;
                        }
                        TransactionCreate(con, XRMCardCreditReq.TransactionId, XRMCardCreditReq.UserLogin, XRMCardCreditReq.OperationType);
                        XRMCardCreditRes = CardWorker.SetCardCredit(XRMCardCreditReq, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMCardCreditReq.TransactionId) : String.Format(TransactionErrorMessage, XRMCardCreditReq.TransactionId);
                        XRMCardCreditRes = ToResponse<XRMCardCreditRes>(responseBytes);
                        XRMCardCreditRes.ResultMessage = errorMsg + "\r" + XRMCardCreditRes.ResultMessage;
                        return XRMCardCreditRes;
                    }
                }
                catch (System.Exception ex)
                {
                    XRMCardCreditRes.ResultMessage = ex.Message;
                    XRMCardCreditRes.ResultCode = -1;
                }
                WriteRequestResponseToLog(con, XRMCardCreditReq.TransactionId, XRMCardCreditReq, XRMCardCreditRes);
            }

            return XRMCardCreditRes;
        }
        #endregion CardCreditParams+Print

        #region BulkCard
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMBulkCardRes BulkCardMethod(XRMBulkCardReq XRMBulkCardReq)
        {
            var XRMBulkCardRes = new XRMBulkCardRes();
            decimal TransSuccess = 0;
            Byte[] responseBytes;

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMBulkCardReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMBulkCardReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMBulkCardReq.TransactionId, XRMBulkCardReq.UserLogin, XRMBulkCardReq.OperationType);
                        XRMBulkCardRes = CardWorker.XRMBulkCardProc(XRMBulkCardReq, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMBulkCardReq.TransactionId) : String.Format(TransactionErrorMessage, XRMBulkCardReq.TransactionId);
                        XRMBulkCardRes = ToResponse<XRMBulkCardRes>(responseBytes);
                        XRMBulkCardRes.ResultMessage = errorMsg + "\r" + XRMBulkCardRes.ResultMessage;
                        return XRMBulkCardRes;
                    }
                }
                catch (System.Exception ex)
                {
                    XRMBulkCardRes.ResultMessage = ex.Message;
                    XRMBulkCardRes.ResultCode = -1;
                }
                WriteRequestResponseToLog(con, XRMBulkCardReq.TransactionId, XRMBulkCardReq, XRMBulkCardRes);
            }

            return XRMBulkCardRes;
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMBulkCardTicketRes GetBulkCardTicketMethod(XRMBulkCardTicketReq XRMBulkCardTicketReq)
        {
            var XRMBulkCardTicketRes = new XRMBulkCardTicketRes();
            decimal TransSuccess = 0;
            Byte[] responseBytes;

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMBulkCardTicketReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMBulkCardTicketReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMBulkCardTicketReq.TransactionId, XRMBulkCardTicketReq.UserLogin, XRMBulkCardTicketReq.OperationType);
                        XRMBulkCardTicketRes = CardWorker.XRMBulkCardTicket(XRMBulkCardTicketReq, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMBulkCardTicketReq.TransactionId) : String.Format(TransactionErrorMessage, XRMBulkCardTicketReq.TransactionId);
                        XRMBulkCardTicketRes = ToResponse<XRMBulkCardTicketRes>(responseBytes);
                        XRMBulkCardTicketRes.ResultMessage = errorMsg + "\r\n" + XRMBulkCardTicketRes.ResultMessage;
                        return XRMBulkCardTicketRes;
                    }
                }
                catch (System.Exception ex)
                {
                    XRMBulkCardTicketRes.ResultMessage = ex.Message;
                    XRMBulkCardTicketRes.ResultCode = -1;
                }
                WriteRequestResponseToLog(con, XRMBulkCardTicketReq.TransactionId, XRMBulkCardTicketReq, XRMBulkCardTicketRes);
            }

            return XRMBulkCardTicketRes;
        }
        #endregion BulkCard

        #region DKBO
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMDKBORes MapDKBOMethod(XRMDKBOReq Request)
        {
            Decimal TransSuccess = 0;
            var Response = new XRMDKBORes()
            {
                Results = new List<XRMDKBOResInner>(),
                TransactionId = Request.TransactionId
            };
            Byte[] responseBytes;

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, Request.UserLogin);

                    TransSuccess = TransactionCheck(con, Request.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, Request.TransactionId, Request.UserLogin, Request.OperationType);
                        foreach (var reqItem in Request.Data)
                        {
                            Response.Results.Add(CardWorker.MapToDKBO(reqItem, Request.TransactionId, con));
                        }
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, Request.TransactionId) : String.Format(TransactionErrorMessage, Request.TransactionId);
                        Response = ToResponse<XRMDKBORes>(responseBytes);
                        if (Response.Results == null)
                            Response.Results = new List<XRMDKBOResInner>();
                        foreach (var resItem in Response.Results)
                        {
                            resItem.ResultMessage = errorMsg + "\r" + resItem.ResultMessage;
                        }
                        return Response;
                    }
                }
                catch (System.Exception ex)
                {
                    Response.Results.Add(new XRMDKBOResInner { ResultMessage = ex.Message, ResultCode = -1 });
                }
                WriteRequestResponseToLog(con, Request.TransactionId, Request, Response);
            }

            return Response;
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMQuestionnaireDKBORes QuestionnaireDKBO(XRMQuestionnaireDKBOReq xrmQuestionnaireDKBOReq)
        {
            Decimal TransSuccess = 0;
            Byte[] responseBytes;

            var xrmQuestionnaireDKBORes = new XRMQuestionnaireDKBORes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, xrmQuestionnaireDKBOReq.UserLogin);

                    TransSuccess = TransactionCheck(con, xrmQuestionnaireDKBOReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, xrmQuestionnaireDKBOReq.TransactionId, xrmQuestionnaireDKBOReq.UserLogin, xrmQuestionnaireDKBOReq.OperationType);
                        xrmQuestionnaireDKBORes = CardWorker.QuestionnaireDKBOMethod(xrmQuestionnaireDKBOReq, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, xrmQuestionnaireDKBOReq.TransactionId) : String.Format(TransactionErrorMessage, xrmQuestionnaireDKBOReq.TransactionId);
                        xrmQuestionnaireDKBORes = ToResponse<XRMQuestionnaireDKBORes>(responseBytes);
                        xrmQuestionnaireDKBORes.ResultMessage = errorMsg + "\r" + xrmQuestionnaireDKBORes.ResultMessage;
                        return xrmQuestionnaireDKBORes;
                    }
                }
                catch (System.Exception ex)
                {
                    xrmQuestionnaireDKBORes.ResultCode = -1;
                    xrmQuestionnaireDKBORes.ResultMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, xrmQuestionnaireDKBOReq.TransactionId, xrmQuestionnaireDKBOReq, xrmQuestionnaireDKBORes);
            }

            return xrmQuestionnaireDKBORes;
        }
        #endregion DKBO

        #region ArrestAcc
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMArrestAccRes ArrestAcc(XRMArrestAccReq XRMArrestAccReq)
        {
            var result = new XRMArrestAccRes();
            Decimal TransSuccess = 0;
            Byte[] responseBytes;

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMArrestAccReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMArrestAccReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMArrestAccReq.TransactionId, XRMArrestAccReq.UserLogin);
                        result = CardWorker.ArestAccMethod(con, XRMArrestAccReq);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMArrestAccReq.TransactionId) : String.Format(TransactionErrorMessage, XRMArrestAccReq.TransactionId);
                        result = ToResponse<XRMArrestAccRes>(responseBytes);
                        result.message = errorMsg + "\r" + result.message;
                        return result;
                    }
                }
                catch (System.Exception ex)
                {
                    result.status = "ERROR";
                    result.message = ex.Message;
                }
                WriteRequestResponseToLog(con, XRMArrestAccReq.TransactionId, XRMArrestAccReq, result);
            }

            return result;
        }
        #endregion DKBO
    }
}

