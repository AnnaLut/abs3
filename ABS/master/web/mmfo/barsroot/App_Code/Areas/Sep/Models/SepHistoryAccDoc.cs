using System;

namespace BarsWeb.Areas.Sep.Models
{
    public class SepHistoryAccDoc
    {
        public string NN { get; set; }
        public DateTime? FDAT { get; set; }

        public int acc { get; set; }
        public double SV { get; set; }
        public double SVQ { get; set; }
        public double OD { get; set; }
        public double ODQ { get; set; }
    }
}