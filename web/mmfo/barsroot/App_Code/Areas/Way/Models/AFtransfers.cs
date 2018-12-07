using Newtonsoft.Json;
namespace BarsWeb.Areas.Way.Models
{
    public class AFtransfers
    {
        public decimal ID { get; set; }
        public decimal IDN { get; set; }
        public string SYNTHCODE { get; set; }
        public decimal? DOC_DRN { get; set; }
        public decimal? DOC_ORN { get; set; }
        public decimal? DK { get; set; }
        public string NLSA { get; set; }
        //[JsonIgnore]
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
        public string NLSB { get; set; }
        //[JsonIgnore]
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
        public decimal? INST_CHAIN_IDT { get; set; }
        public decimal? INST_PLAN_ID { get; set; }
    }
}