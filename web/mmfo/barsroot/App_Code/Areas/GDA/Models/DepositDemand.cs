using System;
using System.Xml.Serialization;

namespace Areas.GDA.Models
{
    public class DepositDemand
    {
        [XmlElement(IsNullable = true)]
        public string CurrencyId { get; set; }

        [XmlElement(IsNullable = true)]
        public string CustomerId { get; set; }

        [XmlElement(IsNullable = true)]
        public string StartDate { get; set; }

        [XmlElement(IsNullable = true)]
        public string ExpiryDate { get; set; }

        [XmlElement(IsNullable = true)]
        public string AmountDeposit { get; set; }

        [XmlElement(IsNullable = true)]
        public string InterestRate { get; set; }

        [XmlElement(IsNullable = true)]
        public string FrequencyPayment { get; set; }

        [XmlElement(IsNullable = true)]
        public string IsIndividualRate { get; set; }
        
        [XmlElement(IsNullable = true)]
        public string IndividualInterestRate { get; set; }

        [XmlElement(IsNullable = true)]
        public string CalculationType { get; set; }

        [XmlElement(IsNullable = true)]
        public string Comment { get; set; }

        [XmlElement(IsNullable = true)]
        public string PrimaryAccount { get; set; }

        [XmlElement(IsNullable = true)]
        public string DebitAccount { get; set; }

        [XmlElement(IsNullable = true)]
        public string ReturnAccount { get; set; }

        [XmlElement(IsNullable = true)]
        public string InterestAccount { get; set; }

        [XmlElement(IsNullable = true)]
        public string Branch { get; set; }
        
        [XmlElement(IsNullable = true)]
        public string ObjectId { get; set; }

        [XmlElement(IsNullable = true)]
        public string ProcessId { get; set; }

        [XmlElement(IsNullable = true)]
        public string RegisterHistoryId { get; set; }

        [XmlElement(IsNullable = true)]
        public string DealNumber { get; set; }

        [XmlElement(IsNullable = true)]
        public string ActionDate { get; set; }

        [XmlElement(IsNullable = true)]
        public string AdditionalComment { get; set; }

        [XmlElement(IsNullable = true)]
        public string Ref_ { get; set; }

        [XmlElement(IsNullable = true)]
        public string IsNotEnoughMoney { get; set; }

        [XmlElement(IsNullable = true)]
        public string LastProcessTypeId { get; set; }

    }
}
 