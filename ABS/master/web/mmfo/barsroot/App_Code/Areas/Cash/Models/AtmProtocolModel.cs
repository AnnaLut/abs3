namespace BarsWeb.Areas.Cash.Models
{
    public class AtmProtocolModel
    {
        public string ID_ATM { get; set; }
        public decimal? LIM_MAX { get; set; }
        public string NAME_RU { get; set; }
        public string NAME_ACC { get; set; }
        public decimal? STATUS { get; set; }
        public string ERROR { get; set; }
    }
}
