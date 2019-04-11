using System;
using System.Xml.Serialization;

namespace Areas.GDA.Models
{
    public class SMBDepositOnDemand
    {

        
        public string CurrencyId { get; set; }

        
        public string CustomerId { get; set; }

        [XmlElement(DataType = "date")]
        public DateTime? StartDate { get; set; }

        [XmlElement(DataType = "date")]
        public DateTime? ExpiryDate { get; set; }

        
        public string AmountDeposit { get; set; }

        
        public string InterestRate { get; set; }

        
        public string FrequencyPayment { get; set; }

        
        public string IsIndividualRate { get; set; }
        
        
        public string IndividualInterestRate { get; set; }

        
        public string CalculationType { get; set; }

        
        public string Comment { get; set; }

        
        public string PrimaryAccount { get; set; }

        
        public string DebitAccount { get; set; }

        
        public string ReturnAccount { get; set; }

        
        public string InterestAccount { get; set; }

        
        public string Branch { get; set; }

        
        public string ObjectId { get; set; }

        
        public string ProcessId { get; set; }

        public string TransferDayRegistration { get; set; }

        public string RegisterHistoryId { get; set; }

        
        public string DealNumber { get; set; }

        [XmlElement(DataType = "date")]
        public DateTime? ActionDate { get; set; }

        
        public string AdditionalComment { get; set; }

        
        public string Ref_ { get; set; }

        
        public string IsNotEnoughMoney { get; set; }

        
        public string LastProcessTypeId { get; set; }

        public string CAN_SAVE { get; set; }

        public string IsSigned { get; set; }
    }
}