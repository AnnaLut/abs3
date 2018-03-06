using System;

namespace BarsWeb.Areas.Zay.Models
{
    public class DILER_KURS
    {
        public string type { get; set; }
        public DateTime? dat { get; set; }
        public decimal? kv { get; set; }
        public decimal? id { get; set; }
        public decimal? kurs_b { get; set; }
        public decimal? kurs_s { get; set; }
        public decimal? vip_b { get; set; }
        public decimal? vip_s { get; set; }
        public string fio { get; set; }
        public string name { get; set; }
        public decimal? blk { get; set; }
    }
}