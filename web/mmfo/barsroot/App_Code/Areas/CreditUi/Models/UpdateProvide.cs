using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for UpdateProvide
/// </summary>
namespace BarsWeb.Areas.CreditUi.Models
{
    public class UpdateProvide
    {
        public decimal RNK { get; set; }

        public int PAWN { get; set; }

        public decimal? ACC { get;set;}

        public int KV { get; set; }

        public string CC_IDZ { get; set; }

        public string SDATZ { get; set; }

        public string MDATE { get; set; }

        public int? MPAWN { get; set; }

        public decimal? DEL { get; set; }

        public decimal? DEPID { get; set; }

        public decimal? SV { get; set; }

        public int? PR_12 { get; set; }

        public string NREE { get; set; }

        public string NAZN { get; set; }
        public string R013 { get; set; }
        public string OB22 { get; set; }
    }
}