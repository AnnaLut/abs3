namespace BarsWeb.Areas.Crkr.Models
{
    /// <summary>
    /// Модель довіреності
    /// </summary>
    public class CrkrBag
    {
        public string fio { get; set; }
        public string clientbdate { get; set; }
        public string doctype { get; set; }
        public string docserial { get; set; }
        public string docnumber { get; set; }
        public string icod { get; set; }
        public string ScoreNumber { get; set; }
        public string branch { get; set; }
        public string nsc { get; set; }
        public string ob22 { get; set; }
        public bool load { get; set; }
    }
}