using System;
using System.Collections.Generic;

namespace Areas.GDA.Models
{
    public class DepositOnDemandType : Option
    {
        public string Id_ { get; set; }
        public string CalculationTypeId { get; set; }
    }
}