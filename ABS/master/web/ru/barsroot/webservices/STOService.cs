using System;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using System.Globalization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using barsroot.core;
using BarsWeb.Core.Logger;
using Bars;
using Bars.Classes;
using Bars.WebServices;
using Bars.Application;


namespace Bars.WebServices
{
    #region hostshelpers
    //public class RequestHelpers
    //{
    //    public static string GetClientIpAddress(HttpRequest request)
    //    {
    //        try
    //        {
    //            string szRemoteAddr = request.ServerVariables["REMOTE_ADDR"];
    //            string szXForwardedFor = request.ServerVariables["X_FORWARDED_FOR"];
    //            string szIP = "";

    //            if (szXForwardedFor == null && szRemoteAddr != "::1")
    //            {
    //                szIP = szRemoteAddr;
    //            }
    //            else
    //            {
    //                szIP = szXForwardedFor;
    //                if (szIP.IndexOf(",") > 0)
    //                {
    //                    string[] arIPs = szIP.Split(',');

    //                    foreach (string item in arIPs)
    //                    {
    //                        if (!IsPrivateIpAddress(item))
    //                        {
    //                            return item;
    //                        }
    //                    }
    //                }
    //            }
    //            return szIP;
    //        }
    //        catch (System.Exception)
    //        {
    //            // Always return all zeroes for any failure (my calling code expects it)
    //            return "0.0.0.0";
    //        }
    //    }

    //    private static bool IsPrivateIpAddress(string ipAddress)
    //    {
    //        // http://en.wikipedia.org/wiki/Private_network
    //        // Private IP Addresses are: 
    //        //  24-bit block: 10.0.0.0 through 10.255.255.255
    //        //  20-bit block: 172.16.0.0 through 172.31.255.255
    //        //  16-bit block: 192.168.0.0 through 192.168.255.255
    //        //  Link-local addresses: 169.254.0.0 through 169.254.255.255 (http://en.wikipedia.org/wiki/Link-local_address)

    //        var ip = IPAddress.Parse(ipAddress);
    //        var octets = ip.GetAddressBytes();

    //        var is24BitBlock = octets[0] == 10;
    //        if (is24BitBlock) return true; // Return to prevent further processing

    //        var is20BitBlock = octets[0] == 172 && octets[1] >= 16 && octets[1] <= 31;
    //        if (is20BitBlock) return true; // Return to prevent further processing

    //        var is16BitBlock = octets[0] == 192 && octets[1] == 168;
    //        if (is16BitBlock) return true; // Return to prevent further processing

    //        var is0BitBlock = octets[0] == 129 && octets[1] == 0;
    //        if (is0BitBlock) return true; // Return to prevent further processing

    //        var isLinkLocalAddress = octets[0] == 169 && octets[1] == 254;
    //        return isLinkLocalAddress;
    //    }
    //}
    #endregion
    #region classes
    /*      
        RU                  [int]               Регіональне управління клієнта
        RNK                 [nvarchar](6)       РНК клієнта
        Telephone_number    [nvarchar](15)      Номер телефону, по якому потрібно відправити SMS
        Payment_id          [nvarchar](10)      ID платежу по відповідному № договору, який необхідно передати в БАРС в разі відміни платежу
        Contract_number     [nvarchar](10)      № договору, по якому необхідно підтвердити платіж
        Payment_amount      money               Сума платежу
        Payment_date        datetime            Дата платежу 
     */
    public class GetPaymentsList
    {
        public int AskPaymentsList {get;set;}
        public PaymentsList[] PaymentsListSet { get; set; }
        public string ErrorMessage {get;set;}
    }
    
    public class AcceptPaymentsList
    {
        public AcceptPaymentsId[] AcceptPaymentsIdSet { get; set; }
        public string ErrorMessage  {get; set;}
    }
    public class CancelPaymentsList
    {
        public CancelPaymentsId[] CancelPaymentsIdSet { get; set; }
        public string ErrorMessage { get; set; }
    }
  
    #endregion
    #region structures
    public struct PaymentsList
    {
        public decimal? RU { get; set; }
        public decimal? RNK { get; set; }
        public string Telephone_number { get; set; }
        public string Payment_id { get; set; }
        public string Contract_number { get; set; }
        public decimal? Payment_amount { get; set; }
        public string Payment_date { get; set; }
    }
    public struct AcceptPaymentsId
    { 
        public string Payment_id { get; set; } 
        public string Payment_status { get; set; } 
    }
    public struct CancelPaymentsId
    {
        public string Payment_id { get; set; }
        public string Payment_status { get; set; }
    }
    #endregion

    /// <summary>
    /// Веб-сервіс для взаємодії з системою CRM по передаче списка платежів
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class STOService : BarsWebService
    {
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger; 
        #region private methods

        private void LoginUserInt(String userName)
        {
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            try
            {
                InitOraConnection();
                // установка первичных параметров
                ClearParameters();
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);
                SetParameters("p_hostname", DB_TYPE.Varchar2, RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");

                ClearParameters();
                SetParameters("p_info", DB_TYPE.Varchar2,
                    String.Format("STOService: авторизация. Хост {0}, пользователь {1}", RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), userName),
                    DIRECTION.Input);
                SQL_PROCEDURE("bars_audit.info");
            }
            finally
            {
                DisposeOraConnection();
            }

            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;
        }

        private void LoginUser()
        {
           
            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "absadm";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "<указать пароль!!!>";

            // авторизация пользователя по хедеру
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated)
                LoginUserInt(userName);
        }
        private static class OracleHelper
        {
            public static string GetString(OracleDataReader _reader, int _fieldId)
            {
                return _reader.IsDBNull(_fieldId) ? null : _reader.GetString(_fieldId);
            }

            public static string GetIntString(OracleDataReader _reader, int _fieldId)
            {
                return _reader.IsDBNull(_fieldId) ? null : _reader.GetInt32(_fieldId).ToString();
            }

            public static string GetDateTimeString(OracleDataReader _reader, int _fieldId, string _dateFormat)
            {
                return _reader.IsDBNull(_fieldId) ? null : _reader.GetDateTime(_fieldId).ToString(_dateFormat);
            }

            public static string GetDecimalString(OracleDataReader _reader, int _fieldId, string _decimalFormat)
            {
                return _reader.IsDBNull(_fieldId) ? null : _reader.GetDecimal(_fieldId).ToString(_decimalFormat);
            }
            public static Decimal? GetDecimal(OracleDataReader _reader, int _fieldId)
            {
                return _reader.IsDBNull(_fieldId) ? null : (Decimal?)_reader.GetDecimal(_fieldId);
            }
            private static OracleParameter GetParameter(OracleCommand _command, string _parameterName)
            {
                OracleParameter parameter = _command.Parameters[_parameterName];
                if (parameter == null) throw new KeyNotFoundException(String.Format("Parameter with name '{0}' not found", _parameterName));
                return parameter;
            }

            public static string GetParameterString(OracleCommand _command, string _parameterName)
            {
                OracleString oracleString = (OracleString)GetParameter(_command, _parameterName).Value;
                return oracleString == null ? null : oracleString.Value;
            }

            public static int? GetParameterInt(OracleCommand _command, string _parameterName)
            {
                OracleDecimal oracleDecimal = (OracleDecimal)GetParameter(_command, _parameterName).Value;
                return oracleDecimal.IsNull ? null : (int?)oracleDecimal.Value;
            }

            public static decimal? GetParameterDecimal(OracleCommand _command, string _parameterName)
            {
                OracleDecimal oracleDecimal = (OracleDecimal)GetParameter(_command, _parameterName).Value;
                return oracleDecimal.IsNull ? null : (decimal?)oracleDecimal.Value;
            }
        }
        #endregion
        #region методы веб-сервиса
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public GetPaymentsList GetPaymentsListSet(int AskPaymentsList)
        {
            _dbLogger = DbLoggerConstruct.NewDbLogger();
            String errmsg = "Ok";
            PaymentsList[] PaymentsLists = new PaymentsList[500];
            try
            {
                try
                {
                    LoginUser();
                }
                catch (Exception.AutenticationException aex)
                {
                    return new GetPaymentsList() { ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message) };
                }

                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    //_dbLogger.Info("GetPaymentsListSet-try", "STOService");
                    OracleCommand cmd = new OracleCommand(" SELECT to_number(so.kf) as RU, c.rnk as RNK, cw.value as Telephone_number, " +
                                                          " to_char(sp.id) as Payment_id, to_char(sp.order_id) as Contract_number, " + 
                                                          " SP.PAYMENT_AMOUNT as Payment_amount, "+
                                                          " to_char(sp.value_date,'dd/mm/yyyy') as Payment_date " +
                                                          " FROM bars.sto_payment_que spq, " +
                                                          "      bars.sto_payment sp, " +
                                                          "      bars.sto_order so, " +
                                                          "      bars.accounts a, " +
                                                          "      bars.customer c, " +
                                                          "      bars.customerw cw " +
                                                         " where spq.id = sp.id " +
                                                          " and SP.ORDER_ID = so.id " +
                                                          " and a.acc = SO.PAYER_ACCOUNT_ID " +
                                                          " and c.rnk = a.rnk " +
                                                          " and cw.rnk = c.rnk " +
                                                          " and cw.tag = 'MPNO  ' " +
                                                          " and nvl(SP.PAYMENT_AMOUNT,0) != 0 " +
                                                          " and sp.value_date >= DAT_NEXT_U(bankdate, 3) " + 
                                                          " and so.send_sms = 'Y' " +
                                                          " and VERIFY_CELLPHONE(cw.value) = 1 ", con);
                    OracleDataReader reader = cmd.ExecuteReader();
                    
                    int rowCounter = 0;
                    if (reader.HasRows)
                    {
                        int idRU = reader.GetOrdinal("RU");
                        int idRNK = reader.GetOrdinal("RNK");
                        int idTelephone_number = reader.GetOrdinal("Telephone_number");
                        int idPayment_id = reader.GetOrdinal("Payment_id");
                        int idContract_number = reader.GetOrdinal("Contract_number");
                        int idPayment_amount = reader.GetOrdinal("Payment_amount");
                        int idPayment_date = reader.GetOrdinal("Payment_date");    


                        while (reader.Read())
                        {
                            PaymentsList PaymentsList = new PaymentsList();
                            PaymentsList.RU = OracleHelper.GetDecimal(reader, idRU);
                            PaymentsList.RNK = OracleHelper.GetDecimal(reader, idRNK);
                            PaymentsList.Telephone_number = OracleHelper.GetString(reader, idTelephone_number);
                            PaymentsList.Payment_id = OracleHelper.GetString(reader, idPayment_id);
                            PaymentsList.Contract_number = OracleHelper.GetString(reader, idContract_number);
                            PaymentsList.Payment_amount = OracleHelper.GetDecimal(reader, idPayment_amount);
                            PaymentsList.Payment_date = OracleHelper.GetString(reader, idPayment_date);

                            PaymentsLists[rowCounter++]   = PaymentsList;
                            if (rowCounter % 100 == 0)
                                Array.Resize(ref PaymentsLists, rowCounter + 100);
                        }
                    }
                    Array.Resize(ref PaymentsLists, rowCounter);
                    return new GetPaymentsList() { PaymentsListSet = PaymentsLists, ErrorMessage = errmsg };
                }
            }
            catch (System.Exception ex)
            { return new GetPaymentsList() { PaymentsListSet = PaymentsLists, ErrorMessage = ex.StackTrace + "//" + ex.Message + "//" + ex.Source + "//" + ex.InnerException }; }
            finally { DisposeOraConnection(); } 
        }       

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public AcceptPaymentsList AcceptPaymentsListSet(string[] Payment_id)
        {          
            AcceptPaymentsId[] AcceptPaymentsIds = new AcceptPaymentsId[100];
            _dbLogger = DbLoggerConstruct.NewDbLogger();
            String errmsg = "GeneralError";            
            try
            {
                try
                {
                    LoginUser();
                }
                catch (Exception.AutenticationException aex)
                {
                    return new AcceptPaymentsList() { ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message) };
                }

                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    //_dbLogger.Info("AcceptPaymentsListSet-try", "STOService");

                    OracleCommand cmd = con.CreateCommand();
                    cmd.CommandType = CommandType.StoredProcedure;

                    int alldocs = Payment_id.Count();
                    int counter = 1;

                    //_dbLogger.Info("AcceptPaymentsListSet:alldocs = " + Convert.ToString(alldocs), "STOService");

                    foreach (string AcceptPayment in Payment_id)
                    {
                        //_dbLogger.Info("AcceptPaymentsListSet:counter = " + Convert.ToString(counter), "STOService");
                        
                        cmd.Parameters.Clear();
                        cmd.CommandText = "BARS.STO_PAYMENT_UTL.DELETE_PAYMENT_QUE";
                        cmd.Parameters.Add("p_payments_id", OracleDbType.Varchar2, AcceptPayment, ParameterDirection.Input);
                        cmd.Parameters.Add("p_errormsg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                        cmd.ExecuteNonQuery();
                                                
                        String retMsg;
                        object resMsg = cmd.Parameters["p_errormsg"].Value;
                        retMsg = (resMsg == null || ((OracleString)resMsg).IsNull) ? null : ((OracleString)resMsg).Value;

                        // 1 штука
                        AcceptPaymentsId AcceptPaymentId = new AcceptPaymentsId();
                        AcceptPaymentId.Payment_id = AcceptPayment;
                        AcceptPaymentId.Payment_status = retMsg;
                        if (retMsg != "Ok") { errmsg = errmsg + ";" + retMsg; }

                        AcceptPaymentsIds[counter] = AcceptPaymentId;
                        if (counter % 100 == 0) Array.Resize(ref AcceptPaymentsIds, counter + 100);
                        counter++;
                    }
                    Array.Resize(ref AcceptPaymentsIds, counter);
                    if (errmsg == "GeneralError") { errmsg = "Ok"; }
                }
                return new AcceptPaymentsList() { AcceptPaymentsIdSet = AcceptPaymentsIds, ErrorMessage = errmsg };
                }            
            catch (System.Exception ex)
            { return new AcceptPaymentsList() {ErrorMessage = ex.StackTrace + "//" + ex.Message + "//" + ex.Source + "//" + ex.InnerException }; }
            finally { DisposeOraConnection(); } 
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public CancelPaymentsList CancelPaymentsListSet(string[] Payment_id)
        {
            CancelPaymentsId[] CancelPaymentsIds = new CancelPaymentsId[100];
            _dbLogger = DbLoggerConstruct.NewDbLogger();
            String errmsg = "GeneralError";
            try
            {
                try
                {
                    LoginUser();
                }
                catch (Exception.AutenticationException aex)
                {
                    return new CancelPaymentsList() { ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message) };
                }

                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    //_dbLogger.Info("CancelPaymentsListSet-try", "STOService");

                    OracleCommand cmd = con.CreateCommand();
                    cmd.CommandType = CommandType.StoredProcedure;

                    int alldocs = Payment_id.Count();
                    int counter = 1;

                    //_dbLogger.Info("CancelPaymentsListSet:alldocs = " + Convert.ToString(alldocs), "STOService");

                    foreach (string CancelPayment in Payment_id)
                    {
                        //_dbLogger.Info("CancelPaymentsListSet:counter = " + Convert.ToString(counter), "STOService");

                        cmd.Parameters.Clear();
                        cmd.CommandText = "BARS.STO_PAYMENT_UTL.CANCEL_PAYMENT";
                        cmd.Parameters.Add("p_payments_id", OracleDbType.Varchar2, CancelPayment, ParameterDirection.Input);
                        cmd.Parameters.Add("p_errormsg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                        cmd.ExecuteNonQuery();

                        String retMsg;
                        object resMsg = cmd.Parameters["p_errormsg"].Value;
                        retMsg = (resMsg == null || ((OracleString)resMsg).IsNull) ? null : ((OracleString)resMsg).Value;

                        // 1 штука
                        CancelPaymentsId CancelPaymentId = new CancelPaymentsId();
                        CancelPaymentId.Payment_id = CancelPayment;
                        CancelPaymentId.Payment_status = retMsg;

                        if (retMsg != "Ok") { errmsg = errmsg + ";" + retMsg; }

                        CancelPaymentsIds[counter] = CancelPaymentId;
                        if (counter % 100 == 0) Array.Resize(ref CancelPaymentsIds, counter + 100);
                        counter++;
                    }
                    Array.Resize(ref CancelPaymentsIds, counter);
                    if (errmsg == "GeneralError") { errmsg = "Ok"; }
                }
                return new CancelPaymentsList() { CancelPaymentsIdSet = CancelPaymentsIds, ErrorMessage = errmsg };
            }
            catch (System.Exception ex)
            { return new CancelPaymentsList() { ErrorMessage = ex.StackTrace + "//" + ex.Message + "//" + ex.Source + "//" + ex.InnerException }; }
            finally { DisposeOraConnection(); }
        }       

        #endregion
    }



}
