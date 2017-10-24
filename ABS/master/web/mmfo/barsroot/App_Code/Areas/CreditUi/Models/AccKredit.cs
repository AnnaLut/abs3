using System;
using System.Linq;
using System.Collections.Generic;

namespace BarsWeb.Areas.CreditUi.Models
{
    public class AccKredit
    {
        public decimal ACC { get; set; }
        public string TIP { get; set; }
        public decimal KV { get; set; }
        public string NLS { get; set; }
        public string NMS { get; set; }
        public decimal OSTB { get; set; }
        public decimal OSTC { get; set; }
        public DateTime? DPLAN { get; set; }
        public DateTime? FDAT { get; set; }
        public decimal? NPP { get; set; }
        public string NAZN { get; set; }
    }
}