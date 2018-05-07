namespace BarsWeb.Areas.Clients.Models
{
    public class V_ADR_SETTLEMENTS
    {
        public decimal SETL_ID { get; set; }
        public decimal SETL_TP_ID { get; set; }
        public decimal? REGION_ID { get; set; }
        public decimal? AREA_ID { get; set; }
        public string SETL_NM { get; set; }
        public string SETL_TP_NM { get; set; }
        public string REGION_NAME { get; set; }
        public string AREA_NAME { get; set; }
    }
}