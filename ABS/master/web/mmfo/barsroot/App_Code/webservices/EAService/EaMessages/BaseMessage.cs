using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;

namespace Bars.EAD.Messages
{
    /// <summary>
    /// Сообщение ЕА - базовое
    /// </summary>
    public class BaseMessage
    {
        protected String _Method;
        protected Object _Params;
        protected Int64 _ID;

        [JsonProperty("method")]
        public String Method
        {
            get
            {
                return this._Method;
            }
        }
        [JsonProperty("params")]
        public Object Params
        {
            get
            {
                return this._Params;
            }
            set
            {
                this._Params = value;
            }
        }
        [JsonProperty("message_id")]
        public String MessageID
        {
            get
            {
                return String.Format("BARS-MESS-{0}", this._ID);
            }
        }

        public BaseMessage(String Method, Int64 ID)
        {
            this._Method = Method;
            this._ID = ID;
        }
        public BaseMessage(String Method, OracleConnection con)
            : this(Method, GetNextID(con))
        {
        }


        public String ToJsonString()
        {
            JsonSerializerSettings settings = new JsonSerializerSettings();
            return Newtonsoft.Json.JsonConvert.SerializeObject(this, settings);
        }

        public static Int64 GetNextID(OracleConnection con)
        {
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandText = @"select s_eadsyncqueue.nextval as sync_id from dual";

            Int64 res = Convert.ToInt64(cmd.ExecuteScalar());

            return res;
        }
    }
}