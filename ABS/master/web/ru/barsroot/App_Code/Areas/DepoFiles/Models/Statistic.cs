using System;

namespace BarsWeb.Areas.DepoFiles.Models
{
    public class Statistic
    {
        public Decimal paid_count { get; set; }
        public Decimal paid_sum { get; set; }
        public Decimal topay_count { get; set; }
        public Decimal topay_sum { get; set; }
        public Decimal our_count { get; set; }
        public Decimal our_sum { get; set; }
        public Decimal ex_count { get; set; }
        public Decimal ex_sum { get; set; }

    }
}