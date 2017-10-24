using System;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFU_ENVELOPES
    {
        public decimal id { get; set; }
        public string name { get; set; }
        public DateTime? date_insert { get; set; }
        public decimal? count_files { get; set; }
        public decimal? sum { get; set; }
        public string state { get; set; }
        public string state_name { get; set; }
    }
}