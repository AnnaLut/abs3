namespace BarsWeb.Areas.Zay.Models
{
    public class RateConfig
    {
        public bool blk { get; set; }
        public decimal rateType { get; set; }
        public decimal viewType { get; set; }
        public decimal conType { get; set; }
        public string kvCode { get; set; }
        public decimal? indBuy { get; set; }
        public decimal? indSale { get; set; }
        public decimal? indBuyVip { get; set; }
        public decimal? indSaleVip { get; set; }
        public decimal? fBuy { get; set; }
        public decimal? fSale { get; set; }
        public decimal? newKurs { get; set; }
        public decimal? pairKursF { get; set; }
        public decimal? pairKursS { get; set; }
        public decimal? pairKvBase { get; set; }
    }
}