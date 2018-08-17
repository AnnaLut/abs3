using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Bars.EAD.Structs.Result
{
    /// <summary>
    /// Ответ синхронизации
    /// </summary>
    public class SyncResult
    {
        [JsonProperty("error")]
        public String Error { get; set; }

        public SyncResult() { }
    }

    /// <summary>
    /// Ответ - Надрукований документ
    /// </summary>
    public class Doc : SyncResult
    {
        [JsonProperty("ID")]
        public Int64 ID;

        public Doc() : base() { }
    }

    /// <summary>
    /// Ответ - Клієнт
    /// </summary>
    public class Client : SyncResult
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;

        public Client() : base() { }
    }
    /// <summary>
    /// Ответ - Клієнт юр.лицо
    /// </summary>
    public class UClient : SyncResult
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;

        public UClient() : base() { }
    }

    /// <summary>
    /// Ответ - Счета юр.лица
    /// </summary>
    public class Acc : SyncResult
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("ACCOUNTS")]
        public List<Int64> Accounts;

        public Acc() : base() { }
    }

    /// <summary>
    /// Ответ - Угода
    /// </summary>
    public class Agr : SyncResult
    {
        [JsonProperty("ID")]
        public Int64 ID;

        public Agr() : base() { }
    }
    /// <summary>
    /// Ответ - Угода Юр.особи
    /// </summary>
    public class UAgr : SyncResult
    {
        [JsonProperty("ID")]
        public String ID;

        public UAgr() : base() { }
    }

    /// <summary>
    /// Ответ - Актуалізація ідент. документів
    /// </summary>
    public class Act : SyncResult
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("DOCS")]
        public List<Int64> Docs;

        public Act() : base() { }
    }
}