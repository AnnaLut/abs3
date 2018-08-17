using Newtonsoft.Json;
using System;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Юр.лицо - третьи лица не кліенти банку
    /// </summary>
    public struct ThirdPersonsNonClients
    {
        [JsonProperty("ID")]
        public String Id;
        [JsonProperty("personStateID")]
        public Int16 PersonStateID;
        [JsonProperty("name")]
        public String Name;
        [JsonProperty("client_type")]
        public Byte ClientType;
        [JsonProperty("inn_edrpou")]
        public String InnEdrpou;
        [JsonProperty("date_begin_powers")]
        public DateTime? DateBeginPowers;
        [JsonProperty("date_end_powers")]
        public DateTime? DateEndPowers;

        public ThirdPersonsNonClients(String ID, Int16 PersonStateID, String name, Byte clientType, String innEdrpou, DateTime? dateBeginPowers, DateTime? dateEndPowers)
        {
            this.Id = ID;
            this.PersonStateID = PersonStateID;
            this.ClientType = clientType;
            this.Name = name;
            this.InnEdrpou = innEdrpou;
            this.DateBeginPowers = dateBeginPowers;
            this.DateEndPowers = dateEndPowers;
        }
    }
}