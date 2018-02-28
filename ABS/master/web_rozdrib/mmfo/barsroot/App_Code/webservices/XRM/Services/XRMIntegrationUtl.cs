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
using System.IO;
using System.IO.Compression;

/// <summary>
/// XRMIntegrationUtl сервис интеграции с Единым окном
/// </summary>
/// 
namespace Bars.WebServices.XRM.Services
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
        public XRMIntegrationUtl()
        {
            moduleName = "XRMIntegrationUtl";
        }
        public WsHeader WsHeaderValue;

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

        #region bankdate
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public String GetBankdateMethod()
        {
            string BDate = "";
            try
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    LoginUserIntSingleCon(con, System.Configuration.ConfigurationManager.AppSettings["XRM_USER"], false);
                    using (OracleCommand cmd = con.CreateCommand())
                    {
                        cmd.CommandText = "select to_char(bars.gl.bd, 'yyyy-mm-dd') bdate from dual";
                        using (OracleDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                int idBdate = reader.GetOrdinal("bdate");

                                while (reader.Read())
                                {
                                    BDate = OracleHelper.GetString(reader, idBdate);
                                }
                            }
                        }
                        return BDate;
                    }
                }
            }
            catch (Exception.AutenticationException)
            {
                return BDate;
            }
        }
        #endregion bankdate
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public string GetVersion()
        {
            string ver = "";
            try
            {
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    LoginUserIntSingleCon(con, System.Configuration.ConfigurationManager.AppSettings["XRM_USER"], false);

                    using (OracleCommand cmd = con.CreateCommand())
                    {
                        cmd.CommandText = "select xrm_integration_oe.getversion ver from dual";
                        using (OracleDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                int idVer = reader.GetOrdinal("ver");

                                while (reader.Read())
                                {
                                    ver = OracleHelper.GetString(reader, idVer);
                                }
                            }
                        }
                        return ver;
                    }
                }
            }
            catch (Exception.AutenticationException)
            {
                return ver;
            }
        }
    }
}
