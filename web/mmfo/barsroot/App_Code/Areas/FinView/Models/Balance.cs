using System;

namespace BarsWeb.Areas.FinView.Models
{
    /// <summary>
    /// Based on TMP_SHOW_BALANCE_DATA
    /// </summary>
    public class Balance
    {
        public DateTime show_date { get; set; }
        public string kf { get; set; }
        public decimal row_type { get; set; }
        public string branch { get; set; }
        public string nbs { get; set; }
        public decimal? kv { get; set; }
        public decimal? dos { get; set; }
        public decimal? dosq { get; set; }
        public decimal? kos { get; set; }
        public decimal? kosq { get; set; }
        public decimal? ostd { get; set; }
        public decimal? ostdq { get; set; }
        public decimal? ostk { get; set; }
        public decimal? ostkq { get; set; }
        public string kf_name { get; set; }
    }
}