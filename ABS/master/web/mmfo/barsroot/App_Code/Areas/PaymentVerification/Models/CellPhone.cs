using System;

namespace Areas.PaymentVerification.Models
{
    public class CellPhone
    {
        public string rnk { get; set; }
        public string phone { get; set; }
        public string code { get; set; }
        public bool skipcode { get; set; }
        public string image_type { get; set; }
    }
}

