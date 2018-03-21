using System;

namespace BarsWeb.Areas.CDO.Corp2.Models
{
    /// <summary>
    /// Summary description for Corp2CustomerAccount
    /// </summary>
    public class Corp2CustomerAccount
    {
        public decimal? RNK { get; set; }
        public decimal BANK_ACC { get; set; }
        public int? CORP2_ACC { get; set; }
        public int? IS_CORP2_ACC { get; set; }
        public string NUM_ACC { get; set; }
        public string NAME { get; set; }
        public int? CODE_CURR { get; set; }
        public DateTime? OPEN_DATE { get; set; }
        public DateTime? LAST_MOVE_DATE { get; set; }
        public DateTime? CLOSE_DATE { get; set; }
        public decimal? REST { get; set; }
        public decimal REST_VIEW { get { return REST == null ? 0 : REST.Value / 100; } }
        public decimal? DEB_TURNOVER { get; set; }
        public decimal DEB_TURNOVER_VIEW { get { return DEB_TURNOVER == null ? 0 : DEB_TURNOVER.Value / 100; } }
        public decimal? KRED_TURNOVER { get; set; }
        public decimal KRED_TURNOVER_VIEW { get { return KRED_TURNOVER == null ? 0 : KRED_TURNOVER.Value / 100; } }
        public string EXECUTOR_NAME { get; set; }
        public string BRANCH { get; set; }
        public string BRANCH_NAME { get; set; }
        public string KF { get; set; }
        public decimal? VISA_COUNT { get; set; }
    }
}