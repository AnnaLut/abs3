namespace BarsWeb.Areas.BaseRates.Models
{
    public class RatesOptions
    {
        public decimal IDROW { get; set; }
        public decimal S { get; set; }
        public string S_STRING { get { return S.ToString(); } }
        //public decimal OLD_RATE { get; set; }
        public decimal IR { get; set; }
    }
}