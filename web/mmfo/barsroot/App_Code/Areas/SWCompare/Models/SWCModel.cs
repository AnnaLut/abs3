using System;

namespace BarsWeb.Areas.SWCompare.Models
{
    public class SWCModel
    {
        public decimal? TYPE { get; set; }
        public string SYSTEM { get; set; }
        public DateTime? DDATE { get; set; }
        public string TRANSACTIONID_BARS { get; set; }
        public string TRANSACTIONID_EW { get; set; }
        public decimal? OPERATION { get; set; }
        public string OPERATION_NAME { get; set; }
        public DateTime? DATE_BARS { get; set; }
        public DateTime? DATE_EW { get; set; }
        public decimal? REF { get; set; }
        public string CAUSE_ERR { get; set; }
        public string KF { get; set; }
        public string BRANCH_BARS { get; set; }
        public string BRANCH_EW { get; set; }
        public string NLS { get; set; }
        public string KV { get; set; }
        public decimal? SUM_BARS { get; set; }
        public decimal? KOM_BARS { get; set; }
        public decimal? SUM_EW { get; set; }
        public decimal? KOM_EWT { get; set; }
        public decimal? KOM_EWB { get; set; }
        public string NAZN { get; set; }
        public decimal? ID_C { get; set; }
        public string TRN { get; set; }
        public string TT { get; set; }
        public decimal? PRN_FILE { get; set; }
        public string KOD_NBU { get; set; }
        public decimal? CAUSE_ERR_ID { get; set; }
    }
}