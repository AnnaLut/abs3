using System;

namespace BarsWeb.Areas.Dpa.Models
{
    public class CVFile
    {
        public string IDROW { get; set; }
        public string NLS { get; set; }
        public decimal VID { get; set; }
        public decimal OPLDOC_REF { get; set; }
        public DateTime? FDAT { get; set; }
        public string MFO_D { get; set; }
        public string NLS_D { get; set; }
        public string MFO_K { get; set; }
        public string NLS_K { get; set; }
        public int DK { get; set; }
        public decimal? S { get; set; }
        public decimal? VOB { get; set; }
        public string ND { get; set; }
        public int KV { get; set; }
        public DateTime? DATD { get; set; }
        public DateTime? DATP { get; set; }
        public string NAM_A { get; set; }
        public string NAM_B { get; set; }
        public string NAZN { get; set; }
        public string D_REC { get; set; }
        public string NAZNK { get; set; }
        public string NAZNS { get; set; }
        public string ID_D { get; set; }
        public string ID_K { get; set; }
        public string REF { get; set; }
        public DateTime? DAT_A { get; set; }
        public DateTime? DAT_B { get; set; }
    }
}