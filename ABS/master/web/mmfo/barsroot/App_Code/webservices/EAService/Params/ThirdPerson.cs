using Newtonsoft.Json;
using System;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Угода - Связанное лицо
    /// </summary>
    public struct ThirdPersons
    {
        [JsonProperty("RNK")]
        public UInt64 Rnk;
        [JsonProperty("third_person_state")]
        public Byte ThirdPersonState;

        public ThirdPersons(UInt64 rnk, Byte thirdPersonState)
        {
            this.Rnk = rnk;
            this.ThirdPersonState = thirdPersonState;
        }
    }
}