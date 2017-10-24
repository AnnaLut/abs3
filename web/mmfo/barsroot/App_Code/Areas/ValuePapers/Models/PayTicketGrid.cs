using System;

namespace BarsWeb.Areas.ValuePapers.Models
{
    public class PayTicketGrid
    {
        public string p_NLSA { get; set; }
        public decimal p_OSTA { get; set; }
        public string p_NLSR { get; set; }
        public decimal p_OSTR { get; set; }
        public string p_NLSR2 { get; set; }
        public decimal p_OSTR2 { get; set; }
        public string p_NLSR3 { get; set; }
        public decimal p_OSTR3 { get; set; }
        public decimal? p_ACC { get; set; }
        public DateTime p_ACR_DAT_INT { get; set; }
        public decimal p_OSTR_REAL { get; set; }
        public DateTime p_ACR_DAT { get; set; }
        public DateTime p_APL_DAT { get; set; }
    }
}

