using System;

namespace Areas.AccessToAccounts.Models
{
    public class TheGroup
    {
        public decimal ID { get; set; }
        public string FIO { get; set; }
        public decimal SECG { get; set; }

        public string MARK { get; set; }

        public decimal canView { get; set; }
        public decimal canDebit { get; set; }
        public decimal canCredit { get; set; }
    }
}