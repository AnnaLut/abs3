using System;
using System.Web.Services;
using System.Web.Services.Protocols;
using Oracle.DataAccess.Client;
using BarsWeb.Core.Logger;
using System.Collections.Generic;
using Bars.WebServices.XRM.Services.Customer.Models;

/// <summary>
/// XRMIntegrationCustomer сервис интеграции с Единым окном
/// </summary>
/// 
namespace Bars.WebServices.XRM.Services.Customer
{
    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-cust.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class XRMIntegrationCustomer : XrmBaseWebService
    {
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;
        private const decimal ErrorResCode = -1;
        public XRMIntegrationCustomer()
        {
            moduleName = "XRMIntegrationCustomer";
        }

        #region Methods
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<SetClient> SetClientMethod(SetClient[] Clients)
        {
            var SetClientResponse = new SetClient();
            var SetClientResponseSet = new List<SetClient>();
            try
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    LoginADUserIntSingleCon(con, Clients[0].UserLogin);

                    foreach (var ClientsReq in Clients)
                    {
                        Byte[] responseBytes;
                        decimal TransSuccess = TransactionCheck(con, ClientsReq.TransactionId, out responseBytes);
                        if (TransSuccess == 0)
                        {
                            TransactionCreate(con, ClientsReq.TransactionId, ClientsReq.UserLogin, ClientsReq.OperationType);

                            SetClientResponse = CustomerWorker.CreateCustomer(ClientsReq, con);
                            WriteRequestResponseToLog(con, ClientsReq.TransactionId, ClientsReq, SetClientResponse);
                        }
                        else
                        {
                            if (TransSuccess == -1 && null == responseBytes)
                            {
                                String errorMsg = string.Format(TransactionInProgress, ClientsReq.TransactionId);
                                SetClientResponse = new SetClient { ErrorCode = errorMsg };
                            }
                            else
                            {
                                String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, ClientsReq.TransactionId) : String.Format(TransactionErrorMessage, ClientsReq.TransactionId);
                                SetClientResponse = ToResponse<SetClient>(responseBytes);
                                SetClientResponse.ErrorCode = errorMsg + "\r" + SetClientResponse.ErrorCode;
                            }
                        }
                        SetClientResponseSet.Add(SetClientResponse);
                    }
                }
            }
            catch (System.Exception ex)
            {
                string errMsg = (ex is Exception.AutenticationException) ? String.Format("Помилка авторизації: {0}", ex.Message) : String.Format("Помилка виконання реєстрації/оновлення: {0}", ex.Message);

                SetClientResponse.ErrorCode = errMsg;
                SetClientResponse.Status = ErrorResCode;
                SetClientResponse.RNK = -1;
                SetClientResponseSet.Add(SetClientResponse);
            }

            return SetClientResponseSet;
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public SetVerifiedClient SetVerifiedClient(SetVerifiedClient VCust)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, VCust.UserLogin);

                    TransSuccess = TransactionCheck(con, VCust.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, VCust.TransactionId, VCust.UserLogin, VCust.OperationType);
                        VCust = CustomerWorker.SetVirified(VCust, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, VCust.TransactionId) : String.Format(TransactionErrorMessage, VCust.TransactionId);
                        VCust = ToResponse<SetVerifiedClient>(responseBytes);
                        VCust.ErrorCode = errorMsg + "\r" + VCust.ErrorCode;
                        return VCust;
                    }
                }
                catch (Exception.AutenticationException aex)
                {
                    VCust.ErrorCode = String.Format("Помилка авторизації: {0}", aex.Message);
                }
                catch (System.Exception ex)
                {
                    VCust.ErrorCode = String.Format("Помилка виконання установки Документи перевірено: {0}", ex.Message);
                }
                WriteRequestResponseToLog(con, VCust.TransactionId, VCust, VCust);
            }

            return VCust;
        }
        #endregion Methods
    }

}