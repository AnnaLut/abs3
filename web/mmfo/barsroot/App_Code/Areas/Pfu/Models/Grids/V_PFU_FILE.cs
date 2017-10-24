using System;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    /// <summary>
    /// Summary description for PFU.V_PFU_FILE
    /// </summary>
    public class V_PFU_FILE
    {
        public decimal id { get; set; }
        public decimal pfu_envelope_id { get; set; } //id конверту в ПФУ
        public string file_name { get; set; }
        public DateTime? payment_date { get; set; }
        public decimal? file_number { get; set; }
        public decimal? file_sum { get; set; }
        public decimal? file_lines_count { get; set; }
        public decimal? main_request_id { get; set; }
        public DateTime? crt_date { get; set; }
    }
}