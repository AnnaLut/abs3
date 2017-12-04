using System;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrEvents
    {
        public int NUM { get; set; }
        public Int32 DEAL_ID { get; set; }
        public string DEAL_KF { get; set; }
        public Int32? DEAL_ADR_ID { get; set; }
        public string DEAL_REGION { get; set; }
        public string DEAL_FULL_ADDRESS { get; set; }
        public string DEAL_BUILD_TYPE { get; set; }
        public Int32? DEAL_EVENT_ID { get; set; }
        public string DEAL_EVENT { get; set; }
    }
}