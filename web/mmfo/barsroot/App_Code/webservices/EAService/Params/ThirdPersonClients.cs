using Newtonsoft.Json;
using System;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Юр.лицо - третьи лица кліенти банку
    /// </summary>
    public struct ThirdPersonsClients
    {
        [JsonProperty("rnk")]
        public UInt64 Rnk;
        [JsonProperty("personStateID")]
        public Int16 PersonStateID;
        [JsonProperty("date_begin_powers")]
        public DateTime? DateBeginPowers;
        [JsonProperty("date_end_powers")]
        public DateTime? DateEndPowers;

        public ThirdPersonsClients(UInt64 rnk, Int16 personStateID, DateTime? dateBeginPowers, DateTime? dateEndPowers)
        {
            this.Rnk = rnk;
            this.PersonStateID = personStateID;
            this.DateBeginPowers = dateBeginPowers;
            this.DateEndPowers = dateEndPowers;
        }
    }
}