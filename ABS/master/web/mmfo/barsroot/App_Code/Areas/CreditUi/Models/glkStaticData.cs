using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for glkStaticData
/// </summary>
namespace BarsWeb.Areas.CreditUi.Models
{
    public class glkStaticData
    {
        public string CC_ID { get; set; }
        public string SDATE { get; set; }
        public decimal SDOG { get; set; }
        public decimal LIMIT { get; set; }
        public string NMK { get; set; }
        public string BANKDATE{ get; set; }
        public decimal RNK { get; set; }
        public int SOS { get; set; }
        public int CUSTYPE { get; set; }

    }
}