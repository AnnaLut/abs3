using System;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrJournalDetail
    {
        public decimal ID_LOG { get; set; }
        public decimal? DEAL_ID { get; set; }
        public decimal? ERR_CODE { get; set; }
        public string ERR_DESC { get; set; }
        public string COMMENTS { get; set; }
    }
}