using System;
using System.Linq;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using BarsWeb.Core.Logger;
using Bars.WebServices.XRM.Services.DepositXrm.Models;

/// <summary>
/// XRMIntegrationDeposit сервис интеграции с Единым окном (открытие картсчета и депозитного договора + текущего счета в депозитной системе)
/// v 1.4
/// </summary>
/// 
namespace Bars.WebServices.XRM.Services.DepositXrm
{
    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-deposit.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class XRMIntegrationDeposit : BarsWebService
    {
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;
        public XRMIntegrationDeposit()
        {
            moduleName = "XRMIntegrationDeposit";
        }

        #region deposit_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMOpenDepositResult> CreateDepositMethod(XRMOpenDepositReq[] XRMOpenDeposit)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var resList = new List<XRMOpenDepositResult>();
            var DepositRes = new XRMOpenDepositResult();
            try
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    LoginADUserIntSingleCon(con, XRMOpenDeposit[0].UserLogin);

                    foreach (var DepositReq in XRMOpenDeposit)
                    {
                        TransSuccess = TransactionCheck(con, DepositReq.TransactionId, out responseBytes);
                        if (TransSuccess == 0)
                        {
                            TransactionCreate(con, DepositReq.TransactionId, DepositReq.UserLogin, DepositReq.OperationType);
                            DepositRes = DepositXrmWorker.ProcOpenDeposit(DepositReq, con);
                            WriteRequestResponseToLog(con, DepositReq.TransactionId, DepositReq, DepositRes);
                        }
                        else
                        {
                            String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, DepositReq.TransactionId) : String.Format(TransactionErrorMessage, DepositReq.TransactionId);
                            DepositRes = ToResponse<XRMOpenDepositResult>(responseBytes);
                            DepositRes.ResultMessage = errorMsg + "\r" + DepositRes.ResultMessage;
                        }
                        resList.Add(DepositRes);
                    }
                }
            }
            catch (Exception.AutenticationException ex)
            {
                String resultMessage = String.Format("Помилка авторизації: {0}", ex.Message);
                Int32 resultCode = -1;
                decimal? dptId = -1;
                resList.Add(new XRMOpenDepositResult { ResultMessage = resultMessage, ResultCode = resultCode, DptId = dptId });
            }
            catch (System.Exception ex)
            {
                Int32 resultCode = -1;
                String resultMessage = ex.Message;
                resList.Add(new XRMOpenDepositResult { ResultCode = resultCode, ResultMessage = resultMessage });
            }

            return resList;
        }
        #endregion deposit_method

        #region docsign_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMDepositDocResult> DocSignMethod(XRMDepositDoc[] XRMDepositDocs)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var resList = new List<XRMDepositDocResult>();
            var DocSignRes = new XRMDepositDocResult();
            try
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    LoginADUserIntSingleCon(con, XRMDepositDocs[0].UserLogin);

                    foreach (var DocSign in XRMDepositDocs)
                    {
                        TransSuccess = TransactionCheck(con, DocSign.TransactionId, out responseBytes);
                        if (TransSuccess == 0)
                        {
                            TransactionCreate(con, DocSign.TransactionId, DocSign.UserLogin, DocSign.OperationType);
                            DocSignRes = DepositXrmWorker.ProcDocSign(DocSign, con);
                            WriteRequestResponseToLog(con, DocSign.TransactionId, DocSign, DocSignRes);
                        }
                        else
                        {
                            String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, DocSign.TransactionId) : String.Format(TransactionErrorMessage, DocSign.TransactionId);
                            DocSignRes = ToResponse<XRMDepositDocResult>(responseBytes);
                            DocSignRes.ErrMessage = errorMsg + "\r" + DocSignRes.ErrMessage;
                        }
                        resList.Add(DocSignRes);
                    }
                }
            }
            catch (System.Exception ex)
            {
                string errMessage = ex.Message;
                decimal status = -1;
                resList.Add(new XRMDepositDocResult { Status = status, ErrMessage = errMessage });
            }
            return resList;
        }
        #endregion docsign_method

        #region deposit_agreement
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMDepositAgreementResult> CreateDepositAgreement(XRMDepositAgreementReq[] XRMDepositAgrmnt)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var resList = new List<XRMDepositAgreementResult>();
            var CreateDepositAgreementRes = new XRMDepositAgreementResult();
            try
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    LoginADUserIntSingleCon(con, XRMDepositAgrmnt[0].UserLogin);

                    foreach (var XRMDepositAgr in XRMDepositAgrmnt)
                    {
                        TransSuccess = TransactionCheck(con, XRMDepositAgr.TransactionId, out responseBytes);
                        if (TransSuccess == 0)
                        {
                            TransactionCreate(con, XRMDepositAgr.TransactionId, XRMDepositAgr.UserLogin, XRMDepositAgr.OperationType);
                            CreateDepositAgreementRes = DepositXrmWorker.ProcDepositAgreement(XRMDepositAgr, con);
                            WriteRequestResponseToLog(con, XRMDepositAgr.TransactionId, XRMDepositAgr, CreateDepositAgreementRes);
                        }
                        else
                        {
                            String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMDepositAgr.TransactionId) : String.Format(TransactionErrorMessage, XRMDepositAgr.TransactionId);
                            CreateDepositAgreementRes = ToResponse<XRMDepositAgreementResult>(responseBytes);
                            CreateDepositAgreementRes.ErrMessage = errorMsg + "\r" + CreateDepositAgreementRes.ErrMessage;
                        }
                        resList.Add(CreateDepositAgreementRes);
                    }
                }
            }
            catch (System.Exception ex)
            {
                decimal status = -1;
                string errorMessage = ex.Message;
                resList.Add(new XRMDepositAgreementResult { ErrMessage = errorMessage, Status = status });
            }
            return resList;
        }
        #endregion deposit_agreement

        #region deposit_status_file
        /// <summary>
        /// /*формування довідки по депозитному рахунку*/
        /// </summary>
        /// <param name="XRMDepositAccStatusReq"></param>
        /// <returns></returns>
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]

        public XRMDepositFilesRes GetAccountStatusFile(XRMDepositAccStatus XRMDepositAccStatusReq)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var result = new XRMDepositFilesRes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMDepositAccStatusReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMDepositAccStatusReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMDepositAccStatusReq.TransactionId, XRMDepositAccStatusReq.UserLogin, XRMDepositAccStatusReq.OperationType);
                        result.Doc = Convert.ToBase64String(DepositXrmWorker.XRMGetAccStatusFile(XRMDepositAccStatusReq));
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMDepositAccStatusReq.TransactionId) : String.Format(TransactionErrorMessage, XRMDepositAccStatusReq.TransactionId);
                        result = ToResponse<XRMDepositFilesRes>(responseBytes);
                        result.ResultMessage = errorMsg + "\r" + result.ResultMessage;
                        return result;
                    }
                }
                catch (System.Exception ex)
                {
                    result.ResultCode = -1;
                    result.ResultMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, XRMDepositAccStatusReq.TransactionId, XRMDepositAccStatusReq, result);
            }

            return result;
        }
        #endregion deposit_status_file

        #region deposit_extract_file
        /// <summary>
        /// /*формування виписок в нац. і іноз. валютах по депозитному рахунку*/
        /// </summary>
        /// <param name="XRMDepositExtractReq"></param>
        /// <returns></returns>

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDepositFilesRes GetExtractFile(XRMDepositExtract XRMDepositExtractReq)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var result = new XRMDepositFilesRes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    //LoginUserIntSingleCon(con, System.Configuration.ConfigurationManager.AppSettings["XRM_USER"]);
                    LoginUserIntSingleCon(con, XRMDepositExtractReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMDepositExtractReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMDepositExtractReq.TransactionId, XRMDepositExtractReq.UserLogin, XRMDepositExtractReq.OperationType);
                        result.Doc = Convert.ToBase64String(DepositXrmWorker.XRMGetЕxtractFile(XRMDepositExtractReq));
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMDepositExtractReq.TransactionId) : String.Format(TransactionErrorMessage, XRMDepositExtractReq.TransactionId);
                        result = ToResponse<XRMDepositFilesRes>(responseBytes);
                        result.ResultMessage = errorMsg + "\r" + result.ResultMessage;
                        return result;
                    }
                }
                catch (System.Exception ex)
                {
                    result.ResultCode = -1;
                    result.ResultMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, XRMDepositExtractReq.TransactionId, XRMDepositExtractReq, result);
            }

            return result;
        }
        #endregion deposit_extract_file

        #region requests
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDptRequestRes RequestCreateMethod(XRMDptRequestReq XRMRequest)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var DptRequestRes = new XRMDptRequestRes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMRequest.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMRequest.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMRequest.TransactionId, XRMRequest.UserLogin, XRMRequest.OperationType);
                        DptRequestRes = DepositXrmWorker.RequestCreate(con, XRMRequest);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMRequest.TransactionId) : String.Format(TransactionErrorMessage, XRMRequest.TransactionId);
                        DptRequestRes = ToResponse<XRMDptRequestRes>(responseBytes);
                        DptRequestRes.ErrMessage = errorMsg + "\r" + DptRequestRes.ErrMessage;
                        return DptRequestRes;
                    }
                }
                catch (System.Exception ex)
                {
                    DptRequestRes.Status = -1;
                    DptRequestRes.ErrMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, XRMRequest.TransactionId, XRMRequest, DptRequestRes);
            }

            return DptRequestRes;
        }
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDptRequestStateRes GetRequestStateMethod(XRMDptRequestStateReq XRMRequestStateReq)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var DptRequestStateRes = new XRMDptRequestStateRes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMRequestStateReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMRequestStateReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMRequestStateReq.TransactionId, XRMRequestStateReq.UserLogin, XRMRequestStateReq.OperationType);
                        DptRequestStateRes = DepositXrmWorker.GetRequestState(XRMRequestStateReq, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMRequestStateReq.TransactionId) : String.Format(TransactionErrorMessage, XRMRequestStateReq.TransactionId);
                        DptRequestStateRes = ToResponse<XRMDptRequestStateRes>(responseBytes);
                        DptRequestStateRes.ErrMessage = errorMsg + "\r" + DptRequestStateRes.ErrMessage;
                        return DptRequestStateRes;
                    }
                }
                catch (System.Exception ex)
                {
                    DptRequestStateRes.Status = -1;
                    DptRequestStateRes.ErrMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, XRMRequestStateReq.TransactionId, XRMRequestStateReq, DptRequestStateRes);
            }

            return DptRequestStateRes;
        }

        #endregion requests

        #region deposit_add_agreement
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDepositAdditionalAgreementRes GetAdditionalAgreement(XRMDepositAdditionalAgreementReq request)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var result = new XRMDepositAdditionalAgreementRes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, request.UserLogin);

                    TransSuccess = TransactionCheck(con, request.TransactionId, out responseBytes);

                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, request.TransactionId, request.UserLogin, request.OperationType);
                        result.Doc = Convert.ToBase64String(DepositXrmWorker.GetDepositAdditionalAgreement(request));
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, request.TransactionId) : String.Format(TransactionErrorMessage, request.TransactionId);
                        result = ToResponse<XRMDepositAdditionalAgreementRes>(responseBytes);
                        result.ResultMessage = errorMsg + "\r" + result.ResultMessage;
                        return result;
                    }
                }
                catch (System.Exception ex)
                {
                    result.ResultCode = -1;
                    result.ResultMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, request.TransactionId, request, result);
            }

            return result;
        }
        #endregion deposit_add_agreement

        #region earlyClose    
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMEarlyCloseRes GetEarlyCloseMethod(XRMEarlyCloseReq XRMEarlyCloseReq)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var XRMEarlyCloseRes = new XRMEarlyCloseRes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMEarlyCloseReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMEarlyCloseReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMEarlyCloseReq.TransactionId, XRMEarlyCloseReq.UserLogin, XRMEarlyCloseReq.OperationType);
                        XRMEarlyCloseRes = DepositXrmWorker.GetEarlyTerminationParams(XRMEarlyCloseReq, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMEarlyCloseReq.TransactionId) : String.Format(TransactionErrorMessage, XRMEarlyCloseReq.TransactionId);
                        XRMEarlyCloseRes = ToResponse<XRMEarlyCloseRes>(responseBytes);
                        XRMEarlyCloseRes.ErrMessage = errorMsg + "\r" + XRMEarlyCloseRes.ErrMessage;
                        return XRMEarlyCloseRes;
                    }
                }
                catch (System.Exception ex)
                {
                    XRMEarlyCloseRes.Status = -1;
                    XRMEarlyCloseRes.ErrMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, XRMEarlyCloseReq.TransactionId, XRMEarlyCloseReq, XRMEarlyCloseRes);
            }

            return XRMEarlyCloseRes;
        }
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMEarlyCloseRunRes RunEarlyCloseMethod(XRMEarlyCloseReq XRMEarlyCloseReq)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var XRMEarlyCloseRunRes = new XRMEarlyCloseRunRes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMEarlyCloseReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMEarlyCloseReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMEarlyCloseReq.TransactionId, XRMEarlyCloseReq.UserLogin, XRMEarlyCloseReq.OperationType);
                        XRMEarlyCloseRunRes = DepositXrmWorker.RunEarlyTermination(XRMEarlyCloseReq, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMEarlyCloseReq.TransactionId) : String.Format(TransactionErrorMessage, XRMEarlyCloseReq.TransactionId);
                        XRMEarlyCloseRunRes = ToResponse<XRMEarlyCloseRunRes>(responseBytes);
                        XRMEarlyCloseRunRes.ErrMessage = errorMsg + "\r" + XRMEarlyCloseRunRes.ErrMessage;
                        return XRMEarlyCloseRunRes;
                    }
                }
                catch (System.Exception ex)
                {
                    XRMEarlyCloseRunRes.Status = -1;
                    XRMEarlyCloseRunRes.ErrMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, XRMEarlyCloseReq.TransactionId, XRMEarlyCloseReq, XRMEarlyCloseRunRes);
            }

            return XRMEarlyCloseRunRes;
        }
        #endregion earlyClose

        #region portfolio
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDPTPortfolioResponce GetDPTPortfolioMethod(XRMDPTPortfolioRequest XRMDPTPortfolioRequest)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var XRMDPTPortfolioResponce = new XRMDPTPortfolioResponce();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMDPTPortfolioRequest.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMDPTPortfolioRequest.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMDPTPortfolioRequest.TransactionId, XRMDPTPortfolioRequest.UserLogin, XRMDPTPortfolioRequest.OperationType);
                        XRMDPTPortfolioResponce.XRMDPTPortfolioRec = DepositXrmWorker.GetPortfolio(XRMDPTPortfolioRequest.RNK, con).ToArray();
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMDPTPortfolioRequest.TransactionId) : String.Format(TransactionErrorMessage, XRMDPTPortfolioRequest.TransactionId);
                        XRMDPTPortfolioResponce = ToResponse<XRMDPTPortfolioResponce>(responseBytes);
                        XRMDPTPortfolioResponce.ResultMessage = errorMsg + "\r" + XRMDPTPortfolioResponce.ResultMessage;
                        return XRMDPTPortfolioResponce;
                    }
                }
                catch (System.Exception ex)
                {
                    XRMDPTPortfolioResponce.ResultCode = -1;
                    XRMDPTPortfolioResponce.ResultMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, XRMDPTPortfolioRequest.TransactionId, XRMDPTPortfolioRequest, XRMDPTPortfolioResponce);
            }

            return XRMDPTPortfolioResponce;
        }
        #endregion portfolio

        #region dpt_products 
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMDepositProduct[] GetDPTProductsMethod()
        {
            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                LoginUserIntSingleCon(con, System.Configuration.ConfigurationManager.AppSettings["XRM_USER"], false);
                return DepositXrmWorker.GetDepositProducts(con);
            }
        }
        #endregion dpt_products

        #region BackOffice
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public AccessRequestRes BackOfficeAccessRequest(AccessRequestReq req)
        {
            Decimal transSuccess = 0;
            Byte[] responseBytes;
            var res = new AccessRequestRes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, req.UserLogin);

                    transSuccess = TransactionCheck(con, req.TransactionId, out responseBytes);
                    if (transSuccess == 0)
                    {
                        TransactionCreate(con, req.TransactionId, req.UserLogin, req.OperationType);
                        res = DepositXrmWorker.CreateAccessRequestProc(con, req);
                    }
                    else
                    {
                        String errorMsg = transSuccess == -1 ? String.Format(TransactionExistsMessage, req.TransactionId) : String.Format(TransactionErrorMessage, req.TransactionId);
                        res = ToResponse<AccessRequestRes>(responseBytes);
                        res.ResultMessage = errorMsg + "\r" + res.ResultMessage;
                        return res;
                    }
                }
                catch (System.Exception ex)
                {
                    res = new AccessRequestRes { ResultCode = -1, ResultMessage = "Error: " + ex.Message };
                }
                WriteRequestResponseToLog(con, req.TransactionId, req, res);
            }

            return res;
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public BackOfficeGetAccessRes BackOfficeGetAccess(BackOfficeGetAccessReq req)
        {
            Decimal transSuccess = 0;
            Byte[] responseBytes;
            var res = new BackOfficeGetAccessRes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, req.UserLogin);

                    transSuccess = TransactionCheck(con, req.TransactionId, out responseBytes);
                    if (transSuccess == 0)
                    {
                        TransactionCreate(con, req.TransactionId, req.UserLogin, req.OperationType);
                        res = DepositXrmWorker.BackOfficeProc(con, req);
                    }
                    else
                    {
                        String errorMsg = transSuccess == -1 ? String.Format(TransactionExistsMessage, req.TransactionId) : String.Format(TransactionErrorMessage, req.TransactionId);
                        res = ToResponse<BackOfficeGetAccessRes>(responseBytes);
                        res.ResultMessage = errorMsg + "\r" + res.ResultMessage;
                        return res;
                    }
                }
                catch (System.Exception ex)
                {
                    res = new BackOfficeGetAccessRes { ResultCode = -1, ResultMessage = "Error: " + ex.Message };
                }
                WriteRequestResponseToLog(con, req.TransactionId, req, res);
            }

            return res;
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public BackOfficeGetStateProcRes BackOfficeGetState(BackOfficeGetStateProcReq req)
        {
            Decimal transSuccess = 0;
            Byte[] responseBytes;
            var res = new BackOfficeGetStateProcRes();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, req.UserLogin);

                    transSuccess = TransactionCheck(con, req.TransactionId, out responseBytes);
                    if (transSuccess == 0)
                    {
                        TransactionCreate(con, req.TransactionId, req.UserLogin, req.OperationType);
                        res = DepositXrmWorker.BackOfficeGetStateProc(con, req);
                    }
                    else
                    {
                        String errorMsg = transSuccess == -1 ? String.Format(TransactionExistsMessage, req.TransactionId) : String.Format(TransactionErrorMessage, req.TransactionId);
                        res = ToResponse<BackOfficeGetStateProcRes>(responseBytes);
                        res.ResultMessage = errorMsg + "\r" + res.ResultMessage;
                        return res;
                    }
                }
                catch (System.Exception ex)
                {
                    res = new BackOfficeGetStateProcRes { ResultCode = -1, ResultMessage = "Error: " + ex.Message };
                }
                WriteRequestResponseToLog(con, req.TransactionId, req, res);
            }

            return res;
        }
        //null - ще не опрацьований бек-офісом, 2 - анульований
        #endregion BackOffice
    }
}
