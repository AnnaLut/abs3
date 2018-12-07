using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PaymentsModel
/// </summary>
namespace BarsWeb.Areas.Way.Models
{
    public class PaymentsModel
    {
        public decimal CHAIN_IDT { get; set; }
        public decimal SEQ_NUMBER { get; set; }
        public decimal? ST_ID { get; set; }
        public string ST_NAME { get; set; }
        public DateTime? EFF_DATE { get; set; }
        public DateTime? REP_DATE { get; set; }
        public decimal? TOTAL_AMOUNT { get; set; }
        public decimal? PAID { get; set; }
        public decimal? OVERDUE_AMOUNT { get; set; }
        public decimal? SUM_INT { get; set; }
        public decimal? SUM_FEE { get; set; }
        public decimal? SUM_PRINC { get; set; }
    }
}
