using System;

namespace BarsWeb.Areas.Zay.Models
{
    public class DILER_KURS_CONV
    {
        public DateTime dat { get; set; }
        public decimal kv1 { get; set; }
        public decimal kv2 { get; set; }
        public decimal? kurs_i { get; set; }
        public decimal? kurs_f { get; set; }
    }
}