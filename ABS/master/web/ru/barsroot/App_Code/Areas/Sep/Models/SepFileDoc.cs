using System;

namespace BarsWeb.Areas.Sep.Models
{
    public class SepFileDoc
    {
        public string MFOA { get; set; }
        public string MFOB { get; set; }
        public string NLSA { get; set; }
        public string NLSB { get; set; }
        public decimal? S { get; set; }
        public int? KV { get; set; }
        public string LCV{ get; set; }
        public decimal DIG { get; set; }
        public int? DK { get; set; }
        public int? VOB { get; set; }
        public DateTime? DATP { get; set; }
        public decimal? REC { get; set; }
        public string FN_A { get; set; }
        public DateTime? DAT_A { get; set; }
        public decimal? REC_A { get; set; }
        public string FN_B { get; set; }
        public DateTime? DAT_B { get; set; }
        public decimal? REC_B { get; set; }
        public decimal? REF { get; set; } 
        public int? SOS { get; set; }
        public string ND { get; set; }
        public string NAZN { get; set; }
        public string NAMA { get; set; }
        public string NBA { get; set; }
        public string NAMB { get; set; }
        public string NBB { get; set; }
        public string ID_A { get; set; }
        public string ID_B { get; set; }
        public DateTime? DATK { get; set; }
        public DateTime? DAT_2 { get; set; }
    }
}