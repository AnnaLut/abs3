using System;

namespace Areas.GDA.Models
{
    public class ReplacementTranche
    {
        public string ProcessId { get; set; }
        public string ObjectId { get; set; }
        public string CurrencyId { get; set; }
        public string CustomerId { get; set; }
        public string StartDate { get; set; }
        public string ExpiryDate { get; set; }
        public string NumberTrancheDays { get; set; }
        public string AmountTranche { get; set; }
        public string InterestRate { get; set; }
        public string IsProlongation { get; set; }
        public string NumberProlongation { get; set; }
        public string InterestRateProlongation { get; set; }
        public string IsReplenishmentTranche { get; set; }
        public string MaxSumTranche { get; set; }
        public string MinReplenishmentAmount { get; set; }
        public string LastReplenishmentDate { get; set; }
        public string FrequencyPayment { get; set; }
        public string IsIndividualRate { get; set; }
        public string IndividualInterestRate { get; set; }
        public string IsCapitalization { get; set; }
        public string Comment { get; set; }
        public string PrimaryAccount { get; set; }
        public string DebitAccount { get; set; }
        public string ReturnAccount { get; set; }
        public string InterestAccount { get; set; }
        public string Branch { get; set; }
    }
}
