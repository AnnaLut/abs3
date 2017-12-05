using System;

namespace BarsWeb.Areas.Dpa.Models
{
    public class F0Grid
    {
        public string MFO { get; set; }
        public string OKPO { get; set; }
        public decimal? RTYPE { get; set; }
        public decimal? OTYPE { get; set; }
        public DateTime ODATE { get; set; }
        public string NLS { get; set; }
        public decimal? KV { get; set; }
        public string NMKK { get; set; }
        public string ADR { get; set; }
        public decimal? RESID { get; set; }
        public decimal? C_REG { get; set; }
        public decimal? ID_DPS { get; set; }
        public decimal? C_DST { get; set; }
        public string KOD_REG { get; set; }
        public decimal? REC_O { get; set; }
        public string ERR { get; set; }
    }
}