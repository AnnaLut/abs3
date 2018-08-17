using Bars.EAD.Models;
using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Data;

namespace Bars.EAD.Messages
{
    /// <summary>
    /// Сообщение ЕА - Довідник
    /// </summary>
    public class DictMessage : SyncMessage
    {
        [JsonProperty("dictionary_id")]
        public String Dictionary_ID { get; set; }
        [JsonProperty("row_count")]
        public Int32 Row_Count { get; set; }

        public DictMessage(Int64 ID, String SessionID, OracleConnection con, string kf)
            : base(ID, SessionID, con, kf)
        {
            InitParams(con);
        }

        public DictMessage(SyncQueueRow item, String SessionID, OracleConnection con, string kf, string method)
            : base(item, SessionID, con, kf, method)
        {
            InitParams(con);
        }

        private void InitParams(OracleConnection con)
        {
            this.Dictionary_ID = this.ObjID;
            this.Row_Count = (this.Params as Object[]).Length;
        }
    }
}