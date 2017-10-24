using System;

namespace BarsWeb.Areas.Sep.Models
{
    /// <summary>
    /// Документы внутренние и начальные межбанковские.
    /// Модель для результирующего набора отображаемых данных.
    /// </summary>
    public class SepInternInitModel
    {
        public string MFOA { get; set; }
        public string MFOB { get; set; }
        public string NLSA { get; set; }
        public string NLSB { get; set; }

        public int? S { get; set; }
        public int? KV { get; set; }
        public int? DIG { get; set; }
        public string LCV { get; set; }
        public int? S2 { get; set; }

        public int? KV2 { get; set; }

        public string LCV2 { get; set; }
        public int? DIG2 { get; set; }

        public int? SK { get; set; }
        public int? DK { get; set; }
        public int? VOB { get; set; }
        public DateTime? DATD { get; set; }
        public DateTime? VDAT { get; set; }
        public string TT { get; set; }

        public int? ID { get; set; }

        public int? REF { get; set; }

        public int? SOS { get; set; }

        public int? USERID { get; set; }

        public string ND { get; set; }

        public string NAZN { get; set; }

        public string ID_A { get; set; }

        public string NAM_A { get; set; }

        public string ID_B { get; set; }

        public string NAM_B { get; set; }

        public string TOBO { get; set; }

    }
}