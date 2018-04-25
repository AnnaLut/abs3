using System;

namespace BarsWeb.Areas.Dpa.Models
{
    public class F0Arc
    {
        public string FN { get; set; }
        public DateTime? D_f0 { get; set; } //previously DAT
        public DateTime? D_f1 { get; set; }
        public DateTime? D_f2 { get; set; }
        public DateTime? D_r0 { get; set; }
        public string ERR { get; set; }
        public string ERR_MSG { get; set; }
    }
}
