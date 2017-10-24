using System;

namespace Areas.BatchOpeningCardAccounts.Models
{
    public class Deal
    {
        public int p_fileid { get; set; }
        public int? p_proect_id { get; set; }
        public string p_card_code { get; set; }
        public string p_branch { get; set; }
        public int p_isp { get; set; }
    }
}
