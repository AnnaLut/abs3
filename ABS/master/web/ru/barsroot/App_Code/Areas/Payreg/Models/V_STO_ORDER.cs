using System;

namespace BarsWeb.Areas.Payreg.Models
{
    public class V_STO_ORDER
    {
        public decimal ID { get; set; }
        public decimal CUSTOMER_ID { get; set; }
        public string CUSTOMER_NMK { get; set; }
        public string PAYER_ACCOUNT { get; set; }
        public decimal CURRENCY_ID { get; set; }
        public decimal ORDER_KIND_ID { get; set; }
        public string ORDER_KIND_NAME { get; set; }
        public decimal? REGULAR_AMOUNT { get; set; }
        public DateTime? STOP_DATE { get; set; }
        public string RECEIVER { get; set; }
        public string PAYMENT_DETAILS { get; set; }
        public decimal? PRIORITY { get; set; }
        public string USER_NAME { get; set; }
        public decimal? ORD_STATE { get; set; }
        public DateTime? REG_ORD_DATE { get; set; }
        public string ORD_STATE_NAME { get; set; }
        public string BRANCH { get; set; }        
    }
}