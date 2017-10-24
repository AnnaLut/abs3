using System;

namespace BarsWeb.Areas.Dpa.Models
{
    public class FileReport
    {
        public string ID_A { get; set; }
        public string RT { get; set; }
        public string OT { get; set; }
        public DateTime ODAT { get; set; }
        public string NLS { get; set; }
        public decimal? KV { get; set; }
        public string C_AG { get; set; }
        public string NMK { get; set; }
        public string ADR { get; set; }
        public decimal? C_REG { get; set; }
        public decimal? C_DST { get; set; }
        public string COD_REG { get; set; }
        public decimal? REC_O { get; set; }
    }
}