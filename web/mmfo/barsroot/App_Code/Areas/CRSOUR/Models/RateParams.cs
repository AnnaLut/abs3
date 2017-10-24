using System;
using System.Linq;
using System.Collections.Generic;

namespace Areas.CRSOUR.Models
{
    public class RateParams
    {
        public decimal productId { get; set; }
        public DateTime openDate { get; set; }
        public DateTime expiryDate { get; set; }
        public decimal dealAmount { get; set; }
        public decimal currencyId { get; set; }
        public decimal interestRate { get; set; }
        public decimal interestBase { get; set; }
    }
}