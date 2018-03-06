namespace BarsWeb.Areas.Zay.Models
{
    public class CurrencyPair
    {
        public decimal kv_f { get; set; }
        public decimal kv_s { get; set; }
        public string name_f { get; set; }
        public string name_s { get; set; }
        public decimal? kv_base { get; set; }
    }
}