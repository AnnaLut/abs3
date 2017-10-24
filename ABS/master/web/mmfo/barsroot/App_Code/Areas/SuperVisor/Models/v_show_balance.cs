using System;

namespace BarsWeb.Areas.SuperVisor.Models
{
    public class v_show_balance
    {
        public DateTime? show_date { get; set; }
        public string kf { get; set; }
        public string kf_name { get; set; }
        public string nbs { get; set; }
        public string kv { get; set; }
        public decimal? dos { get; set; }
        public decimal? dosq { get; set; }
        public decimal? kos { get; set; }
        public decimal? kosq { get; set; }
        public decimal? ostd { get; set; }
        public decimal? ostdq { get; set; }
        public decimal? ostk { get; set; }
        public decimal? ostkq { get; set; }
        public decimal? row_type { get; set; }
    }
}