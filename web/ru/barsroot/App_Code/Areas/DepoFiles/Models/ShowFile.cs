using System;

namespace BarsWeb.Areas.DepoFiles.Models
{
    public class ShowFile
    {
        public decimal ID { get; set; }
        public decimal INFO_ID { get; set; }
        public decimal INFO_ID_TEXT { get; set; }
        public string NLS { get; set; }
        public decimal BRANCH_CODE { get; set; }
        public decimal DPT_CODE { get; set; }
        public decimal? SUM { get; set; }
        public string FIO { get; set; }
        public string ID_CODE { get; set; }
        public DateTime? PAYOFF_DATE { get; set; }
        public string FILE_PAYOFF_DATE { get; set; }
        public decimal? REF { get; set; }
        public string BRANCH { get; set; }
        public string AGENCY_NAME { get; set; }
        public decimal MARKED4PAYMENT { get; set; }
        public decimal DEAL_CREATED { get; set; }
        public string REAL_ACC_NUM { get; set; }
        public string REAL_CUST_CODE{ get; set; }
        public string REAL_CUST_NAME { get; set; }
        public decimal INCORRECT { get; set; }
        public decimal CLOSED { get; set; }
        public decimal EXCLUDED { get; set; }
    }
}