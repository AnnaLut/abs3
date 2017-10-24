namespace BarsWeb.Areas.Cash.Models
{
    public class MfoProtocolModel
    {
        public string KF { get; set; }
        public string NAME_KF { get; set; }
        public decimal? LIM_CURRENT { get; set; }
        public decimal? KV { get; set; }
        public decimal? LIM_MAX { get; set; }
        public decimal? STATUS { get; set; }
        public string ERROR { get; set; }
    }
}
