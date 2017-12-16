using System;

namespace Areas.Way4Bpk.Models
{
    public class SubProduct
    {
        public string SUBPRODUCT_CODE { get; set; }
        public string NAME { get; set; }
        public string CODE { get; set; }
    }

    public class SubProductChange
    {
        public long ND { get; set; }
        public string CODE { get; set; }
    }
}
