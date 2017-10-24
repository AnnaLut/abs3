using System;
using System.Data;
using System.Web;
using System.Web.Services;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using barsroot.core;
using BarsWeb.Core.Logger;
using System.Collections.Generic;
using System.Globalization;
using System.Web.Services.Protocols;
/*using DsLib;
using DsLib.Algorithms;*/


/// <summary>
/// XRMIntegrationUtl сервис интеграции с Единым окном
/// </summary>
/// 
namespace Bars.WebServices
{

    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-utl.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class XRMIntegrationUtl : BarsWebService
    {
        public WsHeader WsHeaderValue;
        public static String TransactionErrorMessage = "Помилка получения транзакции {0} из БД";
        public static String TransactionExistsMessage = "TransactionID {0} вже була проведена";
        public static CultureInfo CXRMinfo()
        {
            CultureInfo cXRMinfo = CultureInfo.CreateSpecificCulture("en-GB");

            cXRMinfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
            cXRMinfo.DateTimeFormat.DateSeparator = "/";

            cXRMinfo.NumberFormat.NumberDecimalSeparator = ".";
            cXRMinfo.NumberFormat.CurrencyDecimalSeparator = ".";

            return cXRMinfo;
        }
        #region OracleHelper
        public static class OracleHelper
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
        #endregion OracleHelper     
        #region GMT
        public static DateTime? GmtToLocal(DateTime? dateTime)
        {
            if (dateTime.HasValue && dateTime != null)
            {
                TimeZoneInfo tz = TimeZoneInfo.Local;
                DateTime _dateTime = dateTime.Value;
                return TimeZoneInfo.ConvertTimeFromUtc(_dateTime, tz);
            }
            else { return null; }
        }
        #endregion GMT
        #region Transaction       
        public class TransactionInfo
        {
            public Decimal TransactionId;
            public String UserLogin;
            public Int16 OperationType;
            public String Description;
        }
        public static void TransactionCreate(TransactionInfo Transaction, OracleConnection con)
        {
            HttpContext ctx = HttpContext.Current;
            OracleCommand cmdTrans = con.CreateCommand();
            try
            {
                cmdTrans.CommandType = CommandType.StoredProcedure;
                cmdTrans.CommandText = "xrm_ui_oe.xrm_audit";
                cmdTrans.BindByName = true;
                cmdTrans.Parameters.Clear();
                cmdTrans.Parameters.Add("p_TransactionId", OracleDbType.Decimal, Transaction.TransactionId, ParameterDirection.Input);
                cmdTrans.Parameters.Add("p_TranType", OracleDbType.Decimal, Transaction.OperationType, ParameterDirection.Input);
                cmdTrans.Parameters.Add("p_Description", OracleDbType.Varchar2, Transaction.Description, ParameterDirection.Input);
                cmdTrans.Parameters.Add("p_user_login", OracleDbType.Varchar2, Transaction.UserLogin, ParameterDirection.Input);
                cmdTrans.ExecuteNonQuery();
            }
            catch (System.Exception e)
            {
                DbLoggerConstruct.NewDbLogger().Info(e.StackTrace + e.Message, "XRMIntegrationCustomer(Common)");
            }
            finally
            {
                cmdTrans.Dispose();
            }
        }
        public static decimal TransactionCheck(TransactionInfo Transaction, OracleConnection con)
        {
            decimal res = 1; // считаем, что все плохо
            HttpContext ctx = HttpContext.Current;
            OracleCommand cmdTrans = con.CreateCommand();
            try
            {
                cmdTrans.CommandType = CommandType.StoredProcedure;
                cmdTrans.CommandText = "xrm_ui_oe.CheckTrasaction";
                cmdTrans.BindByName = true;

                cmdTrans.Parameters.Clear();
                cmdTrans.Parameters.Add("p_TransactionId", OracleDbType.Decimal, Transaction.TransactionId, ParameterDirection.Input);
                cmdTrans.Parameters.Add("p_TransactionResult", OracleDbType.Decimal, res, ParameterDirection.Output);
                cmdTrans.ExecuteNonQuery();
                res = ((OracleDecimal)cmdTrans.Parameters["p_TransactionResult"].Value).Value;
            }
            catch (System.Exception e)
            {
                DbLoggerConstruct.NewDbLogger().Info(e.StackTrace + e.Message, "XRMIntegrationCustomer");
            }
            finally
            {
                cmdTrans.Dispose();
            }
            return res;
            
        }
        #endregion Transaction
        #region Sign
        /*
        private bool Validate(byte[] Buffer, byte[] Sign)
        {
            DbLoggerConstruct.NewDbLogger().Info("Validate Start", "Validate");
            bool ret = false;
            try
            {
                //передаем сертификат
                CmsSigned cms = new CmsSigned(Sign);
                byte[] cert = cms.getAdditionalCertificate(0).getEncoded();
                cms.getSigner(0).setCertificateData(cert);
                if (cms.isContentAttached())
                {
                    DbLoggerConstruct.NewDbLogger().Warning("Content Attached", "Validate");
                }
                cms.verifyBegin(new InternationalAlgFactory(), null);
                cms.verifyUpdate(Buffer); //передаем буфер(документ)
                SignerInfo si = cms.verifySigner(0);

                if (si == null)
                    ret = false;
                else
                    ret = true;
            }
            catch (System.Exception ex)
            {
                DbLoggerConstruct.NewDbLogger().Error("Validate Exception " + ex.Message);
                DbLoggerConstruct.NewDbLogger().Error("Validate Exception StackTrace " + ex.StackTrace);
                DbLoggerConstruct.NewDbLogger().Exception(ex);
            }
            Console.WriteLine("Validate Stop");
            DbLoggerConstruct.NewDbLogger().Info("Validate Stop", "Validate");
            return ret;
            //return true; //временное отключение валидации подписи vega2
        }
        //Конвертация массива байт в хекс строку
        static string ToHex(byte[] Buffer)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < Buffer.Length; i++)
            {
                sb.Append(Buffer[i].ToString("X2"));
            }

            return sb.ToString();
        }

        /// HEX строка в бинарную
        /// </summary>
        /// <param name="source"></param>
        /// <returns></returns>
        public byte[] HexToBin(string sourceHex)
        {
            string result = string.Empty;
            byte[] binary = new byte[sourceHex.Length / 2];
            for (int i = 0; i < binary.Length; i++)
                binary[i] = byte.Parse(sourceHex.Substring(i * 2, 2), System.Globalization.NumberStyles.HexNumber);
            return binary;
        }


        //    Получения списка идентификаторов подписей
        //    В случае ошибки возвращает пустой список

        static List<string> GetUsersHash(byte[] Sign)
        {
            List<string> hashs = new List<string>();
            try
            {
                CmsSigned cms = new CmsSigned(Sign);
                int count = cms.getSignerCount();
                for (int i = 0; i < count; i++)
                {
                    Certificate cert = cms.getAdditionalCertificate(i);

                    byte[] Serial = cert.getSerial();
                    byte[] _Serial = new byte[Serial.Length - 2];
                    Array.Copy(Serial, 2, Serial, 0, Serial.Length);
                    string buffer = ToHex(_Serial) + '|' + ToHex(cert.getAuthorityKeyIdentifier());
                    MD5 md5 = MD5.Create();
                    byte[] hash = md5.ComputeHash(Encoding.ASCII.GetBytes(buffer));
                    hashs.Add(ToHex(hash));
                }
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.Message);
                return new List<string>();
            }

            return hashs;
        }
        public SignResponce techSing(byte[] Buffer)
        {
            SignResponce res = new SignResponce();
            try
            {
                HttpWebRequest request = WebRequest.Create(ConfigurationManager.AppSettings["sign.ServerLink"] + "/sign") as HttpWebRequest;
                request.Method = "POST";
                request.ContentType = "application/json";
                request.Accept = "application/json";

                SignRequest req = new SignRequest();
                req.Buffer = ToHex(Buffer);
                req.IdOper = ConfigurationManager.AppSettings["sign.IdOper"];
                req.ModuleName = ConfigurationManager.AppSettings["sign.ModuleName"];
                req.TokenId = ConfigurationManager.AppSettings["sign.TokenId"];

                JavaScriptSerializer oSerializer = new JavaScriptSerializer();
                oSerializer.MaxJsonLength = Int32.MaxValue;
                string sb = oSerializer.Serialize(req);

                var bt = Encoding.UTF8.GetBytes(sb);
                Stream st = request.GetRequestStream();
                st.Write(bt, 0, bt.Length);
                st.Close();

                using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                {
                    if (response.StatusCode != HttpStatusCode.OK)
                    {
                        res.State = "Error";
                        res.Error = String.Format("Error connection to Sign server (HTTP {0}: {1}).", response.StatusCode, response.StatusDescription);
                    }

                    StreamReader sr = new StreamReader(response.GetResponseStream());
                    res = oSerializer.Deserialize<SignResponce>(sr.ReadToEnd());
                }
            }
            catch (System.Exception ex)
            {
                res.State = "Error";
                res.Error = ex.Message;
            }
            return res;
        }*/
        #endregion Sign
        #region LoginService   

        public void LoginADUserInt(String userName)
        {
            // информация о текущем пользователе
            try
            {
                InitOraConnection();
                string ipAddress = RequestHelpers.GetClientIpAddress(HttpContext.Current.Request);
                // установка первичных параметров
                ClearParameters();
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_login_name", DB_TYPE.Varchar2, userName, DIRECTION.Input);
                SetParameters("p_authentication_mode", DB_TYPE.Varchar2, "ACTIVE DIRECTORY", DIRECTION.Input);
                SetParameters("p_hostname", DB_TYPE.Varchar2, ipAddress, DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");

                ClearParameters();
                SetParameters("p_info", DB_TYPE.Varchar2,
                    String.Format("XRMIntegration: авторизация. Хост {0}, пользователь {1} ", ipAddress, userName),
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

        public void LoginUserInt(String userName)
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
                    String.Format("XRMIntegration: авторизация. Хост {0}, пользователь {1} ", RequestHelpers.GetClientIpAddress(HttpContext.Current.Request), userName),
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

        #endregion LoginService                 
        #region bankdate
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public String GetBankdateMethod()
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                string BDate = "";
                try
                {
                    XRMUtl.LoginUserInt(System.Configuration.ConfigurationManager.AppSettings["XRM_USER"]);
                    try
                    {
                        using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                        {
                            OracleCommand cmd = con.CreateCommand();
                            try
                            {   // открываем карточный счет
                                cmd.Parameters.Clear();
                                cmd.CommandText = "select to_char(bars.gl.bd, 'yyyy-mm-dd') bdate from dual";
                                using (OracleDataReader reader = cmd.ExecuteReader())
                                {
                                    if (reader.HasRows)
                                    {
                                        int idBdate = reader.GetOrdinal("bdate");

                                        while (reader.Read())
                                        {
                                            BDate = XRMIntegrationUtl.OracleHelper.GetString(reader, idBdate);
                                        }
                                    }
                                }
                                return BDate;
                            }
                            finally { cmd.Dispose(); }
                        }
                    }
                    catch (Exception.AutenticationException)
                    {
                        return BDate;
                    }
                }
                finally { DisposeOraConnection(); }
            }
        }
        #endregion bankdate
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public string GetVersion()
        {
            using (XRMIntegrationUtl XRMUtl = new XRMIntegrationUtl())
            {
                string ver = "";
                try
                {
                    XRMUtl.LoginUserInt(System.Configuration.ConfigurationManager.AppSettings["XRM_USER"]);
                    try
                    {
                        using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                        {
                            OracleCommand cmd = con.CreateCommand();
                            try
                            {   
                                cmd.Parameters.Clear();
                                cmd.CommandText = "select xrm_integration_oe.getversion ver from dual";
                                using (OracleDataReader reader = cmd.ExecuteReader())
                                {
                                    if (reader.HasRows)
                                    {
                                        int idVer = reader.GetOrdinal("ver");

                                        while (reader.Read())
                                        {
                                            ver = XRMIntegrationUtl.OracleHelper.GetString(reader, idVer);
                                        }
                                    }
                                }
                                return ver;
                            }
                            finally { cmd.Dispose(); }
                        }
                    }
                    catch (Exception.AutenticationException)
                    {
                        return ver;
                    }
                }
                finally { DisposeOraConnection(); }
            }
        }
    }
  
}
