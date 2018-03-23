using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RefList
/// </summary>
/// 
namespace BarsWeb.Areas.Escr.Models
{
    public class EscrRefList
    {
        public string TT { get; set; }
        public decimal? REF { get; set; }
        public string NLSB { get; set; }
        public decimal? OSTC { get; set; }
        public string NAZN { get; set; }
        public decimal? S { get; set; }
        public decimal ACC { get; set; }
        public string ND { get; set; }
        public string SDATE { get; set; }
        public string CC_ID { get; set; }
        public string ID_B { get; set; }
        public string TXT { get; set; }
        public bool DATE_CHECK { get; set; }
    }
}