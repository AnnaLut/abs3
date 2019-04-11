using System;

namespace Areas.GDA.Models
{
    public class HistoryOp
    {
        public string operation { get; set; }
        public int numTrache { get; set; }
        public DateTime dateOp { get; set; }
        public string stateOp { get; set; }
        public string userRole { get; set; }
        public string userName { get; set; }
    }
}