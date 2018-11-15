using System;
using System.Linq;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using BarsWeb.Core.Logger;
using Bars.WebServices.XRM.Services.DepositXrm.Models;
using Bars.WebServices.XRM.Models;
using System.Xml.Serialization;

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
    public class Deposit : XrmBaseWebService
    {
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;
        public Deposit()
        {
            moduleName = "XRMIntegrationDeposit";
        }

        #region deposit_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<OpenDepositResponse> CreateDeposit(XRMRequest<OpenDepositRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.OpenDeposit);
        }
        #endregion deposit_method

        #region docsign_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public SignDocumentsResponse DocSignMethod(SignDepositDocumentsRequest Request)
        {
            var result = new SignDocumentsResponse { Documents = new List<DocumentSignResult>() };
            var DocSignRes = new DocumentSignResult();
            try
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    LoginADUserIntSingleCon(con, Request.UserLogin);

                    foreach (DepositDocument DocSign in Request.Documents)
                    {
                        byte[] transResp = null;
                        int transactionCheckResp = ProcessTransactions(con, DocSign.TransactionId, Request.UserLogin, null, out transResp, moduleName);

                        if (new List<int> { -1, -2 }.Contains(transactionCheckResp))
                        {
                            DocumentSignResult r = -1 == transactionCheckResp ? ToResponse<DocumentSignResult>(transResp) : new DocumentSignResult();
                            r.ResultCode = -1 == transactionCheckResp ? 0 : 1;

                            r.ResultMessage = -1 == transactionCheckResp ?
                                 string.Format("Транзакція номер {0} вже була проведена \r{1}", DocSign.TransactionId, r.ResultMessage)
                                : string.Format("Транзакція номер {0} вже була проведена, але обробка ще не завершилась", DocSign.TransactionId);

                            result.Documents.Add(r);
                        }
                        else
                        {
                            DocSignRes = DepositWorker.ProcDocSign(DocSign, con);
                            WriteRequestResponseToLog(con, DocSign.TransactionId, DocSign, DocSignRes);
                            result.Documents.Add(DocSignRes);
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                result.ResultCode = -1;
                result.ResultMessage = ex.Message;
            }
            return result;
        }
        #endregion docsign_method

        #region deposit_agreement
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<DepositAgreementRsponse> CreateDepositAgreement(XRMRequest<DepositAgreementRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.ProcDepositAgreement);
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
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<FilesResponse> GetAccountStatusFile(XRMRequest<AccStatusRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.GetAccStatusFile);
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
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<FilesResponse> GetExtractFile(XRMRequest<ExtractFileRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.GetЕxtractFile);
        }
        #endregion deposit_extract_file

        #region requests
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<RequestCreateResponse> RequestCreate(XRMRequest<RequestCreateRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.RequestCreate);
        }
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<RequestStateResponse> GetRequestState(XRMRequest<RequestStateRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.GetRequestState);
        }

        #endregion requests

        #region deposit_add_agreement
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<AdditionalAgreementResponse> GetAdditionalAgreement(XRMRequest<AdditionalAgreementRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.GetDepositAdditionalAgreement);
        }
        #endregion deposit_add_agreement

        #region earlyClose    
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<EarlyCloseResponse> GetEarlyClose(XRMRequest<EarlyCloseRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.GetEarlyTerminationParams);
        }
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<EarlyCloseRunResponse> RunEarlyClose(XRMRequest<EarlyCloseRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.RunEarlyTermination);
        }
        #endregion earlyClose

        #region portfolio
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<PortfolioRecord[]> GetDPTPortfolio(XRMRequest<PortfolioRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.GetPortfolio);
        }
        #endregion portfolio

        #region dpt_products 
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<List<Product>> GetDPTProducts()
        {
            try
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    LoginUserIntSingleCon(con, System.Configuration.ConfigurationManager.AppSettings["XRM_USER"], false);
                    return DepositWorker.GetDepositProducts(con);
                }
            }
            catch (System.Exception ex)
            {
                return ProcessException<XRMResponseDetailed<List<Product>>>(ex);
            }
        }
        #endregion dpt_products

        #region BackOffice
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<BOAccessResponse> BackOfficeAccessRequest(XRMRequest<BOAccessRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.CreateAccessRequest);
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponse BackOfficeGetAccess(XRMRequest<BOGetAccessRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.BackOfficeProc);
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        [return: XmlElement(ElementName = "Response")]
        public XRMResponseDetailed<BOGetStateResponse> BackOfficeGetState(XRMRequest<BOGetStateRequest> Request)
        {
            return ExecuteMethod(Request, DepositWorker.BackOfficeGetStateProc);
        }
        //null - ще не опрацьований бек-офісом, 2 - анульований
        #endregion BackOffice
    }
}
