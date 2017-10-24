using System;
using System.Data;

namespace BarsWeb.Areas.Sep.Models 
{
    public class ProccessingParams
    {
        public decimal? acc { get; set; }
        public string tip { get; set; }
        public decimal kv { get; set; }
        public decimal? ACCCOUNT { get; set; }
        public decimal BLKD { get; set; }
        public decimal BLKK { get; set; }
        public string DAOS { get; set; } // was DateTime
        public string DAPP { get; set; } // was DateTime
        public string DAZS { get; set; } // was DateTime
        public decimal DIG { get; set; }
        public decimal? DOSF { get; set; }
        public string FIO { get; set; }
        public decimal? ISF { get; set; }
        public decimal? ISP { get; set; }
        public decimal? KOSF { get; set; }
        public string LCV { get; set; }
        public string NBS { get; set; }
        public string NLS { get; set; }
        public string NLSALT { get; set; }
        public string NMS { get; set; }
        public string OB22 { get; set; }
        public decimal? OSTBF { get; set; }
        public decimal? OSTCF { get; set; }
        public decimal? OSTFF { get; set; }
        public decimal? PAP { get; set; }
        public decimal RNK { get; set; }
        public string TOBO { get; set; }
    }
}