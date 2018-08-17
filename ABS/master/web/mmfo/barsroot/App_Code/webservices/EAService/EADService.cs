using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Data;
using System.Net;
using System.Text;
using System.IO;
using Bars.Application;
using Bars.Classes;
using ibank.core;
using Oracle.DataAccess.Client;
using Bars.EAD.Messages;
using System.Threading;
using Bars.EAD.Models;
using System.Linq;
using System.Web.Configuration;
using barsroot.core;
using Bars.Configuration;
using System.Diagnostics;

namespace Bars.EAD
{
    /// <summary>
    /// Сервіс для інтеграції з ЕА
    /// version 4.0   10/07/2018
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class EADService : Bars.BarsWebService
    {
        public EADService()
        {
        }

        #region Статические свойства
        public static String EA_ServiceUrl
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["ead.ServiceUrl"];
            }
        }
        public static Int32 EA_TimeOut
        {
            get
            {
                return Convert.ToInt32(Bars.Configuration.ConfigurationSettings.AppSettings["ead.TimeOut"]);
            }
        }
        public static String EA_ClientCertificateNumber
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["ead.CertificateNumber"];
            }
        }
        public static Boolean EA_UsingSSL
        {
            get
            {
                return Convert.ToBoolean(Bars.Configuration.ConfigurationSettings.AppSettings["ead.Using_SSL"]);
            }
        }
        /*public static String EA_CertificatePath
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["ead.CertificatePath"];
            }
        }
        public static String EA_CertificatePassword
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["ead.CertificatePassword"];
            }
        }
        */
        #endregion

        #region Веб-методы
        [WebMethod(EnableSession = true)]
        public void ProcessMessages(Int64[] idArr, String userName, String password, String kf)
        {
            // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated) LoginUser(userName);

            for (int i = 0; i < idArr.Length; i++)
            {
                ProcessMessage(idArr[i], kf);
            }
        }

        [WebMethod(EnableSession = true)]
        public void MsgProcess(Int64 ID, String WSProxyUserName, String WSProxyPassword, String kf)
        {
            // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(WSProxyUserName, WSProxyPassword, true);
            if (isAuthenticated) LoginUser(WSProxyUserName);

            ProcessMessage(ID, kf);
        }
        //[WebMethod(EnableSession = true)]
        public void ProcessMessage(Int64 ID, String kf)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            // Начинаем сессию взаимодействия и вычитываем сообщение
            String SessionID;
            SyncMessage msg;
            String _EAServiceUrl = Convert.ToString(Bars.Configuration.ConfigurationSettings.AppSettings["ead.ServiceUrl" + kf]);

            if (con.State != ConnectionState.Open)
                con.Open();
            try
            {
                SessionID = StartSession(con, kf, _EAServiceUrl);

                // если синхронизация справочников то используем другой класс
                if (SyncMessage.GetMethodByID(ID, con) == "SetDictionaryData")
                {
                    msg = new DictMessage(ID, SessionID, con, kf);
                }
                else
                {
                    msg = new SyncMessage(ID, SessionID, con, kf);
                }
            }
            finally
            {
                con.Close();
            }

            // Формируем сообщение
            String MessageID = msg.MessageID;
            DateTime MessageDate = DateTime.Now;
            String Message = msg.ToJsonString();

            BbConnection bb_con = new BbConnection();
            // пакет для записи в БД
            EadPack ep = new EadPack(bb_con);

            // устанавлдиваем статус
            ep.MSG_SET_STATUS_SEND(ID, MessageID, MessageDate, Message, kf);

            // отправляем запрос по Http
            Response rsp;
            try
            {
                String ResponseText = GetEAResponseText(Message, _EAServiceUrl);
                // сохраняем ответ
                ep.MSG_SET_STATUS_RECEIVED(ID, ResponseText, kf);

                // парсим ответ
                rsp = Response.CreateFromJSONString(msg.Method, ResponseText);
                ep.MSG_SET_STATUS_PARSED(ID, rsp.Responce_ID, rsp.Current_Timestamp, kf);

                // Анализируем ответ
                if (rsp.Status == "ERROR" || String.IsNullOrEmpty(rsp.Status))
                {
                    // устанавлдиваем статус "Помилка"
                    if (rsp.Result != null)
                    {
                        Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                        ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі RECEIVED: {0}, {1}", err.ErrorCode, err.ErrorText), kf);
                    }
                    else
                    {
                        // Structs.Result.Error2 err2 = (rsp.error as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error2>();
                        ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі RECEIVED: {0}, {1}", rsp.error.Code, rsp.error.Message), kf);
                    }
                }
                else
                {
                    Boolean HasErrors = false;

                    foreach (Newtonsoft.Json.Linq.JToken obj in (rsp.Result as Newtonsoft.Json.Linq.JArray))
                    {
                        Structs.Result.SyncResult res = obj.ToObject<Structs.Result.SyncResult>();
                        if (!String.IsNullOrEmpty(res.Error))
                        {
                            // устанавлдиваем статус "Помилка"
                            ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі RECEIVED: {0}", res.Error), kf);
                            HasErrors = true;
                            break;
                        }
                    }

                    if (!HasErrors)
                        // устанавлдиваем статус "Виконано"
                        ep.MSG_SET_STATUS_DONE(ID, kf);
                }
            }
            catch (System.Exception e)
            {  // устанавливаем статус "Помилка" и выходим
                ep.MSG_SET_STATUS_ERROR(ID, String.Format("Помилка на статусі SEND: {0}, {1}", e.Message, e.StackTrace), kf);
            }

            // Заканчиваем сессию взаимодействия
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                CloseSession(SessionID, con, _EAServiceUrl);
            }
            finally
            {
                con.Close();
            }
        }
        # endregion

        /// <summary>
        /// Copies the contents of input to output. Doesn't close either stream.
        /// </summary>
        public static void CopyStream(Stream input, Stream output)
        {
            byte[] buffer = new byte[8 * 1024];
            int len;
            while ((len = input.Read(buffer, 0, buffer.Length)) > 0)
            {
                output.Write(buffer, 0, len);
            }
        }
        # region Статические методы
        // Получить ответ по заданому запросу
        public static String GetEAResponseText(String Message, String _EAServiceUrl)
        {
            Byte[] MessageBytes = Encoding.UTF8.GetBytes(Message);
            String ResponseText;

            //создаем соединение WebRequest Request = WebRequest.Create(EA_ServiceUrl);
            HttpWebRequest Request = (HttpWebRequest)WebRequest.Create(_EAServiceUrl);
            if (EA_UsingSSL)//для SSL соединянния добавляем сертификат клиента
            {
                //добавляем сертификат клиента
                ClientCertificate CC = new ClientCertificate();

                try
                {
                    //находим в хранилище сертификат по серийному номеру
                    Request.ClientCertificates.Add(CC.GetCertificate(EA_ClientCertificateNumber));
                }
                catch (System.Exception ex)
                {/*обработка ошибок: сертификат не найден или другая*/
                    if (ex is ArgumentNullException)
                    {
                        return String.Format("Не вдалося встановити захищене з'еднання. Не знайдено сертифiкат користувача з номером: {0}", EA_ClientCertificateNumber);
                    }
                    else
                        return String.Format("Не вдалося встановити захищене з'еднання: {0}", ex.Message);
                }
            }

            Request.Method = "POST";
            Request.ContentType = "application/json; charset=\"UTF-8\";";
            Request.ContentLength = MessageBytes.Length;

            Request.Timeout = EA_TimeOut;
            //для синхронізації довідників таймаути збільшено.        
            if (Message.Contains("SetDictionaryData"))
            {
                Request.Timeout = EA_TimeOut * 10;
            }

            using (Stream RequestStream = Request.GetRequestStream())
            {

                RequestStream.Write(MessageBytes, 0, MessageBytes.Length);
                RequestStream.Close();
            }

            // ответ
            try
            {
                using (WebResponse Response = Request.GetResponse())
                {
                    using (Stream ResponseStream = Response.GetResponseStream())
                    {
                        using (StreamReader rdr = new StreamReader(ResponseStream))
                        {
                            ResponseText = rdr.ReadToEnd();
                            rdr.Close();
                        }
                        ResponseStream.Close();
                    }
                    Response.Close();
                }
                return ResponseText;
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
        }
        // Начать сессию взаимодействия с ЕА
        public static String StartSession(OracleConnection con, string kf, String eaServiceUrl)
        {
            String res = String.Empty;

            // Формируем сообщение
            StartSessionMessage msg = new StartSessionMessage(con, kf, -1);
            String Message = msg.ToJsonString();

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message, eaServiceUrl);

            Response rsp = Response.CreateFromJSONString("StartSession", ResponseText);

            // Анализируем ответ
            if (rsp.Status == "ERROR")
            {
                // устанавлдиваем статус "Помилка"
                Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                throw new System.Exception(String.Format("Неможливо розпочати сессію взаємодії з ЕА: {0}, {1}", err.ErrorCode, err.ErrorText));
            }
            else
            {
                res = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.StartSession>().SessionID;
            }

            return res;
        }
        // Закрыть сессию взаимодействия с ЕА
        public static void CloseSession(String SessionID, OracleConnection con, String _EA_ServiceUrl)
        {
            // Формируем сообщение
            CloseSessionMessage msg = new CloseSessionMessage(SessionID, con);
            String Message = msg.ToJsonString();

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message, _EA_ServiceUrl);

            Response rsp = Response.CreateFromJSONString("CloseSession", ResponseText);

            // Анализируем ответ
            if (rsp.Status == "ERROR")
            {
                // устанавлдиваем статус "Помилка"
                Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                throw new System.Exception(String.Format("Неможливо закрити сессію взаємодії з ЕА: {0}, {1}", err.ErrorCode, err.ErrorText));
            }
        }

        // получение данных документа
        /// <summary>
        /// GetDocumentData(Int64? ID ... String Doc_Request_Number)) - obsolete
        /// </summary>
        public static List<Structs.Result.DocumentData> GetDocumentData(Int64? ID, Decimal? Rnk, Double? Agreement_ID, Int16? Struct_Code, String Doc_Request_Number, String kf)
        {
            return GetDocumentData(ID.ToString(), Rnk, Agreement_ID, Struct_Code.ToString(), Doc_Request_Number, null, null, null, null, kf);
        }
        public static List<Structs.Result.DocumentData> GetDocumentData(String ID, Decimal? Rnk, Double? Agreement_ID, String Struct_Code, String Doc_Request_Number, String agr_type, String account_type, String account_number, String account_currency, String kf)
        {
            String _EAServiceUrl = Convert.ToString(Bars.Configuration.ConfigurationSettings.AppSettings["ead.ServiceUrl" + kf]);
            List<Structs.Result.DocumentData> res = new List<Structs.Result.DocumentData>();

            // считаем что пользователь авторизирован
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            // Начинаем сессию взаимодействия и вычитываем сообщение
            String SessionID;
            SessionMessage msg;
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                SessionID = StartSession(con, kf, _EAServiceUrl);
                msg = new SessionMessage(SessionID, "GetDocumentData", con);
            }
            finally
            {
                con.Close();
            }

            // формируем параметры запроса
            if (!String.IsNullOrWhiteSpace(ID))
                msg.Params = new Structs.Params.DocumentData(ID);
            else
            {
                if (String.IsNullOrEmpty(Doc_Request_Number))
                {
                    msg.Params = new Structs.Params.DocumentData(Rnk.Value, Agreement_ID, Struct_Code);
                }
                else
                {
                    msg.Params = new Structs.Params.DocumentData(Rnk.Value, Agreement_ID, Struct_Code, Doc_Request_Number, agr_type, account_type, account_number, account_currency);

                }
            }

            // Формируем сообщение
            String Message = msg.ToJsonString();

            // отправляем запрос по Http
            String ResponseText = GetEAResponseText(Message, _EAServiceUrl);

            // парсим ответ
            Response rsp = Response.CreateFromJSONString(msg.Method, ResponseText);

            // Анализируем ответ
            if (rsp.Status == "ERROR" || String.IsNullOrEmpty(rsp.Status))
            {
                // устанавлдиваем статус "Помилка"
                if (rsp.Result != null)
                {
                    Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                    throw new System.Exception(err.ErrorCode + err.ErrorText);
                }
                else
                {
                    // Structs.Result.Error2 err2 = (rsp.error as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error2>();
                    throw new System.Exception(rsp.error.Code + rsp.error.Message);
                }
            }
            else
            {
                Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).First.ToObject<Structs.Result.Error>();
                if (!String.IsNullOrEmpty(err.ErrorText2) && err.ErrorText2.Contains("Documents not found.Document file name is empty")) throw new System.Exception(err.ErrorText2);

                if (con.State != ConnectionState.Open) con.Open();
                try
                {
                    OracleCommand cmd = con.CreateCommand();
                    cmd.CommandText = "select name from ead_struct_codes where id = :p_id";
                    cmd.Parameters.Add("p_id", OracleDbType.Varchar2, ParameterDirection.Input);

                    foreach (Newtonsoft.Json.Linq.JToken obj in (rsp.Result as Newtonsoft.Json.Linq.JArray))
                    {
                        Structs.Result.DocumentData objDD = obj.ToObject<Structs.Result.DocumentData>();

                        // выбираем наименование документа из БД
                        cmd.Parameters["p_id"].Value = objDD.Struct_Code;
                        objDD.Struct_Name = Convert.ToString(cmd.ExecuteScalar());

                        res.Add(objDD);
                    }
                }
                finally
                {
                    con.Close();
                }
            }

            // Заканчиваем сессию взаимодействия
            if (con.State != ConnectionState.Open) con.Open();
            try
            {
                CloseSession(SessionID, con, _EAServiceUrl);
            }
            finally
            {
                con.Close();
            }

            return res;
        }
        #endregion

        #region NEW
        /// <summary>
        /// Проводить обробку "пачки" повідомленнь вказаного типу
        /// </summary>
        private void TypeProcessWorker(OracleConnection con, string userName, string kf, string type, string session, EadType _type)
        {
            try
            {
                EadSyncHelper helper = new EadSyncHelper(con);
                decimal _logId = helper.SetSyncStarted(type, kf);

                Stopwatch sw = Stopwatch.StartNew();
                int count = helper.GetMaxCount();

                using (OracleTransaction tran = con.BeginTransaction())
                {
                    List<SyncQueueRow> data = new List<SyncQueueRow>();
                    int totalDone = 0, totalErr = 0;
                    try
                    {
                        Stopwatch sqlExecSw = new Stopwatch();
                        sqlExecSw.Start();

                        data = GetQueueData(con, tran, _type.Id, kf, count, _type.MsgRetryInterval);

                        helper.UpdateLogSelect(_logId, data.Count, data.Count(x => x.StatusId == "ERROR"), sqlExecSw.ElapsedMilliseconds);
                        sqlExecSw.Stop();

                        if (data.Count > 0)
                        {
                            string srvUrl = Convert.ToString(ConfigurationSettings.AppSettings["ead.ServiceUrl" + kf]);
                            string sessionID = StartSession(con, kf, srvUrl);

                            List<SyncQueueRow> results = new List<SyncQueueRow>();

                            for (int i = 0; i < data.Count; i++)
                            {
                                try
                                {
                                    bool res = ProcessMessageNew(con, srvUrl, sessionID, data[i], kf, _type.Method);
                                    if (!res) totalErr++;
                                    totalDone++;
                                }
                                catch (System.Exception ex)
                                {
                                    EadSyncHelper.DbLoggerInfo(con, string.Format("EA sync session (kf={2},type={3}) Error on record id={1} : {0}", ex.Message, data[i].Id, kf, type));
                                }
                            }
                            CloseSession(sessionID, con, srvUrl);
                        }
                    }
                    catch (System.Exception ex)
                    {
                        EadSyncHelper.DbLoggerInfo(con, string.Format("EA sync session (kf={3},type={4}) №'{0}' finished, count= {1}, ERROR: {2}", session, data.Count, ex.Message, kf, type));
                    }
                    finally { tran.Commit(); }

                    helper.UpdateLogFinish(_logId, totalDone, totalErr, sw.ElapsedMilliseconds);
                }

                sw.Stop();
            }
            catch (System.Exception ex) { EadSyncHelper.DbLoggerInfo(con, "EA sync Error: " + ex.Message); }
            finally { LogOutUserEa(con); }
        }

        private void ProcessWorker(string userName, string kf, List<EadType> typeConfigs)
        {
            for (int i = 0; i < typeConfigs.Count; i++)
            {
                string session = Guid.NewGuid().ToString();
                using (OracleConnection con = GetConnection(session, userName))
                {
                    TypeProcessWorker(con, userName, kf, typeConfigs[i].Id, session, typeConfigs[i]);
                }
            }
        }

        [WebMethod(EnableSession = true)]
        public void ProcessQueue()
        {
            List<EadType> _types = null;
            List<EadCfg> _cfg = null;

            string userName = Convert.ToString(ConfigurationSettings.AppSettings["ead.WSProxy.UserName"]);

            using (OracleConnection con = GetConnection(Guid.NewGuid().ToString(), userName))
            {
                try
                {
                    EadSyncHelper helper = new EadSyncHelper(con);
                    _types = helper.GetTypes();
                    _cfg = helper.GetConfigs();

                    foreach (EadCfg item in _cfg)
                    {
                        if (item.Mode == 1 || item.Mode == 2)
                        {
                            if (2 == item.Mode && helper.ThreadInProcessExists(item.Kf)) continue;

                            Thread foThread = new Thread(new ThreadStart(() =>
                            {
                                ProcessWorker(userName, item.Kf, _types.Where(x => x.IsUo == 0 && x.Id != "DICT").OrderBy(x => x.Order).ToList());
                            }));
                            foThread.Start();

                            Thread uoThread = new Thread(new ThreadStart(() =>
                            {
                                ProcessWorker(userName, item.Kf, _types.Where(x => x.IsUo == 1 && x.Id != "DICT").OrderBy(x => x.Order).ToList());
                            }));
                            uoThread.Start();
                        }
                    }
                }
                catch (System.Exception ex)
                {
                    EadSyncHelper.DbLoggerInfo(con, "EA sync ERROR:" + ex.Message);
                }

                LogOutUserEa(con);
            }
        }

        /// <summary>
        /// Метод отримує конект та виконує логін
        /// </summary>
        private OracleConnection GetConnection(string sessionId, string userName)
        {
            string conStr = WebConfigurationManager.ConnectionStrings[BarsWeb.Infrastructure.Constants.AppConnectionStringName].ConnectionString;
            OracleConnection conn = new OracleConnection(conStr);

            try
            {
                conn.Open();
                using (OracleCommand cmd = conn.CreateCommand())
                {
                    UserMap userMap = ConfigurationSettings.GetUserInfo(userName);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.CommandText = "bars.bars_login.login_user";
                    cmd.Parameters.Add("p_session_id", OracleDbType.Varchar2, sessionId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_user_id", OracleDbType.Varchar2, userMap.user_id, ParameterDirection.Input);
                    cmd.Parameters.Add("p_hostname", OracleDbType.Varchar2, "EA Service", ParameterDirection.Input);
                    cmd.Parameters.Add("p_appname", OracleDbType.Varchar2, "barsroot", ParameterDirection.Input);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (OracleException ex)
            {
                if (ex.Message.StartsWith("Connection request timed out"))
                {
                    GC.Collect();
                    GC.WaitForPendingFinalizers();
                    GC.Collect();
                    conn.Open();
                }
                else if (ex.Message.StartsWith("ORA-604"))
                {
                    conn.Dispose();
                    throw ex;
                }
                else
                    throw ex;
            }
            return conn;
        }

        private List<SyncQueueRow> GetQueueData(OracleConnection con, OracleTransaction tran, string typeId, string kf, int count, int retryInterval)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.Transaction = tran;
                cmd.CommandText = "ead_pack.get_sync_queue_proc";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new OracleParameter("p_type", OracleDbType.Varchar2, typeId, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_kf", OracleDbType.Varchar2, kf, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_count", OracleDbType.Decimal, count, ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_retry_interval", OracleDbType.Decimal, retryInterval, ParameterDirection.Input));

                OracleParameter res = new OracleParameter(parameterName: "res", type: OracleDbType.Array, direction: ParameterDirection.Output)
                {
                    UdtTypeName = "BARS.T_EAD_SYNC_QUE_LIST"
                };
                cmd.Parameters.Add(res);

                cmd.ExecuteNonQuery();

                if (null != res.Value) return ((SyncQueueRow[])res.Value).ToList();

                return new List<SyncQueueRow>();
            }
        }

        /// <summary>
        /// обробка одного повідомлення
        /// </summary>
        private bool ProcessMessageNew(OracleConnection con, string eaSrvUrl, string sessionId, SyncQueueRow item, string kf, string method)
        {
            string errorText = string.Empty;
            EadSyncHelper syncHelper = new EadSyncHelper(con);

            try
            {
                SyncMessage msg;
                if (method.ToUpper() == "SETDICTIONARYDATA")
                {
                    // якщо синхронізація довідників, то використовуємо іншу структуру
                    msg = new DictMessage(item, sessionId, con, kf, method);
                }
                else
                {
                    msg = new SyncMessage(item, sessionId, con, kf, method);
                }

                // формуємо повідомлення
                item.MessageId = msg.MessageID;
                item.MessageDate = DateTime.Now;
                item.Message = msg.ToJsonString();

                // відправляємо запит по Http
                try
                {
                    item.Response = GetEAResponseText(item.Message, eaSrvUrl);

                    // парсимо відповідь
                    Response rsp = Response.CreateFromJSONString(msg.Method, item.Response);
                    item.ResponseId = rsp.Responce_ID;
                    item.ResponseDate = rsp.Current_Timestamp;

                    if (rsp.Status == Status.ERROR.ToString() || String.IsNullOrEmpty(rsp.Status))
                    {
                        if (rsp.Result != null)
                        {
                            Structs.Result.Error err = (rsp.Result as Newtonsoft.Json.Linq.JToken).ToObject<Structs.Result.Error>();
                            errorText = String.Format("Помилка на статусі RECEIVED: {0}, {1}", err.ErrorCode, err.ErrorText);
                        }
                        else
                        {
                            errorText = String.Format("Помилка на статусі RECEIVED: {0}, {1}", rsp.error.Code, rsp.error.Message);
                        }
                    }
                    else
                    {
                        bool HasErrors = false;
                        foreach (Newtonsoft.Json.Linq.JToken obj in (rsp.Result as Newtonsoft.Json.Linq.JArray))
                        {
                            Structs.Result.SyncResult res = obj.ToObject<Structs.Result.SyncResult>();
                            if (!String.IsNullOrEmpty(res.Error))
                            {
                                errorText = String.Format("Помилка на статусі RECEIVED: {0}", res.Error);
                                HasErrors = true;
                                break;
                            }
                        }

                        if (!HasErrors) item.StatusId = Status.DONE.ToString();
                    }
                }
                catch (System.Exception e)
                {
                    errorText = String.Format("Помилка на статусі SEND: {0}, {1}", e.Message, e.StackTrace);
                }
            }
            catch (System.Exception ex)
            {
                errorText = String.Format("Помилка: {0}, {1}", ex.Message, ex.StackTrace);
            }

            if (!string.IsNullOrWhiteSpace(errorText)) item.SetError(errorText);
            syncHelper.UpdateQueueItem(item);
            return item.StatusId.ToUpper() == "DONE";
        }

        /// <summary>
        /// Виконуємо логаут сесії
        /// </summary>
        private void LogOutUserEa(OracleConnection con)
        {
            using (OracleCommand cmd = con.CreateCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "bars.bars_login.logout_user";

                cmd.ExecuteNonQuery();
            }
        }

        #endregion
    }
}