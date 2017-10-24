using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Areas.Cash.Models
{

    [MetadataType(typeof(V_CLIM_VIOLATIONS_TRESHOLD_MD))]
    public partial class V_CLIM_VIOLATIONS_TRESHOLD 
    {
        public class V_CLIM_VIOLATIONS_TRESHOLD_MD
        {
            [Display(Name = "")]
            public Decimal? DIFF_DAYS { get; set; }

            [Display(Name = "")]
            public Decimal? ACC_BAL_OVER { get; set; }

            [StringLength(10, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "")]
            public String ACC_PERC_OVER { get; set; }

            [Required]
            [Display(Name = "")]
            public Decimal? ACC_ID { get; set; }

            [Required]
            [StringLength(30, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "")]
            public String ACC_BRANCH { get; set; }

            [Required]
            [StringLength(6, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "")]
            public String KF { get; set; }

            [Required]
            [StringLength(15, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "")]
            public String ACC_NUMBER { get; set; }

            [StringLength(70, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "")]
            public String ACC_NAME { get; set; }

            [Required]
            [Display(Name = "")]
            public Decimal? ACC_CURRENCY { get; set; }

            [Display(Name = "")]
            public Decimal? ACC_BALANCE { get; set; }

            [Display(Name = "")]
            public Decimal? ACC_BAL { get; set; }

            [Required]
            [Display(Name = "")]
            public DateTime? DAT_BEGIN { get; set; }

            [Required]
            [Display(Name = "")]
            public Decimal? LIM_BALANCE { get; set; }

            [Required]
            [Display(Name = "")]
            public Decimal? LIM_CURRENT { get; set; }

            [Display(Name = "")]
            public Decimal? LIM_MAX { get; set; }

            [Display(Name = "")]
            public Decimal? TR_PERC { get; set; }

            [Display(Name = "")]
            public Decimal? TR_DAYS { get; set; }

            [StringLength(4000, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "")]
            public String TR_COLOUR { get; set; }

            [Display(Name = "")]
            public DateTime? CUR_BD { get; set; }

            [Required]
            [StringLength(16, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "")]
            public String ACC_CASHTYPE { get; set; }

            [Required]
            [StringLength(30, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "")]
            public String NAME_CASHTYPE { get; set; }

            [StringLength(10, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "")]
            public String LIM_TYPE { get; set; }

            [Required]
            [StringLength(10, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "")]
            public String CHECK_FLAG { get; set; }

            [Display(Name = "")]
            public DateTime? ACC_CLOSE_DATE { get; set; }


        }
    }


}