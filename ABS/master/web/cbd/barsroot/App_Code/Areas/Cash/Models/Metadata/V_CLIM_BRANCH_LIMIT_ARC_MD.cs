using System;
using System.ComponentModel.DataAnnotations;

namespace Areas.Cash.Models
{


    [MetadataType(typeof (V_CLIM_BRANCH_LIMIT_ARC_MD))]
    public partial class V_CLIM_BRANCH_LIMIT_ARC
    {
    }

    public class V_CLIM_BRANCH_LIMIT_ARC_MD
    {
        [Display(Name = "МФО")]
        public string KF { get; set; }
        [Display(Name = "Відділення")]
        public string ACC_BRANCH{ get; set; }
        [Display(Name = "Валюта")]
        public decimal? ACC_CURRENCY{ get; set; }
        [Display(Name = "Дата")]
        public DateTime? LDAT{ get; set; }

/*LIM_STARTDATE,
PERCENT_DEV,
DAYS_VIOL,
UPD_DATE,
TRESHOLD_VIOLATION,
SUM_OVERTRESHOLD,
PRC_OVERLIM,*/
        [Display(Name = "Баланс")]
        public decimal? SUM_BAL_SHARE{ get; set; }
        [Display(Name = "Поточний ліміт")]
        public decimal? SUM_LIM_SHARE { get; set; }
        [Display(Name = "Максимальний ліміт")]
        public decimal? SUM_LIMMAX_SHARE { get; set; }
        [Display(Name = "Сума поруш. макс. ліміту")]
        public decimal? SUM_OVERTRESHOLD_SHARE { get; set; }
		[Display(Name = "% поруш. макс. ліміту")]
        public string PRC_OVERLIM { get; set; }
        [Display(Name = "Кількість днів")]
        public Decimal? DIFF_DAYS { get; set; }
        [Display(Name = "К-ть днів поруш. макс. ліміту понад допустимий % поруш.")]
        public Decimal? DIFF_DAYS_LIM { get; set; }
       [Display(Name = "Допустимий % поруш. макс. ліміту")]
        public Decimal? PERCENT_DEV { get; set; }

        [Display(Name = "Допустима к-ть днів поруш. макс. ліміту")]
        public Decimal? DAYS_VIOL { get; set; }

        [Display(Name = "Ліміт порушений")]
        public string NAME_VIOLATION { get; set; }
    }
}