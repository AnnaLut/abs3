using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ExistProvide
/// </summary>
/// 
namespace BarsWeb.Areas.CreditUi.Models
{
    public class ExistProvide
    {
        public decimal RNK { get; set; }

        public int PAWN { get; set; }

        public string NLS { get; set; }
        public decimal ACC { get; set; }

        public int KV { get; set; }

        public string OB22 { get; set; }

        public decimal OSTB { get; set; }

        public decimal OSTC { get; set; }

        public string CC_IDZ { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? SDATZ { get; set; }      

        public int? MPAWN { get; set; }

        public int? DEL { get; set; }

        public decimal? DEPID { get; set; }

        public int? PR_12 { get; set; }

        public string NREE { get; set; }

        public decimal? SV { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? MDATE { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? DAZS { get; set; }

        public string NAZN { get; set; }

        public string NMK { get; set; }

        public string R013 { get; set; }

        public string NAME { get; set; }


    }
}