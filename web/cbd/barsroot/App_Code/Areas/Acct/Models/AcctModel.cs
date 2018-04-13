using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Acct.Models
{
    public class V_ACC_TARIF1
    {
        [Display(Name = "")]
        public Decimal? ACC { get; set; }

        [Display(Name = "")]
        public Decimal? TYPE { get; set; }

        [Display(Name = "")]
        public Decimal? KOD { get; set; }

        [Display(Name = "")]
        public Decimal? TAR { get; set; }

        [Display(Name = "")]
        public Decimal? PR { get; set; }

        [Display(Name = "")]
        public Decimal? SMIN { get; set; }

        [Display(Name = "")]
        public Decimal? SMAX { get; set; }

        [Display(Name = "")]
        public DateTime? BDATE { get; set; }

        [Display(Name = "")]
        public DateTime? EDATE { get; set; }
    }
}

