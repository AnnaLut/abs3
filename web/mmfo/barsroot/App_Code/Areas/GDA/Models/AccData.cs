using System;

namespace Areas.GDA.Models
{
    public class AccData
    {
        public ulong Acc { get; set; }
        public string Kv { get; set; }
        public DateTime DateOpen { get; set; }
        public decimal Balance { get; set; }
    }
}
