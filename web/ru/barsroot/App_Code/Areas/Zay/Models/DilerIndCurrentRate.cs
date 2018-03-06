namespace BarsWeb.Areas.Zay.Models
{
    /// <summary>
    /// Курс дилера sндекативний згідно банківської дати
    /// </summary>
    public class DilerIndCurrentRate
    {
        public decimal? kursB { get; set; }
        public decimal? kursS { get; set; }
        public decimal? vipB { get; set; }
        public decimal? vipS { get; set; }
        public decimal? blk { get; set; }
    }
}