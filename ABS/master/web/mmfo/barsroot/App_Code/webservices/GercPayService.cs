using System;
using System.Text;
using System.IO;
using System.Data;
using System.Linq;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using BarsWeb.Core.Logger;
using Bars.Application;
using DsLib;
using DsLib.Algorithms;
using System.Security.Cryptography;
using System.Web.Script.Serialization;
using System.Net;
using System.Configuration;
using Bars.WebServices.GercPayModels;
using Bars.WebServices.GercPayModels.OracleHelper;

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


    /// <summary>
    /// Веб-сервіс для взаємодії з системою Герц СППН
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]

    public class GercService : BarsWebService
    {
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;

        #region private methods

        private IDbLogger DbLogger()
        {
            if (_dbLogger == null)
                _dbLogger = DbLoggerConstruct.NewDbLogger();
            return _dbLogger;
        }

        private bool Validate(byte[] Buffer, byte[] Sign)
        {
            DbLogger().Info("Validate Start", "Validate");
            bool ret = false;
            try
            {
                //передаем сертификат
                CmsSigned cms = new CmsSigned(Sign);
                byte[] cert = cms.getAdditionalCertificate(0).getEncoded();
                cms.getSigner(0).setCertificateData(cert);
                if (cms.isContentAttached())
                {
                    DbLogger().Warning("Content Attached", "Validate");
                }
                cms.verifyBegin(new InternationalAlgFactory(), null);
                cms.verifyUpdate(Buffer); //передаем буфер(документ)
                SignerInfo si = cms.verifySigner(0);

                ret = !(si == null);
                cert = null;
            }
            catch (System.Exception ex)
            {
                DbLogger().Error("Validate Exception " + ex.Message);
                DbLogger().Error("Validate Exception StackTrace " + ex.StackTrace);
                DbLogger().Exception(ex);
            }
            DbLogger().Info("Validate Stop", "Validate");
            return ret;
            //return true; //временное отключение валидации подписи vega2
        }
        //Конвертация массива байт в хекс строку
        private static string ToHex(byte[] Buffer)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < Buffer.Length; i++)
            {
                sb.Append(Buffer[i].ToString("X2"));
            }

            return sb.ToString();
        }
        #endregion
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

        /*
            Получения списка идентификаторов подписей
            В случае ошибки возвращает пустой список
        */
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
                    Serial = null; _Serial = null; hash = null;
                }
            }
            catch (System.Exception ex)
            {
                return new List<string>();
            }

            return hashs;
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

                    using (StreamReader sr = new StreamReader(response.GetResponseStream()))
                    {
                        res = oSerializer.Deserialize<SignResponce>(sr.ReadToEnd());
                    }
                }
            }
            catch (System.Exception ex)
            {
                res.State = "Error";
                res.Error = ex.Message;
            }
            return res;
        }

        #region методы веб-сервиса ПЛАТЕЖИ
        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public CreateDocumentsResponse CreateDocuments(DocumentData[] Documents)
        {
            CreateDocumentsResponse response = new CreateDocumentsResponse();
            List<CreateDocumentResult> CreateDocumentResultSets = new List<CreateDocumentResult>();
            String errmsg = "Ok";

            try
            {
                try
                {
                    LoginUser();
                }
                catch (Exception.AutenticationException aex)
                {
                    return new CreateDocumentsResponse() { ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message) };
                }

                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    DbLogger().Info("CreateDocuments-try", "GercService");
                    using (OracleCommand cmd = con.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        int alldocs = Documents.Count();

                        DbLogger().Info("CreateDocuments:alldocs = " + Convert.ToString(alldocs), "GercService");
                        foreach (DocumentData Doc in Documents)
                        {
                            DbLogger().Info("CreateDocuments:counter = " + Convert.ToString(CreateDocumentResultSets.Count), "GercService");
                            CreateDocumentResult CreateDocumentResultSet = new CreateDocumentResult();

                            // набрать буфер из параметров документа
                            string mass = "";

                            using (OracleCommand cmd_buffer = con.CreateCommand())
                            {
                                cmd_buffer.CommandType = CommandType.StoredProcedure;
                                cmd_buffer.Parameters.Clear();
                                cmd_buffer.CommandText = "BARS.GERC_PAYMENTS.GetBuffer";
                                cmd_buffer.Parameters.Add("p_nd", OracleDbType.Varchar2, Doc.ExternalDocumentId, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_date", OracleDbType.Date, Doc.DocumentDate, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_mfoa", OracleDbType.Varchar2, Doc.DebitMfo, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_mfob", OracleDbType.Varchar2, Doc.CreditMfo, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_nlsa", OracleDbType.Varchar2, Doc.DebitAccount, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_nlsb", OracleDbType.Varchar2, Doc.CreditAccount, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_okpoa", OracleDbType.Varchar2, Doc.DebitEdrpou, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_okpob", OracleDbType.Varchar2, Doc.CreditEdrpou, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_kv", OracleDbType.Varchar2, Doc.Currency, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_s", OracleDbType.Decimal, Doc.Amount, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_nama", OracleDbType.Varchar2, Doc.DebitName, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_namb", OracleDbType.Varchar2, Doc.CreditName, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_nazn", OracleDbType.Varchar2, Doc.Purpose, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_dk", OracleDbType.Decimal, Doc.DebitFlag, ParameterDirection.Input);
                                cmd_buffer.Parameters.Add("p_buffer", OracleDbType.Varchar2, 365, null, ParameterDirection.Output);

                                cmd_buffer.ExecuteNonQuery();
                                object resBuffer = cmd_buffer.Parameters["p_buffer"].Value;
                                mass = (resBuffer == null || ((OracleString)resBuffer).IsNull) ? null : ((OracleString)resBuffer).Value;
                                DbLogger().Info("CreateDocuments: mass = " + Convert.ToString(mass), "GercService");

                                //выставить правильную кодировку
                                byte[] buff = System.Text.Encoding.UTF8.GetBytes(mass);
                                //File.WriteAllBytes("c:/bars/print/test.txt", buff); 

                                byte[] sign = Convert.FromBase64String(Doc.DigitalSignature);
                                bool res = Validate(buff, sign);

                                string validres;
                                //res = true;

                                if (res) { validres = "PASS"; } else { validres = "FAIL"; }

                                using (OracleCommand cmd_ValidationRes = con.CreateCommand())
                                {
                                    cmd_ValidationRes.CommandType = CommandType.StoredProcedure;
                                    cmd_ValidationRes.Parameters.Clear();
                                    cmd_ValidationRes.CommandText = "BARS.GERC_PAYMENTS.PutValidationResult";
                                    //cmd_ValidationRes.Parameters.Add("p_nd", OracleDbType.Varchar2, Doc.DocumentNumber, ParameterDirection.Input);
                                    cmd_ValidationRes.Parameters.Add("p_externalDocId", OracleDbType.Varchar2, Doc.ExternalDocumentId, ParameterDirection.Input);
                                    cmd_ValidationRes.Parameters.Add("p_buffer", OracleDbType.Varchar2, System.Text.Encoding.UTF8.GetString(buff), ParameterDirection.Input);
                                    cmd_ValidationRes.Parameters.Add("p_sign", OracleDbType.Varchar2, Doc.DigitalSignature, ParameterDirection.Input);
                                    cmd_ValidationRes.Parameters.Add("p_ValidationResult", OracleDbType.Varchar2, validres, ParameterDirection.Input);
                                    cmd_ValidationRes.ExecuteNonQuery();

                                    if (res)                                    
                                    {
                                        //sign is correct
                                        cmd.Parameters.Clear();
                                        cmd.CommandText = "BARS.GERC_PAYMENTS.CreateDoc";
                                        cmd.Parameters.Add("p_nd", OracleDbType.Varchar2, Doc.DocumentNumber, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_externalDocId", OracleDbType.Varchar2, Doc.ExternalDocumentId, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_date", OracleDbType.Date, Doc.DocumentDate, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, Doc.Branch, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_mfoa", OracleDbType.Varchar2, Doc.DebitMfo, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_mfob", OracleDbType.Varchar2, Doc.CreditMfo, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_nlsa", OracleDbType.Varchar2, Doc.DebitAccount, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_nlsb", OracleDbType.Varchar2, Doc.CreditAccount, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_okpoa", OracleDbType.Varchar2, Doc.DebitEdrpou, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_okpob", OracleDbType.Varchar2, Doc.CreditEdrpou, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_kv", OracleDbType.Varchar2, Doc.Currency, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_s", OracleDbType.Decimal, Doc.Amount, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_nama", OracleDbType.Varchar2, Doc.DebitName, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_namb", OracleDbType.Varchar2, Doc.CreditName, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_nazn", OracleDbType.Varchar2, Doc.Purpose, ParameterDirection.Input);

                                        cmd.Parameters.Add("p_sk", OracleDbType.Decimal, Doc.CashSymbol, ParameterDirection.Input);

                                        cmd.Parameters.Add("p_dk", OracleDbType.Decimal, Doc.DebitFlag, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_vob", OracleDbType.Decimal, Doc.DocumentType, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_drec", OracleDbType.Varchar2, Doc.AdditionalRequisites, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_sign", OracleDbType.Varchar2, Doc.DigitalSignature, ParameterDirection.Input);
                                        cmd.Parameters.Add("CreatedByUserName", OracleDbType.Varchar2, Doc.DocumentAuthor, ParameterDirection.Input);
                                        cmd.Parameters.Add("ConfirmedByUserName", OracleDbType.Varchar2, Doc.DocumentAuthor, ParameterDirection.Input);
                                        cmd.Parameters.Add("TT", OracleDbType.Varchar2, Doc.OperationType, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_our_buffer", OracleDbType.Varchar2, mass, ParameterDirection.Input);
                                        cmd.Parameters.Add("p_ref", OracleDbType.Decimal, null, ParameterDirection.Output);
                                        cmd.Parameters.Add("p_errcode", OracleDbType.Decimal, null, ParameterDirection.Output);
                                        cmd.Parameters.Add("p_errmsg", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                                        cmd.Parameters.Add("p_operw", OracleDbType.Varchar2, Doc.AdditionalOperRequisites, ParameterDirection.Input);

                                        cmd.ExecuteNonQuery();

                                        Decimal? retRef;
                                        String retMsg;
                                        Decimal? retCode;

                                        object refDoc = cmd.Parameters["p_ref"].Value;
                                        object resCode = cmd.Parameters["p_errcode"].Value;
                                        object resMsg = cmd.Parameters["p_errmsg"].Value;

                                        retRef = (refDoc == null || ((OracleDecimal)refDoc).IsNull)
                                            ? (Decimal?)null
                                            : ((OracleDecimal)refDoc).Value;
                                        retCode = (resCode == null || ((OracleDecimal)resCode).IsNull)
                                            ? (Decimal?)null
                                            : ((OracleDecimal)resCode).Value;
                                        retMsg = (resMsg == null || ((OracleString)resMsg).IsNull) ? null : ((OracleString)resMsg).Value;

                                        DbLogger().Info("CreateDocuments: retCode " + Convert.ToString(retCode), "GercService");

                                        if (retCode == 0)
                                        {
                                            CreateDocumentResultSet.ExternalDocumentId = Doc.ExternalDocumentId;
                                            CreateDocumentResultSet.DocumentId = retRef;
                                            CreateDocumentResultSet.DocumentStateCode = "Success";
                                            CreateDocumentResultSet.ErrorMessage = "Ok";

                                            //Array.Resize(ref buff, 359);
                                            Encoding cp1251 = Encoding.GetEncoding("windows-1251");
                                            byte[] win1251Buffer = Encoding.Convert(Encoding.UTF8, cp1251, buff);

                                            byte[] tmp_buffer = new byte[359];
                                            Array.Copy(win1251Buffer, tmp_buffer, 359);


                                            //File.WriteAllBytes("d:/bars/print/techsign.txt", tmp_buffer);
                                            SignResponce signRes = techSing(tmp_buffer);
                                            if (signRes.State == "OK")
                                            {
                                                //byte[] techsign = HexToBin(signRes.Sign);
                                                string techsign = signRes.Sign;
                                                DbLogger().Info("CreateDocuments: techsign = " + techsign, "GercService");
                                                using (OracleCommand cmd_putvisa = con.CreateCommand())
                                                {
                                                    cmd_putvisa.CommandType = CommandType.StoredProcedure;
                                                    cmd_putvisa.CommandText = "BARS.GERC_PAYMENTS.doc_visa";
                                                    cmd_putvisa.BindByName = true;
                                                    cmd_putvisa.Parameters.Add("p_ref", OracleDbType.Decimal, retRef, ParameterDirection.Input);
                                                    cmd_putvisa.Parameters.Add("p_idoper", OracleDbType.Varchar2, ConfigurationManager.AppSettings["sign.IdOper"], ParameterDirection.Input);
                                                    cmd_putvisa.Parameters.Add("p_sign", OracleDbType.Varchar2, techsign, ParameterDirection.Input);
                                                    cmd_putvisa.ExecuteNonQuery();
                                                }
                                            }
                                            else
                                            {
                                                DbLogger().Info("CreateDocuments: signRes.Error = " + signRes.Error, "GercService");

                                            }
                                            win1251Buffer = null;
                                            tmp_buffer = null;
                                        }
                                        else
                                        {
                                            CreateDocumentResultSet.ExternalDocumentId = Doc.ExternalDocumentId;
                                            CreateDocumentResultSet.DocumentId = -1;
                                            CreateDocumentResultSet.DocumentStateCode = "Error";
                                            CreateDocumentResultSet.ErrorMessage = retMsg;
                                            errmsg = "CommonRequestError";
                                        }
                                    }
                                    else
                                    {
                                        //sign is wrong   
                                        CreateDocumentResultSet.ExternalDocumentId = Doc.ExternalDocumentId;
                                        CreateDocumentResultSet.DocumentId = -1;
                                        CreateDocumentResultSet.DocumentStateCode = "Error";
                                        CreateDocumentResultSet.ErrorMessage = "Sign Validation error";
                                        errmsg = "Sign Validation error";
                                    }
                                    CreateDocumentResultSets.Add(CreateDocumentResultSet);

                                    DbLogger().Info("CreateDocuments: counter = " + Convert.ToString(CreateDocumentResultSets.Count), "GercService");
                                }
                                buff = null;
                                sign = null;
                            }
                        }
                    }
                    return new CreateDocumentsResponse()
                    {
                        CreateDocumentResults = CreateDocumentResultSets.ToArray(),
                        ErrorMessage = errmsg
                    };
                }
            }
            catch (System.Exception ex)
            {
                return new CreateDocumentsResponse()
                {
                    CreateDocumentResults = CreateDocumentResultSets.ToArray(),
                    ErrorMessage = ex.StackTrace + "//" + ex.Message + "//" + ex.Source + "//" + ex.InnerException
                };
            }
            finally
            {
                DisposeOraConnection();
            }
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public GetDocumentsStateResponse GetDocumentStates(string[] ExternalDocumentIds)
        {
            string errmsg = "";
            try
            {
                try
                {
                    LoginUser();
                }
                catch (Exception.AutenticationException aex)
                {
                    return new GetDocumentsStateResponse() { ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message) };
                }

                using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    DbLogger().Info("GetDocumentStates-try", "GercService");

                    //use list as alternative to avoid "index out of array bounds" errors
                    List<GercPayModels.DocumentState> DocStates = new List<GercPayModels.DocumentState>();
                    //int counter = 1;   //doesnt need any more
                    foreach (string ExternalDocId in ExternalDocumentIds)
                    {
                        GercPayModels.DocumentState OneDocState = new GercPayModels.DocumentState();
                        using (OracleCommand cmd = con.CreateCommand())
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Clear();
                            cmd.BindByName = true;
                            cmd.CommandText = "BARS.GERC_PAYMENTS.GetDocumentState";
                            cmd.Parameters.Add("p_ExternalDocumentID", OracleDbType.Varchar2, ExternalDocId, ParameterDirection.InputOutput);
                            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_StateCode", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ErrorMessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.ExecuteNonQuery();

                            String retExternal;
                            Decimal? retCode;
                            String retMsg;
                            Decimal? retRef;

                            object resExternal = cmd.Parameters["p_ExternalDocumentID"].Value;
                            object resCode = cmd.Parameters["p_StateCode"].Value;
                            object resMsg = cmd.Parameters["p_ErrorMessage"].Value;
                            object resRef = cmd.Parameters["p_ref"].Value;


                            retExternal = ((OracleString)resExternal).Value;
                            retCode = (resCode == null || ((OracleDecimal)resCode).IsNull)
                                ? (Decimal?)null
                                : ((OracleDecimal)resCode).Value;
                            retMsg = ((OracleString)resMsg).Value;
                            retRef = (resRef == null || ((OracleDecimal)resRef).IsNull)
                                ? (Decimal?)null
                                : ((OracleDecimal)resRef).Value;



                            OneDocState.ExternalDocumentId = ExternalDocId;
                            OneDocState.ErrorMessage = retMsg;
                            if (retMsg == "Ok")
                            {
                                OneDocState.DocumentStateCode = Convert.ToString(retCode);
                                OneDocState.DocumentRef = Convert.ToString(retRef);
                            }
                            else
                            {
                                OneDocState.DocumentStateCode = "Unknown";
                                OneDocState.DocumentRef = "Unknown";
                                errmsg = "GetSTates_CommonRequestError";
                            }
                            DocStates.Add(OneDocState);
                        }

                    }

                    //return array as method arguments require
                    return new GetDocumentsStateResponse() { DocumentStates = DocStates.ToArray() };
                }
            }
            catch (System.Exception ex)
            {
                DbLogger().Error("GetDocumentStates exception\n" + ex.Message + "\n" + ex.StackTrace, "GercService");
                return new GetDocumentsStateResponse() { ErrorMessage = errmsg };
            }
            finally { DisposeOraConnection(); }
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public GetBranchResponse GetBranchSet(int AskBranchDataSet)
        {
            try
            {
                try
                {
                    LoginUser();
                }
                catch (Exception.AutenticationException aex)
                {
                    return new GetBranchResponse() { ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message) };
                }
                using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    DbLogger().Info("GetBranchSet-try", "GercService");

                    List<BranchData> BranchDataSets = new List<BranchData>();

                    using (OracleCommand cmd = new OracleCommand("select branch as BranchCode, " +
                                                                 " COALESCE(SUBSTR((SELECT val FROM bars.branch_parameters bp WHERE tag = 'NAME_BRANCH' AND bp.branch = branch.branch), 1, 70), " +
                                                                 " '--' )  as BranchName, " +
                                                                 " COALESCE(SUBSTR((SELECT val FROM bars.branch_parameters bp WHERE tag = 'ADR_BRANCH' AND bp.branch = branch.branch),1, 70),'Addr') AS BranchAddress " +
                                                                 " from bars.branch " +
                                                                 " where date_closed is null or date_closed > TRUNC(SYSDATE)", con))
                    {
                        using (OracleDataReader reader = cmd.ExecuteReader())
                        {

                            if (reader.HasRows)
                            {
                                int idBranchCode = reader.GetOrdinal("BranchCode");
                                int idBranchName = reader.GetOrdinal("BranchName");
                                int idBranchAddress = reader.GetOrdinal("BranchAddress");

                                while (reader.Read())
                                {
                                    BranchData BranchData = new BranchData();
                                    BranchData.BranchCode = OracleHelper.GetString(reader, idBranchCode);
                                    BranchData.BranchName = OracleHelper.GetString(reader, idBranchName);
                                    BranchData.BranchAddress = OracleHelper.GetString(reader, idBranchAddress);
                                    BranchDataSets.Add(BranchData);
                                }
                            }
                            return new GetBranchResponse() { BranchDataSet = BranchDataSets.ToArray() };
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                DbLogger().Error("GetBranchResponse exception\n" + ex.Message + "\n" + ex.StackTrace, "GercService");
                return new GetBranchResponse() { ErrorMessage = ex.Message };
            }
            finally { DisposeOraConnection(); }

        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public GetTTSResponse GetTTSSet(int AskTTSDataSet)
        {
            try
            {
                try
                {
                    LoginUser();
                }
                catch (Exception.AutenticationException aex)
                {
                    return new GetTTSResponse() { ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message) };
                }

                using (OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    DbLogger().Info("GetTTSSet-try", "GercService");
                    GetTTSResponse response = new GetTTSResponse();
                    List<TTSData> TTSDataSets = new List<TTSData>();
                    using (OracleCommand cmd = new OracleCommand("select TT, Name from bars.gerc_tts", con))
                    {
                        using (OracleDataReader reader = cmd.ExecuteReader())
                        {

                            if (reader.HasRows)
                            {
                                int idTTSCode = reader.GetOrdinal("TT");
                                int idTTSName = reader.GetOrdinal("Name");

                                while (reader.Read())
                                {
                                    TTSData TTSData = new TTSData();
                                    TTSData.TTSCode = OracleHelper.GetString(reader, idTTSCode);
                                    TTSData.TTSName = OracleHelper.GetString(reader, idTTSName);
                                    TTSDataSets.Add(TTSData);
                                }
                            }
                        }
                        return new GetTTSResponse() { TTSDataSet = TTSDataSets.ToArray() };
                    }
                }
            }
            catch (System.Exception ex)
            {
                DbLogger().Error("GetTTSResponse exception\n" + ex.Message + "\n" + ex.StackTrace, "GercService");
                return new GetTTSResponse() { ErrorMessage = ex.Message };
            }
            finally { DisposeOraConnection(); }
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public CancelDocumentsResponse SetDocumentStateStorno(int[] ExternalDocumentIds)
        {
            List<CancelDocumentResult> CancelDocumentResultSets = new List<CancelDocumentResult>();
            string errmsg = "Ok";
            try
            {
                try
                {
                    LoginUser();
                }
                catch (Exception.AutenticationException aex)
                {
                    return new CancelDocumentsResponse() { ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message) };
                }
                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    DbLogger().Info("SetDocumentStateStorno-try", "GercService");

                    using (OracleCommand cmd = con.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        int alldocs = ExternalDocumentIds.Count();

                        DbLogger().Info("SetDocumentStateStorno:alldocs = " + Convert.ToString(alldocs), "GercService");
                        foreach (int ExternalDoc in ExternalDocumentIds)
                        {
                            DbLogger().Info("SetDocumentStateStorno:counter = " + Convert.ToString(CancelDocumentResultSets.Count), "GercService");

                            cmd.Parameters.Clear();
                            cmd.CommandText = "BARS.GERC_PAYMENTS.CancelDocument";
                            cmd.Parameters.Add("p_ExternalDocumentId", OracleDbType.Varchar2, ExternalDoc, ParameterDirection.Input);


                            cmd.Parameters.Add("p_ref", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_StateCode", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ErrorMessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.ExecuteNonQuery();

                            Decimal? retRef;
                            String retMsg;
                            Decimal? retCode;

                            object refDoc = cmd.Parameters["p_ref"].Value;
                            object resCode = cmd.Parameters["p_StateCode"].Value;
                            object resMsg = cmd.Parameters["p_ErrorMessage"].Value;

                            retRef = (refDoc == null || ((OracleDecimal)refDoc).IsNull)
                                ? (Decimal?)null
                                : ((OracleDecimal)refDoc).Value;
                            retCode = (resCode == null || ((OracleDecimal)resCode).IsNull)
                                ? (Decimal?)null
                                : ((OracleDecimal)resCode).Value;
                            retMsg = (resMsg == null || ((OracleString)resMsg).IsNull) ? null : ((OracleString)resMsg).Value;

                            DbLogger().Info("CancelDocument: p_ErrorMessage " + Convert.ToString(retCode), "GercService");

                            CancelDocumentResult CancelDocumentResultSet = new CancelDocumentResult();


                            CancelDocumentResultSet.ExternalDocumentId = Convert.ToString(ExternalDoc);
                            if (retCode == -1)
                            {
                                CancelDocumentResultSet.DocumentId = retRef;
                                CancelDocumentResultSet.DocumentStateCode = "Canceled - OK";
                                CancelDocumentResultSet.ErrorMessage = "Ok";
                            }
                            else
                            {
                                CancelDocumentResultSet.DocumentId = -1;
                                CancelDocumentResultSet.DocumentStateCode = "Error during cancel";
                                CancelDocumentResultSet.ErrorMessage = retMsg;
                                errmsg = "CommonRequestError";
                            }
                            CancelDocumentResultSets.Add(CancelDocumentResultSet);

                            DbLogger().Info("CancelDocuments: counter = " + Convert.ToString(CancelDocumentResultSets.Count), "GercService");
                        }
                    }
                }
                return new CancelDocumentsResponse() { CancelDocumentResults = CancelDocumentResultSets.ToArray(), ErrorMessage = errmsg };
            }
            catch (System.Exception ex)
            { return new CancelDocumentsResponse() { CancelDocumentResults = CancelDocumentResultSets.ToArray(), ErrorMessage = ex.StackTrace + "//" + ex.Message + "//" + ex.Source + "//" + ex.InnerException }; }
            finally { DisposeOraConnection(); }
        }
        #endregion
        #region методы веб-сервиса КЛИЕНТЫ

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public UserBranchModel GetUserBranch(string userLogin)
        {
            if (string.IsNullOrWhiteSpace(userLogin))
                throw new ArgumentException("Argument can not be null or empty, argument name 'userLogin'");

            UserBranchModel userBranchModel = new UserBranchModel();
            try
            {
                LoginUser();

                using (OracleConnection connection = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    using (OracleCommand cmd = connection.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.BindByName = true;
                        cmd.CommandText = "GERC_PAYMENTS.GetUserBranch";

                        cmd.Parameters.Add("p_UserLogin", OracleDbType.Varchar2, userLogin, ParameterDirection.Input);
                        cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                        cmd.Parameters.Add("p_ErrorMessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                        cmd.ExecuteNonQuery();

                        var branchResult = (OracleString)cmd.Parameters["p_branch"].Value;
                        var errorResult = (OracleString)cmd.Parameters["p_ErrorMessage"].Value;

                        string branch = branchResult.IsNull ? null : branchResult.Value;
                        string errorMessage = errorResult.IsNull ? null : errorResult.Value;

                        if (string.IsNullOrEmpty(errorMessage))
                            userBranchModel.Branch = branch;
                        else
                            userBranchModel.ErrorMessage = errorMessage;
                    }
                }
            }
            catch (Exception.AutenticationException aex)
            {
                userBranchModel.ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message);
            }
            catch (System.Exception ex)
            {
                userBranchModel.ErrorMessage = ex.StackTrace + "//" + ex.InnerException != null ? ex.InnerException.Message : ex.Message;
            }

            return userBranchModel;
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public SearchClientResult SearchClientMethod(SearchClient[] ClientList)
        {
            string errmsg = "";
            List<ClientReqvisites> FoundClientList = new List<ClientReqvisites>();
            try
            {
                try
                {
                    LoginUser();
                }
                catch (Exception.AutenticationException aex)
                {
                    return new SearchClientResult { ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message) };
                }

                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    DbLogger().Info("SearchClientResult-try", "GercService");
                    //int counter = 1;
                    using (OracleCommand cmd = con.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        foreach (SearchClient ClientRec in ClientList)
                        {
                            ClientReqvisites FoundClientRec = new ClientReqvisites();

                            cmd.Parameters.Clear();
                            cmd.CommandText = "BARS.GERC_PAYMENTS.SearchClient";
                            cmd.Parameters.Add("p_in_RNK", OracleDbType.Decimal, ClientRec.Rnk, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_OKPO", OracleDbType.Varchar2, ClientRec.OKPO, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_NMK", OracleDbType.Varchar2, ClientRec.Nmk, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_CUSTTYPE", OracleDbType.Decimal, ClientRec.CUSTTYPE, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_passtype", OracleDbType.Decimal, ClientRec.PASSP, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_SER", OracleDbType.Varchar2, ClientRec.SER, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_NUMDOC", OracleDbType.Varchar2, ClientRec.DOCNUM, ParameterDirection.Input);

                            cmd.Parameters.Add("p_RNK", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_OKPO", OracleDbType.Varchar2, 10, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_NMK", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_CUSTTYPE", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_COUNTRY", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_NMKV", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_NMKK", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_CODCAGENT", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_PRINSIDER", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ADR", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_C_REG", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_C_DST", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ADM", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_DATE_ON", OracleDbType.Varchar2, 20, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_DATE_OFF", OracleDbType.Varchar2, 20, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_CRISK", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ND", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ISE", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_FS", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_OE", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_VED", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_SED", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_MB", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_RGADM", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_BC", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_BRANCH", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_TOBO", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_K050", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_NREZID_CODE", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_SER", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_NUMDOC", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                            // OperationResult = // 20 найден клиент ЮЛ, 21 найден Не клиент ЮЛ, 30 найден клиент ФЛ, 31 найден не клиент ФЛ
                            cmd.Parameters.Add("p_OperationResult", OracleDbType.Int16, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ErrorMessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.ExecuteNonQuery();

                            Decimal? retRNK;
                            object refRNK = cmd.Parameters["p_RNK"].Value;
                            retRNK = (refRNK == null || ((OracleDecimal)refRNK).IsNull) ? (Decimal?)null : ((OracleDecimal)refRNK).Value;
                            FoundClientRec.RNK = retRNK;

                            FoundClientRec.OKPO = Convert.ToString(cmd.Parameters["p_OKPO"].Value);
                            FoundClientRec.NMK = Convert.ToString(cmd.Parameters["p_NMK"].Value);

                            Decimal? retCUSTTYPE;
                            object refCUSTTYPE = cmd.Parameters["p_CUSTTYPE"].Value;
                            retCUSTTYPE = (refCUSTTYPE == null || ((OracleDecimal)refCUSTTYPE).IsNull) ? (Decimal?)null : ((OracleDecimal)refCUSTTYPE).Value;
                            FoundClientRec.CUSTTYPE = retCUSTTYPE;

                            Decimal? retCOUNTRY;
                            object refCOUNTRY = cmd.Parameters["p_COUNTRY"].Value;
                            retCOUNTRY = (refCOUNTRY == null || ((OracleDecimal)refCOUNTRY).IsNull) ? (Decimal?)null : ((OracleDecimal)refCOUNTRY).Value;
                            FoundClientRec.COUNTRY = retCOUNTRY;

                            FoundClientRec.NMKV = Convert.ToString(cmd.Parameters["p_NMKV"].Value);
                            FoundClientRec.NMKK = Convert.ToString(cmd.Parameters["p_NMKK"].Value);

                            Decimal? retCODAGENT;
                            object refCODAGENT = cmd.Parameters["p_CODCAGENT"].Value;
                            retCODAGENT = (refCODAGENT == null || ((OracleDecimal)refCODAGENT).IsNull) ? (Decimal?)null : ((OracleDecimal)refCODAGENT).Value;
                            FoundClientRec.CODCAGENT = retCODAGENT;

                            Decimal? retPRINSIDER;
                            object refPRINSIDER = cmd.Parameters["p_PRINSIDER"].Value;
                            retPRINSIDER = (refPRINSIDER == null || ((OracleDecimal)refPRINSIDER).IsNull) ? (Decimal?)null : ((OracleDecimal)refPRINSIDER).Value;
                            FoundClientRec.PRINSIDER = retPRINSIDER;

                            FoundClientRec.ADR = Convert.ToString(cmd.Parameters["p_ADR"].Value);

                            Decimal? retC_REG;
                            object refC_REG = cmd.Parameters["p_C_REG"].Value;
                            retC_REG = (refC_REG == null || ((OracleDecimal)refC_REG).IsNull) ? (Decimal?)null : ((OracleDecimal)refC_REG).Value;
                            FoundClientRec.C_REG = retC_REG;

                            Decimal? retC_DST;
                            object refC_DST = cmd.Parameters["p_C_DST"].Value;
                            retC_DST = (refC_DST == null || ((OracleDecimal)refC_DST).IsNull) ? (Decimal?)null : ((OracleDecimal)refC_DST).Value;
                            FoundClientRec.C_DST = retC_DST;

                            FoundClientRec.ADM = Convert.ToString(cmd.Parameters["p_ADM"].Value);
                            FoundClientRec.DATE_ON = Convert.ToString(cmd.Parameters["p_DATE_ON"].Value);
                            FoundClientRec.DATE_OFF = Convert.ToString(cmd.Parameters["p_DATE_OFF"].Value);

                            FoundClientRec.CRISK = Convert.ToString(cmd.Parameters["p_CRISK"].Value);
                            FoundClientRec.ND = Convert.ToString(cmd.Parameters["p_ND"].Value);
                            FoundClientRec.ISE = Convert.ToString(cmd.Parameters["p_ISE"].Value);
                            FoundClientRec.FS = Convert.ToString(cmd.Parameters["p_FS"].Value);
                            FoundClientRec.OE = Convert.ToString(cmd.Parameters["p_OE"].Value);
                            FoundClientRec.VED = Convert.ToString(cmd.Parameters["p_VED"].Value);
                            FoundClientRec.SED = Convert.ToString(cmd.Parameters["p_SED"].Value);
                            FoundClientRec.MB = Convert.ToString(cmd.Parameters["p_MB"].Value);
                            FoundClientRec.RGADM = Convert.ToString(cmd.Parameters["p_RGADM"].Value);

                            Decimal? retBC;
                            object refBC = cmd.Parameters["p_BC"].Value;
                            retBC = (refBC == null || ((OracleDecimal)refBC).IsNull) ? (Decimal?)null : ((OracleDecimal)refBC).Value;
                            FoundClientRec.BC = retBC;

                            FoundClientRec.BRANCH = Convert.ToString(cmd.Parameters["p_BRANCH"].Value);
                            FoundClientRec.TOBO = Convert.ToString(cmd.Parameters["p_TOBO"].Value);
                            FoundClientRec.K050 = Convert.ToString(cmd.Parameters["p_K050"].Value);
                            FoundClientRec.NREZID_CODE = Convert.ToString(cmd.Parameters["p_NREZID_CODE"].Value);

                            FoundClientRec.SER = Convert.ToString(cmd.Parameters["p_SER"].Value);
                            FoundClientRec.DOCNUM = Convert.ToString(cmd.Parameters["p_NUMDOC"].Value);

                            Decimal? retOperationResult;
                            object refOperationResult = cmd.Parameters["p_OperationResult"].Value;
                            retOperationResult = (refOperationResult == null || ((OracleDecimal)refOperationResult).IsNull) ? (Decimal?)null : ((OracleDecimal)refOperationResult).Value;
                            FoundClientRec.OperationResult = retOperationResult;

                            String retMsg;
                            object resMsg = cmd.Parameters["p_ErrorMessage"].Value;
                            retMsg = (resMsg == null || ((OracleString)resMsg).IsNull) ? null : ((OracleString)resMsg).Value;
                            errmsg = retMsg;


                            FoundClientList.Add(FoundClientRec);

                        }
                    }
                }
                return new SearchClientResult() { FoundClient = FoundClientList.ToArray(), ErrorMessage = errmsg };
            }
            catch (System.Exception ex)
            { return new SearchClientResult() { FoundClient = FoundClientList.ToArray(), ErrorMessage = ex.StackTrace + "//" + ex.Message + "//" + ex.Source + "//" + ex.InnerException }; }
            finally { DisposeOraConnection(); }
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public AddClient CreateClientMethod(ClientReqvisites[] ClientList)
        {
            string errmsg = "";
            int pIsFound = 0;
            List<ClientReqvisites> FoundClientList = new List<ClientReqvisites>();
            try
            {
                try
                {
                    LoginUser();
                }
                catch (Exception.AutenticationException aex)
                {
                    return new AddClient { ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message) };
                }

                using (OracleConnection con = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                {
                    DbLogger().Info("RegisterRefreshNonClient-try", "GercService");
                    //int counter = 1;
                    using (OracleCommand cmd = con.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        foreach (ClientReqvisites NewClientRec in ClientList)
                        {
                            ClientReqvisites FoundClientRec = new ClientReqvisites();
                            DbLogger().Info("RegisterRefreshNonClient-try" + NewClientRec.OKPO, "GercService");
                            cmd.Parameters.Clear();
                            cmd.CommandText = "BARS.GERC_PAYMENTS.RegisterRefreshNonClient";
                            cmd.Parameters.Add("p_isnew", OracleDbType.Decimal, 1, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_RNK", OracleDbType.Decimal, NewClientRec.RNK, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_OKPO", OracleDbType.Varchar2, NewClientRec.OKPO, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_NMK", OracleDbType.Varchar2, NewClientRec.NMK, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_CUSTTYPE", OracleDbType.Decimal, NewClientRec.CUSTTYPE, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_passtype", OracleDbType.Decimal, NewClientRec.PASSP, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_SER", OracleDbType.Varchar2, NewClientRec.SER, ParameterDirection.Input);
                            cmd.Parameters.Add("p_in_NUMDOC", OracleDbType.Varchar2, NewClientRec.DOCNUM, ParameterDirection.Input);

                            cmd.Parameters.Add("p_RNK", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_OKPO", OracleDbType.Varchar2, 10, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_NMK", OracleDbType.Varchar2, 4000, NewClientRec.NMK, ParameterDirection.InputOutput);
                            cmd.Parameters.Add("p_CUSTTYPE", OracleDbType.Decimal, NewClientRec.CUSTTYPE, ParameterDirection.InputOutput);
                            cmd.Parameters.Add("p_COUNTRY", OracleDbType.Decimal, NewClientRec.COUNTRY, ParameterDirection.InputOutput);
                            cmd.Parameters.Add("p_NMKV", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_NMKK", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_CODCAGENT", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_PRINSIDER", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ADR", OracleDbType.Varchar2, 4000, NewClientRec.ADR, ParameterDirection.InputOutput);
                            cmd.Parameters.Add("p_C_REG", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_C_DST", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ADM", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_DATE_ON", OracleDbType.Varchar2, 20, NewClientRec.DATE_ON, ParameterDirection.InputOutput);
                            cmd.Parameters.Add("p_DATE_OFF", OracleDbType.Varchar2, 20, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_CRISK", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ND", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ISE", OracleDbType.Varchar2, 4000, NewClientRec.ISE, ParameterDirection.InputOutput);
                            cmd.Parameters.Add("p_FS", OracleDbType.Varchar2, 4000, NewClientRec.FS, ParameterDirection.InputOutput);
                            cmd.Parameters.Add("p_OE", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_VED", OracleDbType.Varchar2, 4000, NewClientRec.VED, ParameterDirection.InputOutput);
                            cmd.Parameters.Add("p_SED", OracleDbType.Varchar2, 4000, NewClientRec.SED, ParameterDirection.InputOutput);
                            cmd.Parameters.Add("p_MB", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_RGADM", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_BC", OracleDbType.Decimal, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_BRANCH", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_TOBO", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_K050", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_NREZID_CODE", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_SER", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_NUMDOC", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_OperationResult", OracleDbType.Int16, null, ParameterDirection.Output);
                            cmd.Parameters.Add("p_ErrorMessage", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                            cmd.ExecuteNonQuery();

                            Decimal? retRNK;
                            object refRNK = cmd.Parameters["p_RNK"].Value;
                            retRNK = (refRNK == null || ((OracleDecimal)refRNK).IsNull) ? (Decimal?)null : ((OracleDecimal)refRNK).Value;
                            FoundClientRec.RNK = retRNK;

                            FoundClientRec.OKPO = Convert.ToString(cmd.Parameters["p_OKPO"].Value);
                            FoundClientRec.NMK = Convert.ToString(cmd.Parameters["p_NMK"].Value);

                            Decimal? retCUSTTYPE;
                            object refCUSTTYPE = cmd.Parameters["p_CUSTTYPE"].Value;
                            retCUSTTYPE = (refCUSTTYPE == null || ((OracleDecimal)refCUSTTYPE).IsNull) ? (Decimal?)null : ((OracleDecimal)refCUSTTYPE).Value;
                            FoundClientRec.CUSTTYPE = retCUSTTYPE;

                            Decimal? retCOUNTRY;
                            object refCOUNTRY = cmd.Parameters["p_COUNTRY"].Value;
                            retCOUNTRY = (refCOUNTRY == null || ((OracleDecimal)refCOUNTRY).IsNull) ? (Decimal?)null : ((OracleDecimal)refCOUNTRY).Value;
                            FoundClientRec.COUNTRY = retCOUNTRY;

                            FoundClientRec.NMKV = Convert.ToString(cmd.Parameters["p_NMKV"].Value);
                            FoundClientRec.NMKK = Convert.ToString(cmd.Parameters["p_NMKK"].Value);

                            Decimal? retCODAGENT;
                            object refCODAGENT = cmd.Parameters["p_CODCAGENT"].Value;
                            retCODAGENT = (refCODAGENT == null || ((OracleDecimal)refCODAGENT).IsNull) ? (Decimal?)null : ((OracleDecimal)refCODAGENT).Value;
                            FoundClientRec.CODCAGENT = retCODAGENT;

                            Decimal? retPRINSIDER;
                            object refPRINSIDER = cmd.Parameters["p_PRINSIDER"].Value;
                            retPRINSIDER = (refPRINSIDER == null || ((OracleDecimal)refPRINSIDER).IsNull) ? (Decimal?)null : ((OracleDecimal)refPRINSIDER).Value;
                            FoundClientRec.PRINSIDER = retPRINSIDER;

                            FoundClientRec.ADR = Convert.ToString(cmd.Parameters["p_ADR"].Value);

                            Decimal? retC_REG;
                            object refC_REG = cmd.Parameters["p_C_REG"].Value;
                            retC_REG = (refC_REG == null || ((OracleDecimal)refC_REG).IsNull) ? (Decimal?)null : ((OracleDecimal)refC_REG).Value;
                            FoundClientRec.C_REG = retC_REG;

                            Decimal? retC_DST;
                            object refC_DST = cmd.Parameters["p_C_DST"].Value;
                            retC_DST = (refC_DST == null || ((OracleDecimal)refC_DST).IsNull) ? (Decimal?)null : ((OracleDecimal)refC_DST).Value;
                            FoundClientRec.C_DST = retC_DST;

                            FoundClientRec.ADM = Convert.ToString(cmd.Parameters["p_ADM"].Value);
                            FoundClientRec.DATE_ON = Convert.ToString(cmd.Parameters["p_DATE_ON"].Value);
                            FoundClientRec.DATE_OFF = Convert.ToString(cmd.Parameters["p_DATE_OFF"].Value);

                            FoundClientRec.CRISK = Convert.ToString(cmd.Parameters["p_CRISK"].Value);
                            FoundClientRec.ND = Convert.ToString(cmd.Parameters["p_ND"].Value);
                            FoundClientRec.ISE = Convert.ToString(cmd.Parameters["p_ISE"].Value);
                            FoundClientRec.FS = Convert.ToString(cmd.Parameters["p_FS"].Value);
                            FoundClientRec.OE = Convert.ToString(cmd.Parameters["p_OE"].Value);
                            FoundClientRec.VED = Convert.ToString(cmd.Parameters["p_VED"].Value);
                            FoundClientRec.SED = Convert.ToString(cmd.Parameters["p_SED"].Value);
                            FoundClientRec.MB = Convert.ToString(cmd.Parameters["p_MB"].Value);
                            FoundClientRec.RGADM = Convert.ToString(cmd.Parameters["p_RGADM"].Value);
                            FoundClientRec.PASSP = NewClientRec.PASSP;
                            Decimal? retBC;
                            object refBC = cmd.Parameters["p_BC"].Value;
                            retBC = (refBC == null || ((OracleDecimal)refBC).IsNull) ? (Decimal?)null : ((OracleDecimal)refBC).Value;
                            FoundClientRec.BC = retBC;

                            FoundClientRec.BRANCH = Convert.ToString(cmd.Parameters["p_BRANCH"].Value);
                            FoundClientRec.TOBO = Convert.ToString(cmd.Parameters["p_TOBO"].Value);
                            FoundClientRec.K050 = Convert.ToString(cmd.Parameters["p_K050"].Value);
                            FoundClientRec.NREZID_CODE = Convert.ToString(cmd.Parameters["p_NREZID_CODE"].Value);

                            FoundClientRec.SER = Convert.ToString(cmd.Parameters["p_SER"].Value);
                            FoundClientRec.DOCNUM = Convert.ToString(cmd.Parameters["p_NUMDOC"].Value);

                            Decimal? retOperationResult;
                            object refOperationResult = cmd.Parameters["p_OperationResult"].Value;
                            retOperationResult = (refOperationResult == null || ((OracleDecimal)refOperationResult).IsNull) ? (Decimal?)null : ((OracleDecimal)refOperationResult).Value;
                            FoundClientRec.OperationResult = retOperationResult;

                            String retMsg;
                            object resMsg = cmd.Parameters["p_ErrorMessage"].Value;
                            retMsg = (resMsg == null || ((OracleString)resMsg).IsNull) ? null : ((OracleString)resMsg).Value;
                            errmsg = retMsg;


                            FoundClientList.Add(FoundClientRec);
                            if (FoundClientRec.OperationResult == 302 || FoundClientRec.OperationResult == -1)
                            { pIsFound = 0; }
                            else { pIsFound = 1; }
                        }
                    }
                }
                return new AddClient() { GercClient = FoundClientList.ToArray(), ErrorMessage = errmsg, IsFound = pIsFound };
            }
            catch (System.Exception ex)
            { return new AddClient() { GercClient = FoundClientList.ToArray(), ErrorMessage = ex.StackTrace + "//" + ex.Message + "//" + ex.Source + "//" + ex.InnerException, IsFound = pIsFound }; }
            finally { DisposeOraConnection(); }
        }
        #endregion методы веб-сервиса КЛИЕНТЫ

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public CheckAccResult CheckAccountByBranch(CheckAccByBranch request)
        {
            CheckAccResult response = new CheckAccResult();
            try
            {
                LoginUser();

                using (OracleConnection connection = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.BindByName = true;
                    cmd.CommandText = "BARS.Gerc_Payments.CheckAccountByBranch";

                    cmd.Parameters.Add("p_branch", OracleDbType.Varchar2, 4000, request.Branch, ParameterDirection.Input);
                    cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, 4000, request.Nls, ParameterDirection.Input);
                    cmd.Parameters.Add("p_kv", OracleDbType.Decimal, request.Kv, ParameterDirection.Input);

                    cmd.Parameters.Add("p_status", OracleDbType.Decimal, null, ParameterDirection.Output);
                    cmd.Parameters.Add("p_comment", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    OracleDecimal _status = (OracleDecimal)cmd.Parameters["p_status"].Value;
                    if (!_status.IsNull)
                        response.Status = Convert.ToInt32(_status.Value);

                    OracleString _comment = (OracleString)cmd.Parameters["p_comment"].Value;
                    if (!_comment.IsNull)
                        response.Comment = _comment.Value;
                }
            }
            catch (Exception.AutenticationException aex)
            {
                response.ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message);
            }
            catch (System.Exception ex)
            {
                string exMsg = null == ex.InnerException ? ex.Message : ex.InnerException.Message;
                response.ErrorMessage = ex.StackTrace + "//" + exMsg;
            }

            return response;
        }

        [SoapHeader("WsHeaderValue", Direction = SoapHeaderDirection.In)]
        [WebMethod(EnableSession = true)]
        public CheckAccResult CheckAccountByKf(CheckAccByKf request)
        {
            CheckAccResult response = new CheckAccResult();
            try
            {
                LoginUser();

                using (OracleConnection connection = Classes.OraConnector.Handler.IOraConnection.GetUserConnection())
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.BindByName = true;
                    cmd.CommandText = "BARS.Gerc_Payments.CheckAccountByKf";

                    cmd.Parameters.Add("p_kf", OracleDbType.Varchar2, 4000, request.Kf, ParameterDirection.Input);
                    cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, 4000, request.Nls, ParameterDirection.Input);
                    cmd.Parameters.Add("p_kv", OracleDbType.Decimal, request.Kv, ParameterDirection.Input);

                    cmd.Parameters.Add("p_status", OracleDbType.Decimal, null, ParameterDirection.Output);
                    cmd.Parameters.Add("p_comment", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    OracleDecimal _status = (OracleDecimal)cmd.Parameters["p_status"].Value;
                    if (!_status.IsNull)
                        response.Status = Convert.ToInt32(_status.Value);

                    OracleString _comment = (OracleString)cmd.Parameters["p_comment"].Value;
                    if (!_comment.IsNull)
                        response.Comment = _comment.Value;
                }
            }
            catch (Exception.AutenticationException aex)
            {
                response.ErrorMessage = String.Format("Помилка авторизації: {0}", aex.Message);
            }
            catch (System.Exception ex)
            {
                string exMsg = null == ex.InnerException ? ex.Message : ex.InnerException.Message;
                response.ErrorMessage = ex.StackTrace + "//" + exMsg;
            }

            return response;
        }
    }
}
