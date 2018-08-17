using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;

namespace Bars.EAD.Messages
{
    /// <summary>
    /// Cообщение ЕА - начало сессии взаимодействия с ЕА
    /// </summary>
    public class StartSessionMessage : BaseMessage
    {

        [JsonProperty("user_login")]
        public String User_Login;
        [JsonProperty("user_fio")]
        public String User_Fio;
        [JsonProperty("user_password")]
        public String User_Password;
        public String EADServiceUrl;

        public StartSessionMessage(OracleConnection con, String kf)
            : base("StartSession", con)
        {
            InitParams(con, kf);
        }

        public StartSessionMessage(OracleConnection con, String kf, long msgId)
        : base("StartSession", msgId)
        {
            InitParams(con, kf);
        }

        private void InitParams(OracleConnection con, String kf)
        {
            Structs.Params.StartSession per = Structs.Params.StartSession.GetInstance(con, kf);

            this.User_Login = per.UserLogin;
            this.User_Fio = per.UserFio;
            this.User_Password = per.UserPassword;
            this.EADServiceUrl = per.EAServiceUrl;
        }
    }

    /// <summary>
    /// Cообщение ЕА - закрытие сессии взаимодействия с ЕА
    /// </summary>
    public class CloseSessionMessage : SessionMessage
    {
        //public CloseSessionMessage(String SessionID, OracleConnection con)
        //    : base(SessionID, "CloseSession", con)
        //{
        //}

        public CloseSessionMessage(String SessionID, OracleConnection con)
            : base(SessionID, "CloseSession", -1)
        {
        }
    }
}