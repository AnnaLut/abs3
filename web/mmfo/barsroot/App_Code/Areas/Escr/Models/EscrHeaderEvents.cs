using System;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrHeaderEvents
    {
        public decimal NUM { get; set; }
        public decimal DEAL_ID { get; set; }
        public decimal? DEAL_ADR_ID { get; set; }
        public string DEAL_REGION { get; set; }
        public string DEAL_FULL_ADDRESS { get; set; }
        public string DEAL_BUILD_TYPE { get; set; }
        public decimal? DEAL_EVENT_ID { get; set; }
        public decimal? DEAL_BUILD_ID { get; set; }
    }
}