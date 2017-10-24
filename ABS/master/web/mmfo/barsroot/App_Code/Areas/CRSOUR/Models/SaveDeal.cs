using System;
using System.Linq;
using System.Collections.Generic;

namespace Areas.CRSOUR.Models
{
    public class SaveDeal
    {
        public string contractNumber { get; set; }
        public decimal productId { get; set; }
        public decimal partnerId { get; set; }
        public DateTime contractDate { get; set; }
        public DateTime expiryDate { get; set; }
        public decimal amount { get; set; }
        public decimal currencyCode { get; set; }
        public decimal interestRate { get; set; }
        public decimal interestBase { get; set; }
        public string mainAccount { get; set; }
        public string interestAccount { get; set; }
        public string partyMainAccount { get; set; }
        public string partyInterestAccount { get; set; }
    }
}