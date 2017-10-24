using System;

namespace BarsWeb.Areas.Cdnt.Models
{
    public class V_NOTARY_PROFIT
    {
        public decimal NOTARY_ID { get; set; }
        public decimal ACCR_ID { get; set; }
        public string BRANCH { get; set; }
        public string NBSOB22 { get; set; }
        public decimal REF_OPER { get; set; }
        public DateTime DAT_OPER { get; set; }
        public decimal PROFIT { get; set; }
    }
}