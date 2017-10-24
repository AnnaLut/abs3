namespace Areas.CustomerList.Models
{
    /// <summary>
    /// Рядок таблиці Підсумки
    /// </summary>
    public class TotalCurrency
    {
        public int? KV { get; set; }
        public string LCV { get; set; }
        public decimal? ISDF { get; set; }
        public decimal? ISKF { get; set; }
        public decimal? DOS { get; set; }
        public decimal? KOS { get; set; }
        public decimal? OSTCD { get; set; }
        public decimal? OSTCK { get; set; }
        public decimal? RAT { get; set; }
    }
}