using System;

namespace Areas.GDA.Models
{
    public class Tranches
    {
        public ulong Number { get; set; }
        public bool ReplenishmentTranche { get; set; }
        public DateTime DateKontr { get; set; }
        public DateTime DateReturn { get; set; }        
        public decimal SumValue { get; set; }

        public int State { get; set; }
        public int OperatorId { get; set; }
        public string OperatorName { get; set; }
        public int ControllerId { get; set; }
        public string ControllerName { get; set; }
        public DateTime OperatorDate { get; set; }
        public DateTime ControllerDate { get; set; }
    }
}


