using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SubContractModel
/// </summary>

namespace BarsWeb.Areas.Way.Models
{
    public class SubContractModel
    {
        public decimal CHAIN_IDT { get; set; }
        public decimal? ND { get; set; }
        public decimal? ST_ID { get; set; }
        public string ST_NAME { get; set; }
        public decimal? TOTAL_AMOUNT { get; set; }
        public decimal? AMOUNT_TO_PAY { get; set; }
        public decimal? TENOR { get; set; }
        public decimal? PAID_PARTS { get; set; }
        public decimal? WAITING_PARTS { get; set; }
        public decimal? OVD_PARTS { get; set; }
        public decimal? OVD_PARTS_SUM { get; set; }
        public DateTime? OVD_90_DAYS { get; set; }
        public decimal? SUB_INT_RATE { get; set; }        
        public decimal? EFF_RATE { get; set; }
        public decimal? SUB_FEE_RATE { get; set; }
        public DateTime? POSTING_DATE { get; set; }
        public DateTime? END_DATE_P { get; set; }
    }
}