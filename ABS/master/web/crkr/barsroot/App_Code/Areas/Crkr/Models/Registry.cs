namespace BarsWeb.Areas.Crkr.Models
{
    public class Registry
    {
        public decimal[] id { get; set; }
        public string type { get; set; }
        public string startDate { get; set; }
        public string endDate { get; set; }
        public bool check { get; set; }
        public bool preRequest { get; set; }
        public bool block { get; set; }
    }
}