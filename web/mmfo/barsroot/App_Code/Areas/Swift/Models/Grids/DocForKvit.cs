using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Areas.Swift.Models
{
    public class DocForKvit
    {
        public decimal REF { get; set; }
        public DateTime? VDAT { get; set; }
        public string NLSA { get; set; }
        public string NLSB { get; set; }
        public decimal? AMOUNT { get; set; }
        public string LCV { get; set; }
        public int DIG { get; set; }
        public int? DK { get; set; }
        public string NAZN { get; set; }
        //public int? ACCD { get; set; }
        //public int? ACCK { get; set; }
        //public int? S { get; set; }
        //public DateTime? FDAT { get; set; }
        public string TAG20 { get; set; }
        public string TT { get; set; }
        public string NEXTVISAGRP { get; set; }
    }
}