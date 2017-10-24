using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Account
/// </summary>
namespace BarsWeb.Areas.CreditUi.Models
{
    public class Account
    {
        public decimal? ORD { get; set; }
        public decimal? ND { get; set; }
        public decimal? RNK { get; set; }
        public decimal? OPN { get; set; }
        public decimal? ACC { get; set; }
        public string TIP { get; set; }
        public string OB22 { get; set; }
        public string NMS { get; set; }
        public int? KV { get; set; }
        public decimal? OSTC { get; set; }
        public decimal? OSTB { get; set; }
        public decimal? OSTF { get; set; }
        public decimal? DOS { get; set; }
        public decimal? KOS { get; set; }
        public string DAPP { get; set; }
        public string DAOS { get; set; }
        public string DAZS { get; set; }
        public string MDATE { get; set; }
        public decimal? ISP { get; set; }
        public string IR { get; set; }
        public decimal? BASEY { get; set; }
        public string TT_NAME { get; set; }
        public string TT_HREF { get; set; }
        public string NLS { get; set; }
    }
}