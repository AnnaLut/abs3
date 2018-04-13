using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Net;
using System.Linq;
using System.ServiceModel;

using System.Security.Cryptography.X509Certificates;
using System.Net.Security;

using Bars.Application;
using Bars.WebServices;
using Bars.Classes;
using Bars.Exception;
using barsroot.core;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

using ibank.objlayer;
using ibank.core;
using ibank.core.Exceptions;
using Bars.Logger;

namespace Bars.WebServices
{

    public class RequestHelpers
    {
        public static string GetClientIpAddress(HttpRequest request)
        {
            try
            {
                string szRemoteAddr = request.ServerVariables["REMOTE_ADDR"];
                string szXForwardedFor = request.ServerVariables["X_FORWARDED_FOR"];
                string szIP = "";

                if (szXForwardedFor == null && szRemoteAddr != "::1")
                {
                    szIP = szRemoteAddr;
                }
                else
                {
                    szIP = szXForwardedFor;
                    if (szIP.IndexOf(",") > 0)
                    {
                        string[] arIPs = szIP.Split(',');

                        foreach (string item in arIPs)
                        {
                            if (!IsPrivateIpAddress(item))
                            {
                                return item;
                            }
                        }
                    }
                }
                return szIP;             
            }
            catch (System.Exception)
            {
                // Always return all zeroes for any failure (my calling code expects it)
                return "0.0.0.0";
            }
        }

        private static bool IsPrivateIpAddress(string ipAddress)
        {
            // http://en.wikipedia.org/wiki/Private_network
            // Private IP Addresses are: 
            //  24-bit block: 10.0.0.0 through 10.255.255.255
            //  20-bit block: 172.16.0.0 through 172.31.255.255
            //  16-bit block: 192.168.0.0 through 192.168.255.255
            //  Link-local addresses: 169.254.0.0 through 169.254.255.255 (http://en.wikipedia.org/wiki/Link-local_address)

            var ip = IPAddress.Parse(ipAddress);
            var octets = ip.GetAddressBytes();

            var is24BitBlock = octets[0] == 10;
            if (is24BitBlock) return true; // Return to prevent further processing

            var is20BitBlock = octets[0] == 172 && octets[1] >= 16 && octets[1] <= 31;
            if (is20BitBlock) return true; // Return to prevent further processing

            var is16BitBlock = octets[0] == 192 && octets[1] == 168;
            if (is16BitBlock) return true; // Return to prevent further processing

            var is0BitBlock = octets[0] == 129 && octets[1] == 0;
            if (is0BitBlock) return true; // Return to prevent further processing

            var isLinkLocalAddress = octets[0] == 169 && octets[1] == 254;
            return isLinkLocalAddress;
        }
    }

    /// <summary>
    /// Варианты исхода обращения к веб-сервису :)
    /// </summary>
    public enum ResultKinds { Success, Error }

    /// <summary>
    /// Класс сообщения об ошибке
    /// </summary>
    public class ErrorMessage
    {
        /// <summary>
        /// Код ошибки
        /// </summary>
        public string Code { get; set; }
        /// <summary>
        /// Текст ошибки
        /// </summary>
        public string Message { get; set; }
    }

    /// <summary>
    /// Базовый класс результата запроса
    /// </summary>
    public class RequestResult
    {
        public RequestResult()
        {
            Errors = new List<ErrorMessage>();
            Kind = ResultKinds.Success;
        }
        /// <summary>
        /// Тип результата - успех или ошибка
        /// </summary>
        public ResultKinds Kind { get; set; }
        /// <summary>
        /// Список ошибок
        /// </summary>
        public List<ErrorMessage> Errors { get; set; }
    }

    /// <summary>
    /// Результат запроса - Decimal
    /// </summary>
    public class RequestResultDecimal : RequestResult
    {
        /// <summary>
        /// Код возврата
        /// </summary>
        public Decimal? ReturnCode { get; set; }
    }

   
    public class ActivateCardException : System.Exception
    {
        public ActivateCardException(String Code, String Message) : base(Code.ToString() + ": " + Message) { }

    }

    /// <summary>
    /// Веб-сервис для взаимодействия с внешними системами BitBank
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class PayService : BarsWebService 
    {
        public WsHeader WsHeaderValue;

        #region //////////////// private methods /////////////////

       
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
                    String.Format("PayService: авторизация. Хост {0}, пользователь {1}", RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), userName),
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

        private RequestResult LoginUser()
        {
            RequestResult res = new RequestResult();

            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "absadm";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "<указать пароль!!!>";

            // авторизация пользователя по хедеру
            try
            {
                Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
                if (isAuthenticated)
                {
                    LoginUserInt(userName);
                    res.Kind = ResultKinds.Success;
                }
                else
                {
                    res.Kind = ResultKinds.Error;
                    res.Errors.Add(new ErrorMessage() { Code = "ERR_AUTH_UNKNOWN", Message = "Невідома помилка авторизації, звернітся до адміністратора" });
                }
            }
            catch (System.Exception e)
            {
                res.Kind = ResultKinds.Error;
                res.Errors.Add(new ErrorMessage() {Code = "ERR_AUTH_UNAMEPASSW", Message =  String.Format("Помилка авторизації: {0}", e.Message) });
            }

            return res;
        }

        private bool tryLogin(RequestResult res)
        {
            RequestResult authRes = LoginUser();
            if (authRes.Kind == ResultKinds.Error)
            {
                res.Kind = authRes.Kind;
                res.Errors.AddRange(authRes.Errors);
                return false;
            }
            return true;
        }

        #endregion //////////////////////////////////////


     
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public RequestResultDecimal PayDoc(String DocNum, DateTime DocDate, String Branch, String DebitMfo, String CreditMfo, String DebitAccount, String CreditAccount,
                                           String DebitOwnerRegisterCode, String CreditOwnerRegisterCode, String CurrencyISO, Decimal? Amount, String DebitOwnerName, String CreditOwnerName, String PaymentPurpose, Decimal? Sk,
                                           Decimal? DebitFlag, Decimal? DocType, String DRec, String Sign, String CreatedByUserName, String ConfirmedByUserName, String TT)
        {
            RequestResultDecimal res = new RequestResultDecimal();

           if (!tryLogin(res)) return res;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();


            try
            {



                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "pay_file_a";
                cmd.Parameters.Add("p_nd", OracleDbType.Varchar2, DocNum, ParameterDirection.Input);
                cmd.Parameters.Add("p_date", OracleDbType.Date, DocDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, Branch, ParameterDirection.Input);
                cmd.Parameters.Add("p_mfoa", OracleDbType.Varchar2, DebitMfo, ParameterDirection.Input);
                cmd.Parameters.Add("p_mfob", OracleDbType.Varchar2, CreditMfo, ParameterDirection.Input);
                cmd.Parameters.Add("p_nlsa", OracleDbType.Varchar2, DebitAccount, ParameterDirection.Input);
                cmd.Parameters.Add("p_nlsb", OracleDbType.Varchar2, CreditAccount, ParameterDirection.Input);
                cmd.Parameters.Add("p_okpoa", OracleDbType.Varchar2, DebitOwnerRegisterCode, ParameterDirection.Input);
                cmd.Parameters.Add("p_okpob", OracleDbType.Varchar2, CreditOwnerRegisterCode, ParameterDirection.Input);
                cmd.Parameters.Add("p_kv", OracleDbType.Varchar2, CurrencyISO, ParameterDirection.Input);
                cmd.Parameters.Add("p_s", OracleDbType.Decimal, Amount, ParameterDirection.Input);
                cmd.Parameters.Add("p_nama", OracleDbType.Varchar2, DebitOwnerName, ParameterDirection.Input);
                cmd.Parameters.Add("p_namb", OracleDbType.Varchar2, CreditOwnerName, ParameterDirection.Input);
                cmd.Parameters.Add("p_nazn", OracleDbType.Varchar2, PaymentPurpose, ParameterDirection.Input);
                cmd.Parameters.Add("p_sk", OracleDbType.Decimal, Sk, ParameterDirection.Input);
                cmd.Parameters.Add("p_dk", OracleDbType.Decimal, DebitFlag, ParameterDirection.Input);
                cmd.Parameters.Add("p_vob", OracleDbType.Decimal, DocType, ParameterDirection.Input);
                cmd.Parameters.Add("p_drec", OracleDbType.Varchar2, DRec, ParameterDirection.Input);
                cmd.Parameters.Add("p_sign", OracleDbType.Varchar2, Sign, ParameterDirection.Input);
                cmd.Parameters.Add("CreatedByUserName", OracleDbType.Varchar2, CreatedByUserName,
                    ParameterDirection.Input);
                cmd.Parameters.Add("ConfirmedByUserName", OracleDbType.Varchar2, ConfirmedByUserName,
                    ParameterDirection.Input);
                cmd.Parameters.Add("TT", OracleDbType.Varchar2, TT, ParameterDirection.Input);
                cmd.Parameters.Add("res_ref", OracleDbType.Decimal, null, ParameterDirection.Output);
                cmd.Parameters.Add("res_code", OracleDbType.Decimal, null, ParameterDirection.Output);
                cmd.Parameters.Add("res_msg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                cmd.ExecuteNonQuery();


                Decimal? retRef;
                String retMsg;
                Decimal? retCode;

                object refDoc = cmd.Parameters["res_ref"].Value;
                object resCode = cmd.Parameters["res_code"].Value;
                object resMsg = cmd.Parameters["res_msg"].Value;

                retRef = (refDoc == null || ((OracleDecimal) refDoc).IsNull)
                    ? (Decimal?) null
                    : ((OracleDecimal) refDoc).Value;
                retCode = (resCode == null || ((OracleDecimal) resCode).IsNull)
                    ? (Decimal?) null
                    : ((OracleDecimal) resCode).Value;
                retMsg = (resMsg == null || ((OracleString) resMsg).IsNull) ? null : ((OracleString) resMsg).Value;


                if (retCode == 0)
                {
                    res.Kind = ResultKinds.Success;
                    res.ReturnCode = retRef;
                }
                else
                {
                    res.Kind = ResultKinds.Error;
                    res.Errors.Add(new ErrorMessage() {Code = "ERR_PAYSERVICE", Message = retMsg});
                    res.ReturnCode = retCode;
                }

            }
            catch (System.Exception e)
            {
                res.Kind = ResultKinds.Error;
                res.Errors.Add(new ErrorMessage() {Code = "ERR_PAYSERVICE", Message = e.Message});
            }
            finally
            {
                con.Close();
                con.Dispose();
                cmd.Dispose();
            }

            return res;
        }


        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public RequestResultDecimal CheckDocStatus(Decimal? DocRef)
        {
            RequestResultDecimal res = new RequestResultDecimal();

            if (!tryLogin(res)) return res;

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();


            try
            {
                Decimal? retSos;

                cmd.Parameters.Add("ref", OracleDbType.Decimal, DocRef, ParameterDirection.Input);
                cmd.CommandText = "select sos from oper where ref=:ref";

                 object result  = cmd.ExecuteScalar();

                 retSos = (result == null) ? 0 : (Convert.ToDecimal(result));

                  if (result == null)
                    {
                        res.Kind = ResultKinds.Error;
                        res.Errors.Add(new ErrorMessage() { Code = "ERR_PAYSERVICE", Message = "Документ не знайдено" });
                        res.ReturnCode = -20000;
                        
                    }
                    else
                    {
                        res.Kind = ResultKinds.Success;
                        res.ReturnCode = retSos;
                    }
                
             
            }
            catch (System.Exception e)
            {
                res.Kind = ResultKinds.Error;
                res.Errors.Add(new ErrorMessage() { Code = "ERR_PAYSERVICE", Message = e.Message });
            }
            finally
            {
                con.Close();
                con.Dispose();
                cmd.Dispose();
            }

            return res;
        }

    }



}
