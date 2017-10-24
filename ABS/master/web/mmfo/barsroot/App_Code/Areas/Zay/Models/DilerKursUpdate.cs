namespace BarsWeb.Areas.Zay.Models
{
    public class DilerKursUpdate
    {
        public bool blk { get; set; }
        public string rateType { get; set; }
        public string viewType { get; set; }
        public string conType { get; set; }
        public decimal? fBuy { get; set; }
        public decimal? fSale { get; set; }
        public decimal? indBuy { get; set; }
        public decimal? indBuyVip { get; set; }
        public decimal? indSale { get; set; }
        public decimal? indSaleVip { get; set; }
        public decimal? kvCode { get; set; }
        public decimal? newFactKurs { get; set; }
        public decimal? newIndKurs { get; set; }
        public decimal? pairKursF { get; set; }
        public decimal? pairKursS { get; set; }
        public decimal? pairKvBase { get; set; }
    }
}