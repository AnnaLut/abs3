using System;
using System.IO;
using System.Data;
using System.Web.Services;
using System.Web.Services.Protocols;
using Oracle.DataAccess.Client;
using BarsWeb.Core.Logger;
using Oracle.DataAccess.Types;
using System.Collections.Generic;
using Bars.WebServices.XRM.Services.RegPayments;
using Bars.WebServices.XRM.Services.RegPayments.Models;

/// <summary>
/// XRMIntegrationRegPay сервис интеграции с Единым окном (регулярные платежи)
/// </summary>
/// 
namespace Bars.WebServices.XRM.Services.RegPayments
{
    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-regular.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class XRMIntegrationRegPay : BarsWebService
    {
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;
        public XRMIntegrationRegPay()
        {
            moduleName = "XRMIntegrationRegPay";
        }

        #region create_regpay_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMRegPayResult> CreateRegPayMethod(XRMRegPayReq[] XRMRegPay)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var resList = new List<XRMRegPayResult>();
            var RegPayRes = new XRMRegPayResult();
            try
            {
                try
                {
                    using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                    {
                        LoginADUserIntSingleCon(con, XRMRegPay[0].UserLogin);

                        foreach (var RegPayReq in XRMRegPay)
                        {
                            TransSuccess = TransactionCheck(con, RegPayReq.TransactionId, out responseBytes);
                            if (TransSuccess == 0)
                            {
                                TransactionCreate(con, RegPayReq.TransactionId, RegPayReq.UserLogin, RegPayReq.OperationType);
                                RegPayRes = RegPaymentsWorker.ProcCreateRegPay(RegPayReq, null, con);
                                WriteRequestResponseToLog(con, RegPayReq.TransactionId, RegPayReq, RegPayRes);
                            }
                            else
                            {
                                String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, RegPayReq.TransactionId) : String.Format(TransactionErrorMessage, RegPayReq.TransactionId);
                                RegPayRes = ToResponse<XRMRegPayResult>(responseBytes);
                                RegPayRes.ResultMessage = errorMsg + "\r" + RegPayRes.ResultMessage;
                            }
                            resList.Add(RegPayRes);
                        }
                    }
                }
                catch (System.Exception ex)
                {
                    String resultMessage = ex.Message;
                    resList.Add(new XRMRegPayResult { ResultCode = -1, IDD = -1, ResultMessage = resultMessage });
                }
            }
            catch (Exception.AutenticationException aex)
            {
                String resultMessage = String.Format("Помилка авторизації: {0}", aex.Message);
                resList.Add(new XRMRegPayResult { ResultCode = -1, IDD = -1, ResultMessage = resultMessage });
            }
            return resList;
        }
        #endregion create_regpay_method
        #region create_dpt_regpay_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public List<XRMDPTRegPayResult> CreateDPTRegPayMethod(XRMDPTRegPayReq[] XRMDPTRegPay)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var resList = new List<XRMDPTRegPayResult>();
            var RegDPTPayRes = new XRMDPTRegPayResult();
            RegDPTPayRes.XRMRegPayResult = new XRMRegPayResult();
            try
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    LoginADUserIntSingleCon(con, XRMDPTRegPay[0].XRMRegPayReq.UserLogin);

                    foreach (var RegDPTPayReq in XRMDPTRegPay)
                    {
                        TransSuccess = TransactionCheck(con, RegDPTPayReq.XRMRegPayReq.TransactionId, out responseBytes);
                        if (TransSuccess == 0)
                        {
                            TransactionCreate(con, RegDPTPayReq.XRMRegPayReq.TransactionId, RegDPTPayReq.XRMRegPayReq.UserLogin, RegDPTPayReq.XRMRegPayReq.OperationType);
                            RegDPTPayRes = RegPaymentsWorker.ProcCreateDPTRegPay(RegDPTPayReq, "dpt", con);
                            WriteRequestResponseToLog(con, RegDPTPayReq.XRMRegPayReq.TransactionId, RegDPTPayReq, RegDPTPayRes);
                        }
                        else
                        {
                            String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, RegDPTPayReq.XRMRegPayReq.TransactionId) : String.Format(TransactionErrorMessage, RegDPTPayReq.XRMRegPayReq.TransactionId);
                            RegDPTPayRes = ToResponse<XRMDPTRegPayResult>(responseBytes);
                            RegDPTPayRes.ResultMessage = errorMsg + "\r" + RegDPTPayRes.ResultMessage;
                        }
                        resList.Add(RegDPTPayRes);
                    }
                }
            }
            catch (System.Exception ex)
            {
                var temp = new XRMDPTRegPayResult();
                temp.XRMRegPayResult = new XRMRegPayResult();
                temp.XRMRegPayResult.ResultMessage = ex.Message;
                temp.XRMRegPayResult.ResultCode = -1;
                temp.XRMRegPayResult.IDD = -1;
                resList.Add(temp);
            }
            return resList;
        }
        #endregion create_dpt_regpay_method
        #region create_cck_regpay_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public XRMCCKRegPayResult CreateCCKRegPayMethod(XRMCCKRegPayReq XRMCCKRegPay)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var RegCCKPayRes = new XRMCCKRegPayResult();
            RegCCKPayRes.XRMRegPayResult = new XRMRegPayResult();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMCCKRegPay.XRMRegPayReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMCCKRegPay.XRMRegPayReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMCCKRegPay.XRMRegPayReq.TransactionId, XRMCCKRegPay.XRMRegPayReq.UserLogin, XRMCCKRegPay.XRMRegPayReq.OperationType);
                        RegCCKPayRes = RegPaymentsWorker.ProcCreateCCKRegPay(XRMCCKRegPay, "cck", con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMCCKRegPay.XRMRegPayReq.TransactionId) : String.Format(TransactionErrorMessage, XRMCCKRegPay.XRMRegPayReq.TransactionId);
                        RegCCKPayRes = ToResponse<XRMCCKRegPayResult>(responseBytes);
                        RegCCKPayRes.ResultMessage = errorMsg + "\r" + RegCCKPayRes.ResultMessage;
                        return RegCCKPayRes;
                    }
                }
                catch (Exception.AutenticationException ex)
                {
                    RegCCKPayRes.XRMRegPayResult.ResultMessage = ex.Message;
                    RegCCKPayRes.XRMRegPayResult.ResultCode = -1;
                    RegCCKPayRes.XRMRegPayResult.IDD = -1;
                }
                WriteRequestResponseToLog(con, XRMCCKRegPay.XRMRegPayReq.TransactionId, XRMCCKRegPay, RegCCKPayRes);
                return RegCCKPayRes;
            }
        }
        #endregion create_cck_regpay_method
        #region create_sbon_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public SbonOrderResult CreateSbonPayMethod(SbonOrderRequest XRMSBONReq)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var SBONRes = new SbonOrderResult();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMSBONReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMSBONReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMSBONReq.TransactionId, XRMSBONReq.UserLogin, XRMSBONReq.OperationType);
                        SBONRes = RegPaymentsWorker.ProcCreateSBON(XRMSBONReq, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMSBONReq.TransactionId) : String.Format(TransactionErrorMessage, XRMSBONReq.TransactionId);
                        SBONRes = ToResponse<SbonOrderResult>(responseBytes);
                        SBONRes.ResultMessage = errorMsg + "\r" + SBONRes.ResultMessage;
                        return SBONRes;
                    }
                }
                catch (System.Exception ex)
                {
                    SBONRes.ResultCode = -1;
                    SBONRes.OrderId = -1;
                    SBONRes.ResultMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, XRMSBONReq.TransactionId, XRMSBONReq, SBONRes);
                return SBONRes;
            }
        }
        #endregion create_sbon_method
        #region create_free_sbon_method
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public SbonFreeOrderResult CreateFreeSbonPayMethod(SbonFreeOrderRequest XRMFreeSBONReq)
        {
            decimal TransSuccess = 0;
            Byte[] responseBytes;
            var SBONFreeRes = new SbonFreeOrderResult();

            using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                try
                {
                    LoginADUserIntSingleCon(con, XRMFreeSBONReq.UserLogin);

                    TransSuccess = TransactionCheck(con, XRMFreeSBONReq.TransactionId, out responseBytes);
                    if (TransSuccess == 0)
                    {
                        TransactionCreate(con, XRMFreeSBONReq.TransactionId, XRMFreeSBONReq.UserLogin, XRMFreeSBONReq.OperationType);
                        SBONFreeRes = RegPaymentsWorker.ProcCreateFreeSBON(XRMFreeSBONReq, con);
                    }
                    else
                    {
                        String errorMsg = TransSuccess == -1 ? String.Format(TransactionExistsMessage, XRMFreeSBONReq.TransactionId) : String.Format(TransactionErrorMessage, XRMFreeSBONReq.TransactionId);
                        SBONFreeRes = ToResponse<SbonFreeOrderResult>(responseBytes);
                        SBONFreeRes.ResultMessage = errorMsg + "\r" + SBONFreeRes.ResultMessage;
                        return SBONFreeRes;
                    }
                }
                catch (System.Exception ex)
                {
                    SBONFreeRes.ResultCode = -1;
                    SBONFreeRes.OrderId = -1;
                    SBONFreeRes.ResultMessage = ex.Message;
                }
                WriteRequestResponseToLog(con, XRMFreeSBONReq.TransactionId, XRMFreeSBONReq, SBONFreeRes);
                return SBONFreeRes;
            }

        }
        #endregion create_free_sbon_method
    }
}

