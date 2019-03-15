using Newtonsoft.Json;

namespace Areas.NbuIntegration.Models
{
    public class StatusModel
    {
        [JsonProperty("name")]
        public string Name { get; set; }
        [JsonProperty("value")]
        public int Id { get; set; }
    }
}