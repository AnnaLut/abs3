using System;

namespace Areas.Mcp.Models
{
    public class PayAccept
    {
        public decimal ID { get; set; }
        public decimal? ID_MSP_ENV { get; set; }
        public string CODE { get; set; }
        public string SENDER { get; set; }
        public string RECIPIENT { get; set; }
        public long? PARTNUMBER { get; set; }
        public long? PARTTOTAL { get; set; }
        public string COMM { get; set; }
        public DateTime? CREATE_DATE { get; set; }
        public string TOTAL_SUM { get; set; }
        public string TOTAL_SUM_TO_PAY { get; set; }
        public short? STATE_ID { get; set; }
        public string STATE_NAME { get; set; }
        public string STATE_CODE { get; set; }
        public string PAYMENT_TYPE { get; set; }
        public string PAYMENT_PERIOD { get; set; }
        public int? NOT_CAN_SEND { get; set; }
    }
}