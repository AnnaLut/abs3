using System;

namespace Areas.Swift.Models
{
    public class UnlockMsgs
    {
        public decimal SWREF { get; set; }
        public int? MT { get; set; }
        public string TRN { get; set; }
        public string SENDER { get; set; }
        public string SENDER_NAME { get; set; }
        public string RECEIVER { get; set; }
        public string RECEIVER_NAME { get; set; }
        public string CURRENCY { get; set; }
        public decimal? AMOUNT { get; set; }
        public DateTime? DATE_PAY { get; set; }
        public DateTime? DATE_REC { get; set; }
        public DateTime? VDATE { get; set; }
    }
}
