using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.Areas.DptSocial.Models
{
    public class V_DPT_FILE_IMPR_DTL
    {
        public String KF { get; set; }
        public Decimal USR_ID { get; set; }
        public DateTime FILE_DT { get; set; }
        public Int32 FILE_TP { get; set; }
        public String FILE_NM { get; set; }
        public Decimal FILE_SUM { get; set; }
        public Int32 FILE_QTY { get; set; }
        public Decimal FILE_HDR_ID { get; set; }
        public Decimal TOT_AMT { get; set; }
        public Int32 TOT_QTY { get; set; }
        public Int32 PAID_QTY { get; set; }
        public Int32 PAID_AMT { get; set; }
        public Int32 BAD_QTY { get; set; }
        public Int32 CLS_QTY { get; set; }
        public Int32 PYMT_QTY { get; set; }
    }
}
