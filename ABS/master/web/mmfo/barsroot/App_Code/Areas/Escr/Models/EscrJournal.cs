using System;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrJournal
    {
        public decimal ID { get; set; }
        public decimal? TOTAL_DEAL_COUNT { get; set; }
        public decimal? SUCCESS_DEAL_COUNT { get; set; }
        public decimal? ERROR_DEAL_COUNT { get; set; }
        public DateTime? OPER_DATE { get; set; }
        public string KF { get; set; }
    }
}