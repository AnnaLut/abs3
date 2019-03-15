using Newtonsoft.Json;

namespace Areas.NbuIntegration.Models
{
    public class SagoRegion
    {
        [JsonProperty("REG_ID")]
        public short? RegionId { get; set; }
        [JsonProperty("NAME")]
        public int Name { get; set; }
        [JsonProperty("KF")]
        public string Mfo { get; set; }
    }
}