using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Xml;
using System.Globalization;
using System.Web.Script.Serialization;

using System.Net;
using System.Text;
using System.IO;
using System.Configuration;
using System.Security.Cryptography;
using System.Net.Mime;

using Bars.Application;
using Bars.Classes;
using barsroot.core;
using ibank.core;
using Bars.KFiles;
//using Bars.Logger;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Newtonsoft.Json;
using System.Security.Cryptography.X509Certificates;
using System.Web.Script.Services;
using System.Linq;
using System.Runtime.Serialization;
using KFilesRemoteService;
using Microsoft.Ajax.Utilities;


namespace Bars.KFiles.Dictionary
{

    /// <summary>
    /// Довідник корпорацій
    /// </summary>
    [DataContract]
    public struct SYNC_DICTIONARY_DATA
    {
        [DataMember]
        public List<Corporation> Corporation;

        public static SYNC_DICTIONARY_DATA GetInstance(Int64 ObjID, OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();

            SYNC_DICTIONARY_DATA res = new SYNC_DICTIONARY_DATA();
            res.Corporation = new List<Corporation>();

            cmd.CommandText = @"SELECT id,
                                         corporation_code,
                                         corporation_name,
                                         parent_id,
                                         state_id,
                                         EXTERNAL_ID  
                                    FROM BARS.OB_CORPORATION
                                   WHERE id IN (SELECT DISTINCT t4.id corp_id
                                                  FROM BARS.ATTRIBUTE_HISTORY t1,
                                                       BARS.OBJECT_TYPE t2,
                                                       bars.attribute_kind t3,
                                                       BARS.OB_CORPORATION t4
                                                 WHERE     T1.ATTRIBUTE_ID = t3.id
                                                       AND t3.object_type_id = T2.ID
                                                       AND t2.Type_code = 'CORPORATIONS'
                                                       AND T4.ID = T1.OBJECT_ID
                                                       AND T1.ID > :p_last_id)
                                ORDER BY 1";
            //лише клієнти банку
            cmd.Parameters.Clear();
            cmd.Parameters.Add("p_last_id", OracleDbType.Int64, Convert.ToInt64(ObjID), ParameterDirection.Input);

            using (OracleDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {

                    res.Corporation.Add(new Corporation(
                                                        Convert.ToDecimal(rdr["id"]),
                                                        Convert.ToString(rdr["corporation_code"]),
                                                        Convert.ToString(rdr["corporation_name"]),
                                                        rdr["parent_id"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["parent_id"]),
                                                        Convert.ToDecimal(rdr["state_id"]),
                                                        Convert.ToString(rdr["EXTERNAL_ID"])
                                                        ));
                }
                rdr.Close();
            }
            return res;
        }
    }

    /// <summary>
    /// Параметри корпорації
    /// </summary>
    [DataContract]
    public struct Corporation
    {
        [DataMember]
        public Decimal Id;
        [DataMember]
        public String CorporationCode;
        [DataMember]
        public String CorporationName;
        [DataMember]
        public Decimal? ParentId;
        [DataMember]
        public Decimal StateId;
        [DataMember]
        public string EXTERNAL_ID;

        public Corporation(Decimal Id, String CorporationCode, String CorporationName, Decimal? ParentId, Decimal StateId, string external_id)
        {
            this.Id = Id;
            this.CorporationCode = CorporationCode;
            this.CorporationName = CorporationName;
            this.ParentId = ParentId;
            this.StateId = StateId;
            this.EXTERNAL_ID = external_id;

        }
        public void Save()
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();


            try
            {
                BbConnection bb_con = new BbConnection();

                // пакет для записи в БД
                KFilesPack kp = new KFilesPack(bb_con);
                // устанавлдиваем статус
                kp.SYNC_OB_CORPORATION_DICTIONARY(this.Id, this.CorporationCode, this.CorporationName, this.ParentId, this.StateId, this.EXTERNAL_ID);
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }

        }

    }

}

/// <summary>
/// структура таблиці кфайлів
/// </summary>
namespace Bars.KFiles.Struct
{ /// <summary>
  /// рядок для запису в таблицю
  /// </summary>
    [DataContract]
    public struct KFileRow
    {
        [DataMember]
        public Decimal CORPORATION_ID;

        [DataMember]
        public DateTime FILE_DATE;

        [DataMember]
        public Decimal? ROWTYPE;

        [DataMember]
        public String OURMFO;

        [DataMember]
        public String NLS;

        [DataMember]
        public Decimal? KV;

        [DataMember]
        public String OKPO;

        [DataMember]
        public Decimal? OBDB;

        [DataMember]
        public Decimal? OBDBQ;

        [DataMember]
        public Decimal? OBKR;

        [DataMember]
        public Decimal? OBKRQ;

        [DataMember]
        public Decimal? OST;

        [DataMember]
        public Decimal? OSTQ;

        [DataMember]
        public Decimal? KOD_CORP;

        [DataMember]
        public Decimal? KOD_USTAN;

        [DataMember]
        public String KOD_ANALYT;

        [DataMember]
        public DateTime? DAPP;

        [DataMember]
        public DateTime? POSTDAT;

        [DataMember]
        public DateTime? DOCDAT;

        [DataMember]
        public DateTime? VALDAT;

        [DataMember]
        public String ND;

        [DataMember]
        public Decimal? VOB;

        [DataMember]
        public Decimal? DK;

        [DataMember]
        public String MFOA;

        [DataMember]
        public String NLSA;

        [DataMember]
        public Decimal? KVA;

        [DataMember]
        public String NAMA;

        [DataMember]
        public String OKPOA;

        [DataMember]
        public String MFOB;

        [DataMember]
        public String NLSB;

        [DataMember]
        public Decimal? KVB;

        [DataMember]
        public String NAMB;

        [DataMember]
        public String OKPOB;

        [DataMember]
        public Decimal? S;

        [DataMember]
        public Decimal? DOCKV;

        [DataMember]
        public Decimal? SQ;

        [DataMember]
        public String NAZN;

        [DataMember]
        public Decimal? DOCTYPE;

        [DataMember]
        public DateTime? POSTTIME;

        [DataMember]
        public String NAMK;

        [DataMember]
        public String NMS;

        [DataMember]
        public String TT;

        [DataMember]
        public Decimal SESSION_ID;


        public KFileRow(Decimal CORPORATION_ID,
                        DateTime FILE_DATE,
                        Decimal ROWTYPE,
                        String OURMFO,
                        String NLS,
                        Decimal KV,
                        String OKPO,
                        Decimal OBDB,
                        Decimal OBDBQ,
                        Decimal OBKR,
                        Decimal OBKRQ,
                        Decimal OST,
                        Decimal OSTQ,
                        Decimal KOD_CORP,
                        Decimal KOD_USTAN,
                        String KOD_ANALYT,
                        DateTime DAPP,
                        DateTime POSTDAT,
                        DateTime DOCDAT,
                        DateTime VALDAT,
                        String ND,
                        Decimal VOB,
                        Decimal DK,
                        String MFOA,
                        String NLSA,
                        Decimal KVA,
                        String NAMA,
                        String OKPOA,
                        String MFOB,
                        String NLSB,
                        Decimal KVB,
                        String NAMB,
                        String OKPOB,
                        Decimal S,
                        Decimal DOCKV,
                        Decimal SQ,
                        String NAZN,
                        Decimal DOCTYPE,
                        DateTime POSTTIME,
                        String NAMK,
                        String NMS,
                        String TT,
                        Decimal SESSION_ID)
        {
            this.CORPORATION_ID = CORPORATION_ID;
            this.FILE_DATE = FILE_DATE;
            this.ROWTYPE = ROWTYPE;
            this.OURMFO = OURMFO;
            this.NLS = NLS;
            this.KV = KV;
            this.OKPO = OKPO;
            this.OBDB = OBDB;
            this.OBDBQ = OBDBQ;
            this.OBKR = OBKR;
            this.OBKRQ = OBKRQ;
            this.OST = OST;
            this.OSTQ = OSTQ;
            this.KOD_CORP = KOD_CORP;
            this.KOD_USTAN = KOD_USTAN;
            this.KOD_ANALYT = KOD_ANALYT;
            this.DAPP = DAPP;
            this.POSTDAT = POSTDAT;
            this.DOCDAT = DOCDAT;
            this.VALDAT = VALDAT;
            this.ND = ND;
            this.VOB = VOB;
            this.DK = DK;
            this.MFOA = MFOA;
            this.NLSA = NLSA;
            this.KVA = KVA;
            this.NAMA = NAMA;
            this.OKPOA = OKPOA;
            this.MFOB = MFOB;
            this.NLSB = NLSB;
            this.KVB = KVB;
            this.NAMB = NAMB;
            this.OKPOB = OKPOB;
            this.S = S;
            this.DOCKV = DOCKV;
            this.SQ = SQ;
            this.NAZN = NAZN;
            this.DOCTYPE = DOCTYPE;
            this.POSTTIME = POSTTIME;
            this.NAMK = NAMK;
            this.NMS = NMS;
            this.TT = TT;
            this.SESSION_ID = SESSION_ID;
        }

        public void WriteRow(OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.BindByName = true;
            cmd.CommandText = "insert into ob_corporation_data_tmp" +
                       "(   SESSION_ID,   TT,   NMS,   NAMK,   POSTTIME,   DOCTYPE,   NAZN,   SQ,   DOCKV,   S,   OKPOB,   NAMB,   KVB,   NLSB,   MFOB,   OKPOA,   NAMA,   KVA,   NLSA,   MFOA,   DK,   VOB,   ND,   VALDAT,   DOCDAT,   POSTDAT,   DAPP,   KOD_ANALYT,   KOD_USTAN,   KOD_CORP,   OSTQ,   OST,   OBKRQ,   OBKR,   OBDBQ,   OBDB,   OKPO,   KV,   NLS,   OURMFO,   ROWTYPE,   FILE_DATE,   CORPORATION_ID)" +
               " values (:p_SESSION_ID,:p_TT,:p_NMS,:p_NAMK,:p_POSTTIME,:p_DOCTYPE,:p_NAZN,:p_SQ,:p_DOCKV,:p_S,:p_OKPOB,:p_NAMB,:p_KVB,:p_NLSB,:p_MFOB,:p_OKPOA,:p_NAMA,:p_KVA,:p_NLSA,:p_MFOA,:p_DK,:p_VOB,:p_ND,:p_VALDAT,:p_DOCDAT,:p_POSTDAT,:p_DAPP,:p_KOD_ANALYT,:p_KOD_USTAN,:p_KOD_CORP,:p_OSTQ,:p_OST,:p_OBKRQ,:p_OBKR,:p_OBDBQ,:p_OBDB,:p_OKPO,:p_KV,:p_NLS,:p_OURMFO,:p_ROWTYPE,:p_FILE_DATE,:p_CORPORATION_ID)";

            cmd.Parameters.Add(new OracleParameter("p_CORPORATION_ID", OracleDbType.Decimal, this.CORPORATION_ID, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_FILE_DATE", OracleDbType.Date, this.FILE_DATE, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_ROWTYPE", OracleDbType.Decimal, this.ROWTYPE, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_OURMFO", OracleDbType.Varchar2, this.OURMFO, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_NLS", OracleDbType.Varchar2, this.NLS, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_KV", OracleDbType.Decimal, this.KV, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_OKPO", OracleDbType.Varchar2, this.OKPO, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_OBDB", OracleDbType.Decimal, this.OBDB, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_OBDBQ", OracleDbType.Decimal, this.OBDBQ, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_OBKR", OracleDbType.Decimal, this.OBKR, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_OBKRQ", OracleDbType.Decimal, this.OBKRQ, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_OST", OracleDbType.Decimal, this.OST, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_OSTQ", OracleDbType.Decimal, this.OSTQ, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_KOD_CORP", OracleDbType.Decimal, this.KOD_CORP, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_KOD_USTAN", OracleDbType.Decimal, this.KOD_USTAN, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_KOD_ANALYT", OracleDbType.Varchar2, this.KOD_ANALYT, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_DAPP", OracleDbType.Date, this.DAPP, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_POSTDAT", OracleDbType.Date, this.POSTDAT, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_DOCDAT", OracleDbType.Date, this.DOCDAT, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_VALDAT", OracleDbType.Date, this.VALDAT, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_ND", OracleDbType.Varchar2, this.ND, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_VOB", OracleDbType.Decimal, this.VOB, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_DK", OracleDbType.Decimal, this.DK, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_MFOA", OracleDbType.Varchar2, this.MFOA, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_NLSA", OracleDbType.Varchar2, this.NLSA, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_KVA", OracleDbType.Decimal, this.KVA, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_NAMA", OracleDbType.Varchar2, this.NAMA, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_OKPOA", OracleDbType.Varchar2, this.OKPOA, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_MFOB", OracleDbType.Varchar2, this.MFOB, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_NLSB", OracleDbType.Varchar2, this.NLSB, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_KVB", OracleDbType.Decimal, this.KVB, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_NAMB", OracleDbType.Varchar2, this.NAMB, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_OKPOB", OracleDbType.Varchar2, this.OKPOB, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_S", OracleDbType.Decimal, this.S, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_DOCKV", OracleDbType.Decimal, this.DOCKV, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_SQ", OracleDbType.Decimal, this.SQ, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_NAZN", OracleDbType.Varchar2, this.NAZN, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_DOCTYPE", OracleDbType.Decimal, this.DOCTYPE, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_POSTTIME", OracleDbType.Date, this.POSTTIME, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_NAMK", OracleDbType.Varchar2, this.NAMK, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_NMS", OracleDbType.Varchar2, this.NMS, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_TT", OracleDbType.Varchar2, this.TT, ParameterDirection.Input));
            cmd.Parameters.Add(new OracleParameter("p_SESSION_ID", OracleDbType.Decimal, this.SESSION_ID, ParameterDirection.Input));

            cmd.ExecuteNonQuery();


        }


    }

    /// <summary>
    /// файл від РУ
    /// </summary>
    [DataContract]
    public struct KFile
    {
        [DataMember]
        public String CorporationId;
        [DataMember]
        public DateTime SyncDate;
        [DataMember]
        public int MFO;


        public KFile(String CorporationId, DateTime SyncDate, int MFO)
        {
            this.CorporationId = CorporationId;
            this.SyncDate = SyncDate;
            this.MFO = MFO;

        }
    }
}


namespace Bars.KFiles
{
    /// <summary>
    /// Сообщение corporations 
    /// </summary>
    [DataContract]
    public class SyncDictMessage
    {
        #region Приватные свойства
        protected Object _Params;
        public Int64 LastId;
        public Dictionary.SYNC_DICTIONARY_DATA SyncMsg;
        #endregion

        #region Публичные свойства

        #endregion

        #region Конструктор
        public SyncDictMessage(Int64 LastId, OracleConnection con)
        {
            this.LastId = LastId;
            InitParams(con);
        }
        public SyncDictMessage()
        {
        }
        # endregion

        # region Приватные методы
        private void InitParams(OracleConnection con)
        {
            // this._Params = new Object[1] { Dictionary.SYNC_DICTIONARY_DATA.GetInstance(this.LastId, con) };
            this.SyncMsg = Dictionary.SYNC_DICTIONARY_DATA.GetInstance(this.LastId, con);
            getLastId(this.LastId);


        }

        private void getLastId(Int64 LastId)
        {
            BbConnection bb_con = new BbConnection();
            // пакет для записи в БД
            KFilesPack kp = new KFilesPack(bb_con);
            this.LastId = kp.GET_LAST_ID(LastId);
            bb_con.CloseConnection();
        }
        #endregion

        #region Публичные методы
        #endregion

        #region Статические методы
        #endregion
    }



    [DataContract]
    public class SyncSessionMsg
    {
        [DataMember]
        public Int64 SessionID { get; set; }
        [DataMember]
        public string SessionStatus { get; set; }
        [DataMember]
        public string SessionError { get; set; }

        public SyncSessionMsg()
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                // Начинаем сессию взаимодействия и вычитываем nextId

                BbConnection bb_con = new BbConnection();
                // пакет для записи в БД
                KFilesPack kp = new KFilesPack(bb_con);
                // устанавлдиваем статус
                this.SessionID = kp.GET_SYNC_ID();
                this.SessionStatus = "OK";
            }
            catch (System.Exception ex)
            {
                this.SessionStatus = "Error";
                this.SessionError = ex.Message;
                throw;

            }
            finally
            {
                con.Close();
            }

        }


        public bool CheckMFO()
        {
            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                if (con.State != ConnectionState.Open)
                    con.Open();
                try
                {
                    decimal? result;
                    OracleCommand cmd = con.CreateCommand();
                    cmd.CommandText = @"select BARS.kfile_pack.get_mmfo_type from dual";
                    OracleDataReader rdr = cmd.ExecuteReader();
                    if (rdr.Read())
                    {
                        result = String.IsNullOrEmpty(rdr.GetValue(0).ToString()) ? (decimal?)null : rdr.GetDecimal(0);
                        return (result == 1) ? true : false;
                    }
                    else
                    {
                        result = 0;
                        return false;
                    }
                }
                catch (System.Exception)
                {
                    throw;
                }
                finally
                {
                    con.Close();
                }
            }

        }


        public SyncSessionMsg(Int32 MFO, String corporationId, String syncDate, String syncType)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                // Начинаем сессию взаимодействия и вычитываем nextId

                BbConnection bb_con = new BbConnection();
                // пакет для записи в БД
                KFilesPack kp = new KFilesPack(bb_con);
                // устанавлдиваем статус


                if ((syncType == "DICT") || CheckMFO())
                {
                    this.SessionID = kp.GET_SYNC_ID(MFO, corporationId, syncDate, syncType);
                }
             
                this.SessionStatus = "OK";
            }
            catch (System.Exception ex)
            {
                this.SessionStatus = "Error";
                this.SessionError = ex.Message;
                throw;

            }
            finally
            {
                con.Close();
            }

        }

        public void SaveSessionId()
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            try
            {
                // Начинаем сессию взаимодействия и вычитываем nextId

                BbConnection bb_con = new BbConnection();
                // пакет для записи в БД
                KFilesPack kp = new KFilesPack(bb_con);
                // устанавлдиваем статус
                kp.SET_SYNC_ID(this.SessionID);
                this.SessionStatus = "OK";
            }
            catch (System.Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }

    }




    /// <summary>
    /// Сервис для интеграции с ЕА
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ScriptService]
    public class KFilesService : Bars.BarsWebService
    {
        # region Константы
        # endregion

        # region Конструкторы
        public KFilesService()
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
        }
        # endregion

        # region Статические свойства
        public static String KFilesServiceUrl
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["KFiles.ServiceUrl"];
            }
        }

        public static String KFilesServiceUser
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["KFiles.ServiceUser"];
            }
        }
        public static String KFilesServiceUserPass
        {
            get
            {
                return Bars.Configuration.ConfigurationSettings.AppSettings["KFiles.ServiceUserPass"];
            }
        }

        public static Int64 KFilesServiceSyncDictId
        {
            get
            {
                return Convert.ToInt64(Bars.Configuration.ConfigurationSettings.AppSettings["KFiles.ServiceSyncDictId"]);
            }
        }
        public static Int32 KFilesServiceSyncMFO
        {
            get
            {
                return Convert.ToInt32(Bars.Configuration.ConfigurationSettings.AppSettings["KFiles.ServiceSyncMFO"]);
            }
        }
        # endregion

        # region Приватные методы
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
            // информация о текущем пользователе
            UserMap userMap = Bars.Configuration.ConfigurationSettings.GetUserInfo(userName);

            try
            {
                InitOraConnection();
                // установка первичных параметров
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_user_id", DB_TYPE.Varchar2, userMap.user_id, DIRECTION.Input);
                SetParameters("p_hostname", DB_TYPE.Varchar2, GetHostName(), DIRECTION.Input);
                SetParameters("p_appname", DB_TYPE.Varchar2, "barsroot", DIRECTION.Input);
                SQL_PROCEDURE("bars.bars_login.login_user");
            }
            finally
            {
                DisposeOraConnection();
            }

            // Если выполнили установку параметров
            Session["UserLoggedIn"] = true;
        }
        #endregion

        #region Веб-методы
        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public SyncSessionMsg SyncSession(String WSProxyUserName, String WSProxyPassword, Int32 MFO, String corporationId, String syncDate, String syncType)
        {
            // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(WSProxyUserName, WSProxyPassword, true);

            if (isAuthenticated)
            {
                LoginUser(WSProxyUserName);
                // Bars.Logger.DBLogger.Info("WSProxyUserName= " + WSProxyUserName);
            }
            else
            {
                //  Bars.Logger.DBLogger.Info("WSProxyUserName= Noname" + WSProxyUserName);
            }

            //для SSL валідація сертифікату серверу
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
            
            // Отримуємо номер сессії і пишемо в журнал запитів  
            var SessionID = new SyncSessionMsg(MFO, corporationId, syncDate, syncType);
            return SessionID;
            
            


        }
        #endregion

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public SyncDictMessage GetDictionaryData(String WSProxyUserName, String WSProxyPassword, Int64 LastId)
        {
            // авторизация пользователя, в случае ошибки она полетит к вызывающей стороне
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(WSProxyUserName, WSProxyPassword, true);
            if (isAuthenticated)
            {
                LoginUser(WSProxyUserName);
                //  Bars.Logger.DBLogger.Info("WSProxyUserName= " + WSProxyUserName);
            }
            else
            {
                //Bars.Logger.DBLogger.Info("WSProxyUserName= Noname" + WSProxyUserName);
            }

            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                if (con.State != ConnectionState.Open)
                {
                    con.Open();
                }
                var DictMessage = new SyncDictMessage(LastId, con);
                return DictMessage;

            }


        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public void SyncDictionary()
        {
            // авторизация пользователя
            /*Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(WSProxyUserName, WSProxyPassword, true);
            if (isAuthenticated)
            {
                LoginUser(WSProxyUserName);
                //  Bars.Logger.DBLogger.Info("WSProxyUserName= " + WSProxyUserName);
            }
            else
            {
                //Bars.Logger.DBLogger.Info("WSProxyUserName= Noname" + WSProxyUserName);
            }*/
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

            KFilesRemoteService.KFilesService kfs = new KFilesRemoteService.KFilesService();
            kfs.Url = KFilesService.KFilesServiceUrl;//"http://10.10.10.85/barsroot/webservices/KFILEsService.asmx"/* */;


            //var SessionID = kfs.SyncSession(KFilesService.KFilesServiceUser, KFilesService.KFilesServiceUserPass, 302010, "", "01012016", "DICT");
            // отримуємо № сессії

            var SessionID = kfs.SyncSession(KFilesService.KFilesServiceUser, KFilesService.KFilesServiceUserPass, KFilesService.KFilesServiceSyncMFO, "", "01012016"/*не впливаючий параметр,дата ставиться sysdate сервера*/, "DICT");

            if (SessionID.SessionStatus == "OK")
            {
                KFilesRemoteService.SyncDictMessage ds = kfs.GetDictionaryData(KFilesService.KFilesServiceUser, KFilesService.KFilesServiceUserPass, KFilesService.KFilesServiceSyncDictId);
                Int64 lastId = ds.LastId;
                foreach (Corporation corporation in ds.SyncMsg.Corporation)
                {
                    Bars.KFiles.Dictionary.Corporation corp =
                        new Bars.KFiles.Dictionary.Corporation(corporation.Id, corporation.CorporationCode, corporation.CorporationName, corporation.ParentId, corporation.StateId, corporation.EXTERNAL_ID);
                    corp.Save();
                }


                BbConnection bb_con = new BbConnection();

                try
                {
                    // пакет для записи в БД
                    KFilesPack kp = new KFilesPack(bb_con);
                    kp.SET_SYNC_ID(lastId);
                }
                catch (System.Exception ex)
                {
                    throw;
                }
                finally
                {
                    bb_con.CloseConnection();
                }


            }
        }
        public decimal? GetCountRowsTmp(Decimal sessionId)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            if (con.State != ConnectionState.Open)
                con.Open();
            decimal? result;
            try
            {
                OracleCommand cmd = con.CreateCommand();
                cmd.CommandText = @"select BARS.kfile_pack.corp_data_cnt( :p_session_id)  from dual";
                cmd.Parameters.Add("p_session_id", OracleDbType.Decimal, sessionId, ParameterDirection.Input);
                OracleDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    result = String.IsNullOrEmpty(rdr.GetValue(0).ToString()) ? (decimal?)null : rdr.GetDecimal(0);
                    return result;
                }
                else
                {
                    result = 0;
                    return result;
                }
            }
            catch (System.Exception ex)
            {
                throw;
            }
            finally
            {
                con.Close();
            }
        }

        public void CommitKFiles(decimal sessionid)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            if (con.State != ConnectionState.Open)
                con.Open();
            OracleCommand commandImport = new OracleCommand("bars.kfile_pack.corp_data_ins", con);
            commandImport.CommandType = System.Data.CommandType.StoredProcedure;
            commandImport.Parameters.Add("p_session_id", OracleDbType.Varchar2, sessionid, ParameterDirection.Input);
            try
            {

                commandImport.ExecuteNonQuery();
            }
            catch (System.Exception)
            {

                RollBackKFilesImport(sessionid);
            }
        }
        public void RollBackKFilesImport(decimal sessionId)
        {
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            if (con.State != ConnectionState.Open)
                con.Open();
            OracleCommand commandImport = new OracleCommand("bars.kfile_pack.corp_data_del", con);
            commandImport.CommandType = System.Data.CommandType.StoredProcedure;
            commandImport.Parameters.Add("p_session_id", OracleDbType.Varchar2, sessionId, ParameterDirection.Input);
            try
            {

                commandImport.ExecuteNonQuery();
            }
            catch (System.Exception)
            {

                throw;
            }
        }






        [WebMethod(EnableSession = true)]
        public void GetKFileData(String WSProxyUserName, String WSProxyPassword, List<Bars.KFiles.Struct.KFileRow> kFileData, int count)
        {
            // авторизация пользователя

            Decimal sessionId = kFileData.Select(x => x.SESSION_ID).FirstOrDefault();
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(WSProxyUserName, WSProxyPassword, true);
            if (isAuthenticated)
            {
                LoginUser(WSProxyUserName);
                //  Bars.Logger.DBLogger.Info("WSProxyUserName= " + WSProxyUserName);
            }
            else
            {
                //Bars.Logger.DBLogger.Info("WSProxyUserName= Noname" + WSProxyUserName);
            }
            OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();
            try
            {

                if (con.State != ConnectionState.Open)
                    con.Open();

                int i = 0;
                // Начинаем сессию взаимодействия и вычитываем сообщение і пишемо в таблицю
                foreach (Bars.KFiles.Struct.KFileRow inputData in kFileData)
                {
                    //  Bars.Logger.DBLogger.Info("FNVRDataRow.inputData" + inputData.ToString() );
                    if (i % 1000 == 0)
                    {
                        //  Bars.Logger.DBLogger.Info("FNVRCounter =" + i.ToString());
                    }
                    inputData.WriteRow(con);
                    i++;

                }
                decimal? countTemp = GetCountRowsTmp(sessionId);
                if (count == countTemp)
                {
                    CommitKFiles(sessionId);
                }
            }
            catch (System.Exception ex)
            {
                RollBackKFilesImport(sessionId);
            }

            finally
            {

                con.Close();
            }

        }


        public bool CheckMFO()
        {
            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                if (con.State != ConnectionState.Open)
                    con.Open();
                try
                {
                    decimal? result;
                    OracleCommand cmd = con.CreateCommand();
                    cmd.CommandText = @"select BARS.kfile_pack.get_mmfo_type from dual";
                    OracleDataReader rdr = cmd.ExecuteReader();
                    if (rdr.Read())
                    {
                        result = String.IsNullOrEmpty(rdr.GetValue(0).ToString()) ? (decimal?)null : rdr.GetDecimal(0);
                        return (result == 1) ? true : false;
                    }
                    else
                    {
                        result = 0;
                        return false;
                    }
                }
                catch (System.Exception)
                {
                    throw;
                }
                finally
                {
                    con.Close();
                }
            }

        }



        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
        public void SyncKFileData(String pDate, String pCorpCode)
        {

            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            KFilesRemoteService.KFilesService kfs = new KFilesRemoteService.KFilesService();
            kfs.Url = KFilesService.KFilesServiceUrl;
            
            var SessionID = kfs.SyncSession(KFilesService.KFilesServiceUser, KFilesService.KFilesServiceUserPass, KFilesService.KFilesServiceSyncMFO, pCorpCode,
                pDate, "DATA");

            // отримуємо № сессії

            if (SessionID.SessionStatus == "OK")
            {
                OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection();

                try
                {
                    // Наповнюємо дані за поточний день
                    BbConnection bb_con = new BbConnection();
                    // пакет для записи в БД
                    KFilesPack kp = new KFilesPack(bb_con);
                    kp.FILL_DATA(pDate, pCorpCode);

                    //kp.FILL_TODAY_DATA();
                }
                catch (System.Exception)
                {
                    throw;
                }


                if (CheckMFO())
                {
                    try
                    {
                        List<KFileRow> kFileList = new List<KFileRow>();
                        OracleCommand cmd = con.CreateCommand();
                        #region SQL
                        cmd.CommandText = @"select ROWTYPE as rowtype ,
                                        OURMFO as ourmfo ,
                                        NLS as nls ,
                                        KV as kv ,
                                        OKPO as okpo ,
                                        OBDB as obdb ,
                                        OBDBQ as obdbq ,
                                        OBKR as obkr ,
                                        OBKRQ as obkrq ,
                                        OST as ost ,
                                        OSTQ as ostq ,
                                        KOD_CORP as kod_corp ,
                                        KOD_USTAN as kod_ustan ,
                                        KOD_ANALYT as kod_analyt ,
                                        DAPP as dapp ,
                                        POSTDAT as postdat ,
                                        DOCDAT as docdat ,
                                        VALDAT as valdat ,
                                        ND as nd ,
                                        VOB as vob ,
                                        DK as dk ,
                                        MFOA as mfoa ,
                                        NLSA as nlsa ,
                                        KVA as kva ,
                                        NAMA as nama ,
                                        OKPOA as okpoa ,
                                        MFOB as mfob ,
                                        NLSB as nlsb ,
                                        KVB as kvb ,
                                        NAMB as namb ,
                                        OKPOB as okpob ,
                                        S as s ,
                                        DOCKV as dockv ,
                                        SQ as sq ,
                                        NAZN as nazn ,
                                        DOCTYPE as doctype ,
                                        POSTTIME as posttime ,
                                        NAMK as namk ,
                                        NMS as nms ,
                                        TT as tt 
                                from bars.TMP_LICCORPC_KFILE";
                        #endregion
                        cmd.Parameters.Clear();
                        int count = 0;
                        using (OracleDataReader rdr = cmd.ExecuteReader())
                        {
                            #region reader
                            while (rdr.Read())
                            {
                                KFileRow row = new KFileRow();
                                row.CORPORATION_ID = rdr["kod_corp"] == DBNull.Value ? 0 : Convert.ToDecimal(rdr["kod_corp"]);
                                row.FILE_DATE = DateTime.Now;
                                row.ROWTYPE = rdr["rowtype"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["rowtype"]);
                                row.OURMFO = rdr["ourmfo"] == DBNull.Value ? "" : Convert.ToString(rdr["ourmfo"]);
                                row.NLS = rdr["nls"] == DBNull.Value ? "" : Convert.ToString(rdr["nls"]);
                                row.KV = rdr["kv"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["kv"]);
                                row.OKPO = rdr["okpo"] == DBNull.Value ? "" : Convert.ToString(rdr["okpo"]);
                                row.OBDB = rdr["obdb"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["obdb"]);
                                row.OBDBQ = rdr["obdbq"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["obdbq"]);
                                row.OBKR = rdr["obkr"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["obkr"]);
                                row.OBKRQ = rdr["obkrq"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["obkrq"]);
                                row.OST = rdr["ost"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["ost"]);
                                row.OSTQ = rdr["ostq"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["ostq"]);
                                row.KOD_CORP = rdr["kod_corp"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["kod_corp"]);
                                row.KOD_USTAN = rdr["kod_ustan"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["kod_ustan"]);
                                row.KOD_ANALYT = rdr["kod_analyt"] == DBNull.Value ? "" : Convert.ToString(rdr["kod_analyt"]);
                                row.DAPP = rdr["dapp"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["dapp"]);
                                row.POSTDAT = rdr["postdat"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["postdat"]);
                                row.DOCDAT = rdr["docdat"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["docdat"]);
                                row.VALDAT = rdr["valdat"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["valdat"]);
                                row.ND = rdr["nd"] == DBNull.Value ? "" : Convert.ToString(rdr["nd"]);
                                row.VOB = rdr["vob"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["vob"]);
                                row.DK = rdr["dk"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["dk"]);
                                row.MFOA = rdr["mfoa"] == DBNull.Value ? "" : Convert.ToString(rdr["mfoa"]);
                                row.NLSA = rdr["nlsa"] == DBNull.Value ? "" : Convert.ToString(rdr["nlsa"]);
                                row.KVA = rdr["kva"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["kva"]);
                                row.NAMA = rdr["nama"] == DBNull.Value ? "" : Convert.ToString(rdr["nama"]);
                                row.OKPOA = rdr["okpoa"] == DBNull.Value ? "" : Convert.ToString(rdr["okpoa"]);
                                row.MFOB = rdr["mfob"] == DBNull.Value ? "" : Convert.ToString(rdr["mfob"]);
                                row.NLSB = rdr["nlsb"] == DBNull.Value ? "" : Convert.ToString(rdr["nlsb"]);
                                row.KVB = rdr["kvb"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["kvb"]);
                                row.NAMB = rdr["namb"] == DBNull.Value ? "" : Convert.ToString(rdr["namb"]);
                                row.OKPOB = rdr["okpob"] == DBNull.Value ? "" : Convert.ToString(rdr["okpob"]);
                                row.S = rdr["s"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["s"]);
                                row.DOCKV = rdr["dockv"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["dockv"]);
                                row.SQ = rdr["sq"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["sq"]);
                                row.NAZN = rdr["nazn"] == DBNull.Value ? "" : Convert.ToString(rdr["nazn"]);
                                row.DOCTYPE = rdr["doctype"] == DBNull.Value ? (Decimal?)null : Convert.ToDecimal(rdr["doctype"]);
                                row.POSTTIME = rdr["posttime"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(rdr["posttime"]);
                                row.NAMK = rdr["namk"] == DBNull.Value ? "" : Convert.ToString(rdr["namk"]);
                                row.NMS = rdr["nms"] == DBNull.Value ? "" : Convert.ToString(rdr["nms"]);
                                row.TT = rdr["tt"] == DBNull.Value ? "" : Convert.ToString(rdr["tt"]);
                                row.SESSION_ID = SessionID.SessionID;
                                #endregion
                                kFileList.Add(row);
                                count++;
                            }
                            rdr.Close();
                        }
                        for (int i = 0; i < kFileList.Count(); i++)
                        {
                            var temparray = kFileList.Take(10000);
                            var arr = temparray.ToArray();

                            kfs.GetKFileData(KFilesService.KFilesServiceUser, KFilesService.KFilesServiceUserPass, arr, count);
                            kFileList.RemoveRange(0, arr.Length);
                        }
                    }
                    catch (System.Exception)
                    {
                        throw;
                    }
                    finally
                    {
                        con.Close();
                    }


                }
            }
        }



    }
}