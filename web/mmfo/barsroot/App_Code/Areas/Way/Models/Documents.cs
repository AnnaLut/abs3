using Newtonsoft.Json;

namespace BarsWeb.Areas.Way.Models
{
    public class Documents
    {
        public decimal ID { get; set; }
        public decimal IDN { get; set; }
        public string NLSA { get; set; }

        [JsonIgnore]
        public decimal? S { get; set; }

        public decimal? Sgrn
        {
            get
            {
                return null == S ? 0 : S / 100;
            }
            set
            {
                S = value * 100;
            }
        }

        public decimal? KV { get; set; }
        public string MFOB { get; set; }
        public string ID_B { get; set; }
        public string NAM_B { get; set; }
        public string NLSB { get; set; }
        [JsonIgnore]
        public decimal? S2 { get; set; }
        public decimal? Sgrn2
        {
            get
            {
                return null == S2 ? 0 : S2 / 100;
            }
            set
            {
                S2 = value * 100;
            }
        }
        public decimal? KV2 { get; set; }
        public string NAZN { get; set; }
        public string ERR_TEXT { get; set; }
        public string URL { get; set; }
        public decimal? FAILURES_COUNT { get; set; }

        public decimal? Doc_DRN { get; set; }
    }
}
