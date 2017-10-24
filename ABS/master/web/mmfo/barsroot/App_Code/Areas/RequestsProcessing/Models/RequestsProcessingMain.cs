using System;

namespace Areas.RequestsProcessing.Models
{
    public class RequestsProcessingMain
    {
        public decimal KODZ { get; set; }
        public decimal? KODR { get; set; }
        public string NAME { get; set; }
        public string NAMEF { get; set; }
        public string BINDVARS { get; set; }
        public string CREATE_STMT { get; set; }
        public string RPT_TEMPLATE { get; set; }
        public string DEFAULT_VARS { get; set; }
        public DateTime? LAST_UPDATED { get; set; }
        public string BIND_SQL { get; set; }
    }
}

