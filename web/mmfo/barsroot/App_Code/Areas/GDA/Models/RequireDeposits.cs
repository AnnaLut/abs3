using System;

namespace Areas.GDA.Models
{
    public class RequireDeposits
    {
        public decimal? PROCESS_ID { get; set; }
        public decimal? DEPOSIT_ID { get; set; }
        public string DEPOSIT_STATE_NAME { get; set; }
        public string DEPOSIT_STATE_CODE { get; set; }
        public string STATE_NAME { get; set; }
        public string DEAL_NUMBER { get; set; }
        public DateTime START_DATE { get; set;}
        public string Currency { get; set; }
        public decimal? PLAN_VALUE { get; set; }
        public  string CALCULATION_TYPE_NAME { get; set; }

    }
}


