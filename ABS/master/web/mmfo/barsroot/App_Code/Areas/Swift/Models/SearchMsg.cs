using System;

namespace Areas.Swift.Models
{
    public class SearchMsg
    {
        public long swref { get; set; }
        public string io_ind { get; set; }
        public int mt { get; set; }
        public string trn { get; set; }
        public string sender { get; set; }
        public string receiver { get; set; }
        public string currency { get; set; }
        public decimal amount { get; set; }
        public DateTime? date_rec { get; set; }
        public DateTime? date_pay { get; set; }
        public DateTime vdate { get; set; }
        public long? @ref { get; set; }
}
}
