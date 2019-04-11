using System;
using System.Xml.Serialization;

namespace Areas.GDA.Models
{
    public class SMBDepositTranche
    {
        
        public string ProcessId { get; set; }

        
        public string ObjectId { get; set; }

        
        public string CurrencyId { get; set; }

        
        public string CustomerId { get; set; }

        [XmlElement(DataType = "date")]
        public DateTime? StartDate { get; set; }

        [XmlElement(DataType = "date")]
        public DateTime? ExpiryDate { get; set; }

        
        public string NumberTrancheDays { get; set; }

        
        public string AmountTranche { get; set; }

        
        public string InterestRate { get; set; }

        
        public string IsProlongation { get; set; }

        
        public string NumberProlongation { get; set; }

        
        public string InterestRateProlongation { get; set; }

        
        public string IsReplenishmentTranche { get; set; }

        
        public string MaxSumTranche { get; set; }

        
        public string MinReplenishmentAmount { get; set; }

        [XmlElement(DataType = "date")]
        public DateTime? LastReplenishmentDate { get; set; }

        
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

        
        public string RegisterHistoryId { get; set; }

        
        public string ApplyBonusProlongation { get; set; }

        
        public string DealNumber { get; set; }

        
        public string TransitAccount { get; set; }

        [XmlElement(DataType = "date")]
        public DateTime? ActionDate { get; set; }

        
        public string PenaltyRate { get; set; }

        
        public string AdditionalComment { get; set; }

        
        public string Ref_ { get; set; }

        
        public string InterestRateCapitalization { get; set; }

        
        public string InterestRateBonus { get; set; }

        public string CapitalizationTerm { get; set; }

        public string InterestRateProlongationBonus { get; set; }

        public string IsSigned { get; set; }

    }
}