namespace BarsWeb.Areas.Pfu.Models.ApiModels
{
    /// <summary>
    /// Модель всхідних параметрів для CallEnvelopeListRequest
    /// </summary>
    public class Dates
    {
        public string start_date { get; set; }
        public string end_date { get; set; }
        public int pfu_type { get; set; }
    }
}