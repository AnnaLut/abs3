using System;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Collections.Generic;
using System.Web.Services.Protocols;
using System.Xml.Serialization;
using System.IO;
using System.Text;
using BarsWeb.Areas.LimitControl.ViewModels;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Data;
using barsroot.core;
using Bars.Application;
using System.Net;
using Bars.WebServices;



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
    /// Веб-сервіс для Системи контролю лімітів 
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class LcsService : Bars.BarsWebService
    {
        public WsHeader WsHeaderValue;

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
                    String.Format("LCSService: авторизация. Хост {0}, пользователь {1}", RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), userName),
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

        private RequestResult LoginUserLCS()
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
                res.Errors.Add(new ErrorMessage() { Code = "ERR_AUTH_UNAMEPASSW", Message = String.Format("Помилка авторизації: {0}", e.Message) });
            }

            return res;
        }

        private bool tryLogin(RequestResult res)
        {
            RequestResult authRes = LoginUserLCS();
            if (authRes.Kind == ResultKinds.Error)
            {
                res.Kind = authRes.Kind;
                res.Errors.AddRange(authRes.Errors);
                return false;
            }
            return true;
        }

        /// <summary>
        ///  Deserialization 
        /// </summary>
        //Дессириализация
        public class Deserialization<T>
        {
            // Метод десериалізує xml у клас
            public static T XmlToObject(string xmlString)
            {
                XmlSerializer xs = new XmlSerializer(typeof(T));
                MemoryStream memoryStream = new MemoryStream(StringToUtf8ByteArray(xmlString));
                TextReader reader = new StreamReader(memoryStream);
                return (T)xs.Deserialize(reader);
            }
            // Метод конвертирует строку в UTF8 Byte массив
            private static Byte[] StringToUtf8ByteArray(string xmlString)
            {
                UTF8Encoding encoding = new UTF8Encoding();
                byte[] byteArray = encoding.GetBytes(xmlString);
                return byteArray;
            }
        }

        public class GetUserInfo
        {
            public List<String> Datas = new List<String>();
        }

        [XmlType("GetUserInfo")]
        public class GetUserInfoDS
        {
            [XmlElement("Data")]
            public List<String> Data = new List<String>();
        }

        private string GetHostName()
        {
            string userHost = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (String.IsNullOrEmpty(userHost) || String.Compare(userHost, "unknown", true) == 0)
                userHost = HttpContext.Current.Request.UserHostAddress;

            if (String.Compare(userHost, HttpContext.Current.Request.UserHostName) != 0)
                userHost += " (" + HttpContext.Current.Request.UserHostName + ")";

            return userHost;
        }
        private void LoginUser(String userName)
        {
            // Інформація про поточного користувача
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            using (con)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "bars.bars_login.login_user";

                cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, Session.SessionID, ParameterDirection.Input);
                cmd.Parameters.Add("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input);
                cmd.Parameters.Add("p_hostname", OracleDbType.Varchar2, GetHostName(), ParameterDirection.Input);
                cmd.Parameters.Add("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }


            Session["UserLoggedIn"] = true;
        }

        /// <summary>
        ///  Установка статусов для виплачених переводів
        /// </summary>
        /// <param name="transactionId"></param>
        /// <param name="mfo"></param>
        /// <param name="sourceType"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public String SetReturn(String transactionId, String mfo, String sourceType)
        {
            String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Username"];
            String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Pass"];
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
            if (isAuthenticated) LoginUser(barsUserName);

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            using (con)
            {
                cmd.CommandText =
                    "select to_char(lcs_pack.set_return(:p_src_trans_id, :p_mfo, :p_source_type)) as Result from dual";
                cmd.Parameters.Add("p_src_trans_id", OracleDbType.Varchar2, transactionId, ParameterDirection.Input);
                cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, mfo, ParameterDirection.Input);
                cmd.Parameters.Add("p_source_type", OracleDbType.Varchar2, sourceType, ParameterDirection.Input);
                OracleDataReader rdr = cmd.ExecuteReader();
                using (rdr)
                {
                    if (rdr.Read())
                    {
                        String result = rdr["Result"] == DBNull.Value ? null : (String)rdr["Result"];
                        if (result != null)
                        {
                            return result;
                        }
                    }
                }
            }
            return null;
        }

    /// <summary>
    /// Запит на перевірку відповідності документа лімітам
    /// </summary>
    /// <param name="dateOperation"></param>
    /// <param name="sourceType"></param>
    /// <param name="transactionId"></param>
    /// <param name="mfo"></param>
    /// <param name="branch"></param>
    /// <param name="transactionDate"></param>
    /// <param name="transactionBankdate"></param>
    /// <param name="transactionCode"></param>
    /// <param name="documentSum"></param>
    /// <param name="documentSumEquivalent"></param>
    /// <param name="currencyCode"></param>
    /// <param name="exchangeRateOfficial"></param>
    /// <param name="exchangeRateSale"></param>
    /// <param name="documentTypeId"></param>
    /// <param name="documentSerial"></param>
    /// <param name="documentNumber"></param>
    /// <param name="userSurname"></param>
    /// <param name="birthDate"></param>
    /// <param name="residentFlag"></param>
    /// <param name="cashAccFlag"></param>
    /// <param name="approveDocumentFlag"></param>
    /// <param name="exceptionFlag"></param>
    /// <param name="exceptionDescription"></param>
    /// <param name="staffLogname"></param>
    /// <param name="staffName"></param>
    /// <param name="recipient"></param>
    /// <param name="purpose"></param> 
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
        public String GetEquivalent(
            String dateOperation,
            String sourceType,
            String transactionId,
            String mfo,
            String branch,
            String transactionDate,
            String transactionBankdate,
            String transactionCode,
            Decimal documentSum,
            Decimal documentSumEquivalent,
            Decimal currencyCode,
            Decimal exchangeRateOfficial,
            Decimal exchangeRateSale,
            Decimal documentTypeId,
            String documentSerial,
            String documentNumber,
            String userSurname,
            String birthDate,
            Decimal residentFlag,
            Decimal cashAccFlag,
            Decimal approveDocumentFlag,
            Decimal exceptionFlag,
            String exceptionDescription,
            String staffLogname,
            String staffName,
			String recipient = "",
			String purpose = ""
            )
        {
            String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Username"];
            String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Pass"];
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
            if (isAuthenticated) LoginUser(barsUserName);

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            String result;

            using (con)
            {
                cmd.CommandText =
                    "select to_char(lcs_pack.get_eqv(:p_date,:p_source_type,:p_src_trans_id,:p_mfo,:p_branch,:p_trans_crt_date,:p_trans_bank_date,:p_trans_code,:p_s,:p_sq,:p_currency_code,:p_ex_rate_official,:p_ex_rate_sale, :p_doc_type_id, :p_serial_doc, :p_numb_doc,:p_fio,:p_birth_date,:p_resident_flag,:p_cash_acc_flag,:p_approve_docs_flag,:p_exception_flag,:p_exception_description,:p_staff_logname,:p_staff_fio,:p_recipient,:p_purpose )) as Result from dual";
                cmd.Parameters.Add("p_date", OracleDbType.Varchar2, dateOperation, ParameterDirection.Input);
                cmd.Parameters.Add("p_source_type", OracleDbType.Varchar2, sourceType, ParameterDirection.Input);
                cmd.Parameters.Add("p_src_trans_id", OracleDbType.Varchar2, transactionId, ParameterDirection.Input);
                cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, mfo, ParameterDirection.Input);
                cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, branch, ParameterDirection.Input);
                cmd.Parameters.Add("p_trans_crt_date", OracleDbType.Varchar2, transactionDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_trans_bank_date", OracleDbType.Varchar2, transactionBankdate,
                    ParameterDirection.Input);
                cmd.Parameters.Add("p_trans_code", OracleDbType.Varchar2, transactionCode, ParameterDirection.Input);
                cmd.Parameters.Add("p_s", OracleDbType.Decimal, documentSum, ParameterDirection.Input);
                cmd.Parameters.Add("p_sq", OracleDbType.Decimal, documentSumEquivalent, ParameterDirection.Input);
                cmd.Parameters.Add("p_currency_code", OracleDbType.Decimal, currencyCode, ParameterDirection.Input);
                cmd.Parameters.Add("p_ex_rate_official", OracleDbType.Decimal, exchangeRateOfficial,
                    ParameterDirection.Input);
                cmd.Parameters.Add("p_ex_rate_sale", OracleDbType.Decimal, exchangeRateSale, ParameterDirection.Input);
                cmd.Parameters.Add("p_doc_type_id", OracleDbType.Varchar2, documentTypeId, ParameterDirection.Input);
                cmd.Parameters.Add("p_serial_doc", OracleDbType.Varchar2, documentSerial, ParameterDirection.Input);
                cmd.Parameters.Add("p_numb_doc", OracleDbType.Varchar2, documentNumber, ParameterDirection.Input);
                cmd.Parameters.Add("p_fio", OracleDbType.Varchar2, userSurname, ParameterDirection.Input);
                cmd.Parameters.Add("p_birth_date", OracleDbType.Varchar2, birthDate, ParameterDirection.Input);
                cmd.Parameters.Add("p_resident_flag", OracleDbType.Decimal, residentFlag, ParameterDirection.Input);
                cmd.Parameters.Add("p_cash_acc_flag", OracleDbType.Decimal, cashAccFlag, ParameterDirection.Input);
                cmd.Parameters.Add("p_approve_docs_flag", OracleDbType.Decimal, approveDocumentFlag,
                    ParameterDirection.Input);
                cmd.Parameters.Add("p_exception_flag", OracleDbType.Decimal, exceptionFlag, ParameterDirection.Input);
                cmd.Parameters.Add("p_exception_description", OracleDbType.Varchar2, exceptionDescription,
                    ParameterDirection.Input);
                cmd.Parameters.Add("p_staff_logname", OracleDbType.Varchar2, staffLogname, ParameterDirection.Input);
                cmd.Parameters.Add("p_staff_fio", OracleDbType.Varchar2, staffName, ParameterDirection.Input);
                cmd.Parameters.Add("p_recipient", OracleDbType.Varchar2, recipient, ParameterDirection.Input);
                cmd.Parameters.Add("p_purpose", OracleDbType.Varchar2, purpose, ParameterDirection.Input);
            try
            {
                OracleDataReader rdr = cmd.ExecuteReader();

                using (rdr)
                {
                    if (rdr.Read())
                    {
                        result = rdr["Result"] == DBNull.Value ? (String)null : (String)rdr["Result"];
                        if (result != null)
                        {
                            return result.Replace("\"", "");
                        }

                    }
                }
            }
            catch (Exception e)
            {
                return e.Message.Replace("\"", "");
            }
            finally
            {
                con.Dispose();
                con.Close();
                cmd.Dispose();
            }
            }

            return null;
        }


        /// <summary>
        /// Вилучення документа 
        /// </summary>
        /// <param name="transactionId"></param>
        /// <param name="mfo"></param>
        /// <param name="sourceType"></param>
        [WebMethod(EnableSession = true)]
        public string Back(String transactionId, String mfo, String sourceType)
        {
            String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Username"];
            String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Pass"];
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
            if (isAuthenticated) LoginUser(barsUserName);

            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();

            string result;
            using (con)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "lcs_pack.back";
                cmd.Parameters.Add("p_status", OracleDbType.Varchar2, 30, "", ParameterDirection.ReturnValue);
                cmd.Parameters.Add("p_src_trans_id", OracleDbType.Varchar2, transactionId, ParameterDirection.Input);
                cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, mfo, ParameterDirection.Input);
                cmd.Parameters.Add("p_source_type", OracleDbType.Varchar2, sourceType, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
                result = Convert.ToString(cmd.Parameters["p_status"].Value);
            }
            return result;
        }

        /// <summary>
        /// Підтвердження документа
        /// </summary>
        /// <param name="transactionId"></param>
        /// <param name="mfo"></param>
        /// <param name="sourceType"></param>
        [WebMethod(EnableSession = true)]
        public void Approve(String transactionId, String mfo, String sourceType)
        {
            String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Username"];
            String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Pass"];

            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
            if (isAuthenticated) LoginUser(barsUserName);

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            using (con)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "lcs_pack.approve";
                cmd.Parameters.Add("p_src_trans_id", OracleDbType.Varchar2, transactionId, ParameterDirection.Input);
                cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, mfo, ParameterDirection.Input);
                cmd.Parameters.Add("p_source_type", OracleDbType.Varchar2, sourceType, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }

        }

        /// <summary>
        /// Інформаця про всім лімітам за номером та серією документа.
        /// </summary>
        /// <param name="documentSerial"></param>
        /// <param name="documentNumber"></param>
        /// <returns></returns>
        [WebMethod(EnableSession = true)]
        public GetUserInfo Search(String documentSerial, String documentNumber)
        {
            String basrUserName = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Username"];
            String basrPassword = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Pass"];

            GetUserInfoDS getUserDs = new GetUserInfoDS();
            GetUserInfo getUser = new GetUserInfo();

            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(basrUserName, basrPassword, true);
            if (isAuthenticated) LoginUser(basrUserName);

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = con.CreateCommand();
            using (con)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "lcs_pack.get_user_info";
                cmd.Parameters.Add("p_serial_doc", OracleDbType.Varchar2, documentSerial, ParameterDirection.Input);
                cmd.Parameters.Add("p_numb_doc", OracleDbType.Varchar2, documentNumber, ParameterDirection.Input);
                OracleParameter parerr = new OracleParameter("p_res", OracleDbType.Varchar2, 4000, null,
                    System.Data.ParameterDirection.Output);
                cmd.Parameters.Add(parerr);

                cmd.ExecuteNonQuery();

                OracleString res = (OracleString)cmd.Parameters["p_res"].Value;
                getUserDs = Deserialization<GetUserInfoDS>.XmlToObject((String)res);
                getUser.Datas = getUserDs.Data;

                return getUser;
            }
        }


        #region GetLimitStatus

        /// <summary>
        /// Получить статус лимита по документу
        /// </summary>
        /// <param name="searchInfo">Информация для поиска лимита</param>
        /// <returns>Текстовое сообщение о статусе лимита</returns>
        /// <exception cref="Exception"></exception>
        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public LimitStatus GetLimitStatus(LimitSearchInfo searchInfo)
        {
            String userName = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Username"];
            String password = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Pass"];

            // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated) LoginUser(userName);

            OracleConnection con = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.BindByName = true;
                cmd.CommandText =
                    "select lcs_pack.get_limit_status(:p_serial_doc, :p_numb_doc) from dual";
                cmd.Parameters.Add(new OracleParameter("p_serial_doc", OracleDbType.Varchar2)
                {
                    Value = searchInfo.Series
                });
                cmd.Parameters.Add(new OracleParameter("p_numb_doc", OracleDbType.Varchar2)
                {
                    Value = searchInfo.Number
                });
                var xmlValue = (string)cmd.ExecuteScalar();
                LimitStatus result = Deserialization<LimitStatus>.XmlToObject(xmlValue);
                return result;
            }
            finally
            {
                con.Close();
            }
        }

        private string _xml
        {
            get
            {
                return "<?xml version=\"1.0\" encoding=\"utf-8\"?>" + "\r\n" +
                       @"<LimitStatus>
                        <Success>0</Success>
                        <ErrorMessage>Оисание ошибки</ErrorMessage>	
                        <OperationCollection>
		                    <Operations>
			                    <Operation>
				                    <Limit>Валютообмін 150 тис.</Limit>
				                    <Sum>120.12</Sum>
			                    </Operation>
			                    <Operation>
				                    <Limit>Валютообмін 100 тис.</Limit>
				                    <Sum>130.14</Sum>
			                    </Operation>
		                    </Operations>
	                    </OperationCollection>
	                    <TransactionCollection>
		                    <Transactions>
			                    <Transaction>
				                    <Date>12.12.2012</Date>
				                    <Branch>12</Branch>
				                    <Operation>12</Operation>
				                    <Currency>840</Currency>
				                    <Sum>120.12</Sum>
				                    <SumEquivalent>1200.11</SumEquivalent>
			                    </Transaction>
			                    <Transaction>
				                    <Date>12.12.2012</Date>
				                    <Branch>12</Branch>
				                    <Operation>12</Operation>
				                    <Currency>840</Currency>
				                    <Sum>120.12</Sum>
				                    <SumEquivalent>1200.11</SumEquivalent>
			                    </Transaction>
		                    </Transactions>
	                    </TransactionCollection>
                    </LimitStatus>";
            }
        }

        [Serializable]
        public class LimitStatus
        {
            [XmlElement("Success")]
            public bool Success { get; set; }
            [XmlElement("ErrorMessage")]
            public string ErrorMessage { get; set; }
            [XmlElement("OperationCollection")]
            public OperationCollection OperationCollection { get; set; }

            [XmlElement("TransactionCollection")]
            public TransactionCollection TransactionCollection { get; set; }
        }

        [Serializable]
        public class Operation
        {
            [XmlElement("Limit")]
            public string Limit { get; set; }

            [XmlElement("Sum")]
            public Decimal? Sum { get; set; }
        }

        [Serializable]
        [XmlRoot("OperationCollection")]
        public class OperationCollection
        {
            [XmlArray("Operations")]
            [XmlArrayItem("Operation", typeof(Operation))]
            public Operation[] Operations { get; set; }
        }

        [Serializable]
        public class Transaction
        {
            [XmlElement("Date")]
            public DateTime? Date { get; set; }

            [XmlElement("Branch")]
            public string Branch { get; set; }

            [XmlElement("Operation")]
            public string Operation { get; set; }

            [XmlElement("Currency")]
            public string Currency { get; set; }

            [XmlElement("Sum")]
            public decimal? Sum { get; set; }

            [XmlElement("SumEquivalent")]
            public decimal? SumEquivalent { get; set; }
        }

        [Serializable]
        [XmlRoot("TransactionCollection")]
        public class TransactionCollection
        {
            [XmlArray("Transactions")]
            [XmlArrayItem("Transaction", typeof(Transaction))]
            public Transaction[] Transactions { get; set; }
        }

        #endregion

        /// <summary>
        /// Получить список переводов
        /// </summary>
        /// <param name="searchInfo">Информация для поиска переводов</param>
        /// <returns>Текстовое сообщение о статусе лимита</returns>
        /// <exception cref="Exception"></exception>
        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public List<Transfer> GetTransfers(TransferSearchInfo searchInfo)
        {
            String userName = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Username"];
            String password = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Pass"];

            // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated) LoginUser(userName);

            var result = new List<Transfer>();
            OracleConnection con = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.BindByName = true;
                bool hasSeriesFilter = !string.IsNullOrEmpty(searchInfo.Series);

                cmd.CommandText =
                    string.Format(@"select t.id, s.name, t.doc_series, t.doc_number, t.fio, t.birth_date, t.s_equivalent/100 s_equivalent, {0} matchSeries from lcs_transactions t, lcs_sources s where t.doc_number = :docNumber and t.src_id = s.id",
                    hasSeriesFilter ? "(case when t.doc_series=:docSeries then 1 else 0 end)" : "0");
                cmd.Parameters.Add("docNumber", searchInfo.Number);
                if (hasSeriesFilter)
                {
                    cmd.Parameters.Add("docSeries", searchInfo.Series);
                }
                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    if (reader != null)
                    {
                        while (reader.Read())
                        {
                            bool matchSeries = ((int)reader.GetDecimal(reader.GetOrdinal("matchSeries"))) == 1;
                            result.Add(new Transfer
                            {
                                Name = reader["fio"] == DBNull.Value ? "" : reader["fio"].ToString(),
                                Series = reader["doc_series"] == DBNull.Value ? "" : reader["doc_series"].ToString(),
                                Number = reader["doc_number"] == DBNull.Value ? "" : reader["doc_number"].ToString(),
                                Id = reader["id"] == DBNull.Value ? "" : reader["id"].ToString(),
                                System = reader["name"] == DBNull.Value ? "" : reader["name"].ToString(),
                                BirthDate = reader["birth_date"] == DBNull.Value ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("birth_date")),
                                Sum = reader["s_equivalent"] == DBNull.Value ? (decimal?)null : reader.GetDecimal(reader.GetOrdinal("s_equivalent")),
                                Editable = !matchSeries,
                                Selected = matchSeries
                            });
                        }
                    }
                }
            }
            finally
            {
                con.Close();
            }
            return result;
        }

        /// <summary>
        /// Подтвердить список переводов
        /// </summary>
        /// <param name="transfers">Список идентификаторов переводов</param>
        /// <param name="searchInfo">Информация, которую пользователь указал при поиске</param>
        /// <param name="currentUser">Пользователь, который авторизирован в web-е</param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        [WebMethod(EnableSession = true)]
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.InOut)]
        public ConformationResponse ConfirmTransfers(TransferSearchInfo searchInfo, List<string> transfers,
            string currentUser)
        {
            String userName = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Username"];
            String password = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Pass"];

            // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated) LoginUser(userName);

            OracleConnection con = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "lcs_pack.audit";
                cmd.Parameters.Add(new OracleParameter("p_user", OracleDbType.Varchar2) { Value = currentUser });
                cmd.Parameters.Add(new OracleParameter("p_doc_series", OracleDbType.Varchar2)
                {
                    Value = searchInfo.Series
                });
                cmd.Parameters.Add(new OracleParameter("p_doc_number", OracleDbType.Varchar2)
                {
                    Value = searchInfo.Number
                });
                cmd.Parameters.Add(new OracleParameter("p_id_list", OracleDbType.Varchar2)
                {
                    Value = string.Join(",", transfers.Select(t => "'" + t + "'"))
                });
                cmd.Parameters.Add(new OracleParameter
                {
                    ParameterName = "p_success",
                    OracleDbType = OracleDbType.Int32,
                    Direction = ParameterDirection.Output
                });
                cmd.Parameters.Add(new OracleParameter
                {
                    ParameterName = "p_message",
                    OracleDbType = OracleDbType.Varchar2,
                    Size = 500,
                    Direction = ParameterDirection.Output
                });
                cmd.Parameters.Add(new OracleParameter
                {
                    ParameterName = "p_error_msg",
                    OracleDbType = OracleDbType.Varchar2,
                    Size = 500,
                    Direction = ParameterDirection.Output
                });
                cmd.ExecuteNonQuery();
                bool success = cmd.Parameters["p_success"].Value.ToString() == "1";
                string message = ((OracleString)cmd.Parameters["p_message"].Value).ToString();
                string errorMessage = ((OracleString)cmd.Parameters["p_error_msg"].Value).ToString();
                return new ConformationResponse
                {
                    Success = success,
                    Message = message,
                    ErrorMessage = errorMessage
                };
            }
            finally
            {
                con.Close();
            }
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public RequestResultDecimal GetExceptionFlagByNazn(string nazn)
        {
             RequestResultDecimal res = new RequestResultDecimal();
        /*
        if (!tryLogin(res)) return res;

        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        */
                  String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Username"];
                  String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Pass"];
                  Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
                  if (isAuthenticated) LoginUser(barsUserName);

                 OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
                 OracleCommand cmd = con.CreateCommand();

        try
            {
                Decimal? retSos;

                cmd.Parameters.Add("p_nazn", OracleDbType.Varchar2, nazn, ParameterDirection.Input);
                cmd.CommandText = "select lcs_pack.f_get_exception_by_nazn(:p_nazn) from dual";

                object result = cmd.ExecuteScalar();

                retSos = (result == null) ? 0 : (Convert.ToDecimal(result));

                if (result == null)
                {
                    res.Kind = ResultKinds.Error;
                    res.Errors.Add(new ErrorMessage() { Code = "LCS_PAYSERVICE", Message = "Помилка визначення Ознаки винятку" });
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
                res.Errors.Add(new ErrorMessage() { Code = "LCS_PAYSERVICE", Message = e.Message });
            }
            finally
            {
                con.Close();
                con.Dispose();
                cmd.Dispose();
            }

            return res;
        }


    /// <summary>
    ///  Перевірка зі списком BLACKLIST
    /// </summary>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public String GetBlackList(String ida, String idb, String mfoa, String mfob, String namea, String nameb, String nlsa, String nlsb)
    {
        String barsUserName = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Username"];
        String barsPassword = Bars.Configuration.ConfigurationSettings.AppSettings["LCS.Pass"];
        Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(barsUserName, barsPassword, true);
        if (isAuthenticated) LoginUser(barsUserName);

        OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();

        using (con)
        {
            cmd.CommandText =
                "select lcs_pack.f_get_blacklist(:p_ida, :p_idb, :p_mfoa, :p_mfob, :p_namea, :p_nameb, :p_nlsa, :p_nlsb) as Result from dual";
            cmd.Parameters.Add("p_ida", OracleDbType.Varchar2, ida, ParameterDirection.Input);
            cmd.Parameters.Add("p_idb", OracleDbType.Varchar2, idb, ParameterDirection.Input);
            cmd.Parameters.Add("p_mfoa", OracleDbType.Varchar2, mfoa, ParameterDirection.Input);
            cmd.Parameters.Add("p_mfob", OracleDbType.Varchar2, mfob, ParameterDirection.Input);
            cmd.Parameters.Add("p_namea", OracleDbType.Varchar2, namea, ParameterDirection.Input);
            cmd.Parameters.Add("p_nameb", OracleDbType.Varchar2, nameb, ParameterDirection.Input);
            cmd.Parameters.Add("p_nlsa", OracleDbType.Varchar2, nlsa, ParameterDirection.Input);
            cmd.Parameters.Add("p_nlsb", OracleDbType.Varchar2, nlsb, ParameterDirection.Input);
            OracleDataReader rdr = cmd.ExecuteReader();
            using (rdr)
            {
                if (rdr.Read())
                {
                    String result = rdr["Result"] == DBNull.Value ? null : (String)rdr["Result"];
                    if (result != null)
                    {
                        return result;
                    }
                }
            }
        }
        return null;
    }


}

