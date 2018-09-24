using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AccountStaticData
/// </summary>
namespace BarsWeb.Areas.CreditUi.Models
{
    public class AccountStaticData
    {
        public string CC_ID { get; set; }
        public string SDATE { get; set; }
        public string FIRSTDATE { get; set; }
        public string WDATE { get; set; }
        public decimal ND { get; set; }
        public string NAMK { get; set; }
        public decimal SDOG { get; set; }
        public decimal S { get; set; }
        public decimal DIFF { get; set; }
        public decimal RNK { get; set; }
        public string VNAME { get; set; }
        public decimal OSTB_9129 { get; set; }
        public string Date_issuance { get; set; }
        public int CUSTYPE { get; set; }
        public bool Avalible_provide { get; set; }
        public decimal? NDR { get; set; }
        public byte? SOS { get; set; }

    }
}