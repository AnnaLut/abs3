using System;

namespace Areas.GDA.Models
{
    public class DboData
    {
        public string contract_number { get; set; }
        public string contract_date { get; set; }
        public string contract_signature_flag { get; set; }
        public int rnk { get; set; }
        public string okpo { get; set; }
        public string nmk { get; set; }
        public string branch { get; set; }
    }
}
