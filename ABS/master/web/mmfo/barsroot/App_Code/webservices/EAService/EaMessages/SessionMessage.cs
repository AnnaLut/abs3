using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;

namespace Bars.EAD.Messages
{
    /// <summary>
    /// Сообщение ЕА - сессионное
    /// </summary>
    public class SessionMessage : BaseMessage
    {
        private String _SessionID;

        [JsonProperty("sessionid")]
        public String SessionID
        {
            get
            {
                return this._SessionID;
            }
        }

        public SessionMessage(String SessionID, String Method, Int64 ID)
            : base(Method, ID)
        {
            this._SessionID = SessionID;
        }
        public SessionMessage(String SessionID, String Method, OracleConnection con)
            : this(SessionID, Method, BaseMessage.GetNextID(con))
        {
        }
    }
}