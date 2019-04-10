using System;

namespace Areas.GDA.Models
{
    public class BackOffInfo
    {
        public int  rnk { get; set; }
        public int contract_number { get; set; }
        public int mfo { get; set; }
        public string typeOperation { get; set; }
        public DateTime dateOperation { get; set; }
        public string numCurrency { get; set; }
        public string statusOperation { get; set; }
        public string nameUser { get; set; }
    }
}

