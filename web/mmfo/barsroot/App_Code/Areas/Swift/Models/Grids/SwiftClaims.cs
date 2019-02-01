using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Areas.Swift.Models
{
    public class SwiftClaims
    {
        public decimal SWREF { get; set; }
        public int? MT { get; set; }
        public string TRN { get; set; }
        public string SENDER { get; set; }
        public string SENDER_NAME { get; set; }
        public string RECEIVER { get; set; }
        public string RECEIVER_NAME { get; set; }
        public string PAYER { get; set; }
        public string PAYEE { get; set; }
        public string CURRENCY { get; set; }
        public int? KV { get; set; }
        public int? DIG { get; set; }
        public decimal? AMOUNT { get; set; }
        public long? ACCD { get; set; }
        public long? ACCK { get; set; }
        public string IO_IND { get; set; }
        public DateTime? DATE_IN { get; set; }
        public DateTime? DATE_OUT { get; set; }
        public DateTime? DATE_REC { get; set; }
        public DateTime? DATE_PAY { get; set; }
        public DateTime? VDATE { get; set; }
        public int? ID { get; set; }
        public string FIO { get; set; }
        public string TRANSIT { get; set; }
        public string TAG20 { get; set; }

        public string NLSA { get; set; }
        public string NLSB { get; set; }

        public int? IS_PDE { get; set; }
    }

}