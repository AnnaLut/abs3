using System;

namespace BarsWeb.Areas.FinView.Models
{
    public class Account
    {
        public string KF { get; set; }
        public decimal ACC { get; set; }
        public string NLS { get; set; }
        public decimal KV { get; set; }
        public decimal OSTC { get; set; }
        public decimal DOS { get; set; }
        public decimal KOS { get; set; }
        public string NMS { get; set; }
        public DateTime? DAZS { get; set; }
        public string BRANCH { get; set; }
    }
}