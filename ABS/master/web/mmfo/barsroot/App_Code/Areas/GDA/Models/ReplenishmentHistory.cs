using System;

namespace Areas.GDA.Models
{
    public class ReplenishmentHistory
    {
        public string deal_number { get; set; }
        public DateTime start_date { get; set; }
        public decimal  amount { get; set; }
        public DateTime value_date { get; set; }
        public string  replenish_state_name { get; set; }
        public string type_ { get; set; }
        public decimal process_id { get; set; }

        public string reason { get; set; }
    }
}
