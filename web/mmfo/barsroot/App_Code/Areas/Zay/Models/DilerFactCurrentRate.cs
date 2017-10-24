namespace BarsWeb.Areas.Zay.Models
{
    /// <summary>
    /// Курс дилера фактичний згідно банківської дати
    /// </summary>
    public class DilerFactCurrentRate
    {
        public decimal? kursB { get; set; }
        public decimal? kursS { get; set; }
    }
}