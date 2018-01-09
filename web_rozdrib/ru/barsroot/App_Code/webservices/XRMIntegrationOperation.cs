using System;
using System.Web;
using System.Web.Services;
using barsroot.core;
using BarsWeb.Core.Logger;
using Bars.Application;

/// <summary>
/// XRMIntegrationOperation сервис интеграции с Единым окном (проводки)
/// </summary>
/// 
namespace Bars.WebServices
{
    #region regpay_construnct
    public class XRMPayments
    {
        public static DateTime? GmtToLocal(DateTime? dateTime)
        {
            if (dateTime.HasValue && dateTime.Value != null)
            {
                TimeZoneInfo tz = TimeZoneInfo.Local;
                DateTime _dateTime = dateTime.Value;
                return TimeZoneInfo.ConvertTimeFromUtc(_dateTime, tz);
            }
            else { return null; }
        }
        public class XRMDocument
        {
            public class XRMDocSettingsRequest
            {
                public Decimal TransactionId;   //унікальний код транзакції
                public String UserLogin;        //логін користувача АД
                public Int16 OperationType;     //тип операції сервіса                 
                public Int64 KF;                //код філії (МФО)
                public string Branch;           //відділення, де виконується операція
                public String TTS;              //тип операції TTS
                public decimal? RNK;            //РНК клієнта               
                public decimal? ND;             //номер договору
            }

            public class XRMDocSettingsResult
            {
                public XRMDoc XRMDoc;                           //заготовка платежа
                public XRMAdditionalReqs XRMAdditionalReqs;     // перелік додаткових реквізитів
                public int ResultCode;                          //статус створення 0-Ок, -1 помилк
                public string ResultMessage;                    //опис помилки створення рег.платежу
            }

            public class XRMDoc
            {
                public char TT;
                public decimal VOB;
                public String ND;
                public DateTime PDAT;
                public DateTime VDAT;
                public Int16 DK;
                public Int16 KV;
                public decimal S;
                public Int16 KV2;
                public decimal S2;
                public Int16 SK;
                public DateTime DATA;
                public DateTime DATP;
                public String NAME_A;
                public String NLS_A;
                public String MFO_A;
                public String NAME_B;
                public String NLS_B;
                public String MFO_B;
                public String PURPOSE;
                public String D_REC;
                public String ID_A;
                public String ID_B;
                public String ID_O;
                public String SIGN;
                public Int16 SOS;
                public Int16 PRTY;
                public Decimal UID;
            }
            public class XRMAdditionalReqs
            {
                public string tag;
                public string type;
                public string strvalue;
                public decimal decimalvalue;
                public DateTime datevalue;
            }
            public class XRMDocResult
            {
                public Decimal REF;                     //референс документа
                public int ResultCode;                  //загальний код виконання операції 0-Ок, -1-помилка
                public string ResultMessage;            //опис помилки         
            }
        }    
    }


    #endregion regpay_construnct    
    /// <summary>
    /// Веб-сервіс для взаємодії з системою XRM Єдине вікно
    /// </summary>
    [WebService(Namespace = "http://ws.unity-bars-operation.com.ua/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class XRMIntegrationOperation : BarsWebService
    {
        public WsHeader WsHeaderValue;
        private IDbLogger _dbLogger;

        #region LoginService
        private void LoginADUserInt(String userName)
        {
            // информация о текущем пользователе
            try
            {
                InitOraConnection();
                // установка первичных параметров
                ClearParameters();
                SetParameters("p_session_id", DB_TYPE.Varchar2, Session.SessionID, DIRECTION.Input);
                SetParameters("p_login_name", DB_TYPE.Varchar2, userName, DIRECTION.Input);
                SetParameters("p_authentication_mode", DB_TYPE.Varchar2, "ACTIVE DIRECTORY", DIRECTION.Input);
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
        private void LoginUser()
        {

            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "absadm";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "<указать пароль!!!>";

            // авторизация пользователя по хедеру
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated)
                LoginUserInt(userName);
        }

        private void LoginADUser(string ADLogname)
        {

            String userName = WsHeaderValue != null ? WsHeaderValue.UserName : "absadm";
            String password = WsHeaderValue != null ? WsHeaderValue.Password : "<указать пароль!!!>";

            // авторизация пользователя по хедеру
            Boolean isAuthenticated = CustomAuthentication.AuthenticateUser(userName, password, true);
            if (isAuthenticated)
                LoginADUserInt(ADLogname);
        }
        #endregion LoginService


       
    }
}
 
