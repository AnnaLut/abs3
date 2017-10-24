using System;

namespace BarsWeb.Areas.Dpa.Models
{
    public class KFile
    {
        public string IDROW { get; set; }
        public string MFO { get; set; }
        public string NMK { get; set; }
        public string OT { get; set; }
        public DateTime ODAT { get; set; }
        public string NLS { get; set; }
        public decimal? KV { get; set; }
        public decimal? C_AG { get; set; }
        public decimal? COUNTRY { get; set; }
        public string C_REG { get; set; }
        public string OKPO { get; set; }
    }
}