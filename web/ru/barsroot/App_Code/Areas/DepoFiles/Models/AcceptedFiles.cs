using System;

namespace BarsWeb.Areas.DepoFiles.Models
{
    public class AcceptedFiles
    {
        public decimal HEADER_ID { get; set; }
        public string FILENAME { get; set; }
        public DateTime DAT { get; set; }
        public string FDAT { get; set; }
        public int? INFO_LENGTH { get; set; }
        public decimal? SUM { get; set; }
        public string NAZN { get; set; }
        public string BRANCH { get; set; }
        public decimal HEADER_LENGTH { get; set; }
        public string MFO_A { get; set; }
        public string NLS_A { get; set; }
        public string MFO_B { get; set; }
        public string NLS_B { get; set; }
        public decimal DK { get; set; }
        public decimal TYPE { get; set; }
        public string NUM { get; set; }
        public string HAS_ADD { get; set; }
        public string NAME_A { get; set; }
        public string NAME_B { get; set; }
        public decimal BRANCH_CODE { get; set; }
        public decimal DPT_CODE { get; set; }
        public string EXEC_ORD { get; set; }
        public string KS_EP { get; set; }
        public decimal TYPE_ID { get; set; }
        public decimal AGENCY_TYPE { get; set; }
        public decimal CAN_DELETE { get; set; }
    }
}