using System;
using ExcelLibrary.BinaryFileFormat;

namespace BarsWeb.Areas.Way.Models
{
    public class NoProccessedFile
    {
        public decimal ID { get; set; }
        public decimal IDN { get; set; }
        public DateTime? DOC_LOCALDATE { get; set; }
        public string DOC_DESCR { get; set; }
        public decimal? DOC_DRN { get; set; }
        public string DOC_SOCMNT { get; set; }
        public string CNT_CONTRACTNUMBER { get; set; }
        public string CNT_CLIENTREGNUMBER { get; set; }
        public string CNT_CLIENTNAME { get; set; }
        public string ORG_CBSNUMBER { get; set; }
        public string DEST_INSTITUTION { get; set; }
        public DateTime? BILL_PHASEDATE { get; set; }
        public decimal? BILL_AMOUNT { get; set; }
        public decimal? BILL_CURRENCY { get; set; }
        public string ERR_TEXT { get; set; }
        public string DOC_TRDETAILS { get; set; }
        public decimal? DOC_RRN { get; set; }
        public decimal? WORK_FLAG { get; set; }
        public string KF { get; set; }
        public string MSGCODES { get; set; }
        public string REPOST_DOC { get; set; }
        public string POSTINGSTATUS { get; set; }
    }
}