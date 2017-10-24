using System;

namespace Areas.dynamicLayout.Models
{
    public class VStaticLayout
    {
        public decimal? ID { get; set; }
        public decimal? DK { get; set; }
        public string NAME { get; set; }
        public string NLS { get; set; }
        public string BS { get; set; }
        public string OB { get; set; }
        public string NAZN { get; set; }
        public DateTime? DATP { get; set; }
        public decimal? ALG { get; set; }
        public decimal? GRP { get; set; }
    }

    public class Currents
    {
        public string BDate { get; set; }
        public string Mfo { get; set; }
    }
}
