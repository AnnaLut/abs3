using System;

namespace Areas.GDA.Models
{
    public class TimeTranshes
    {
        public decimal process_id { get; set; }
        public decimal tranche_id { get; set; }
        public DateTime start_date { get; set;}
        public decimal plan_value { get; set; }
        public string currency { get; set; }
        public decimal is_prolongation { get; set; }
        public string state_name { get; set; }
        public decimal is_replenishment_tranche { get; set; }
        public string  deal_number { get; set; }
        public string frequency_payment_name { get; set; }
        public string comment_text { get; set; }
        public string tranche_state_name { get; set; }
        //public string frequency_payment { get; set; }
    }
}


