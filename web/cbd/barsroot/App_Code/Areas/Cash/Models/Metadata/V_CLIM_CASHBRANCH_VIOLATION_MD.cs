using System;
using System.ComponentModel.DataAnnotations;

namespace Areas.Cash.Models
{


    [MetadataType(typeof(V_CLIM_CASHBRANCH_VIOLATION_MD))]
    public partial class V_CLIM_CASHBRANCH_VIOLATION
    {

    }
    public class V_CLIM_CASHBRANCH_VIOLATION_MD
    {

        [Display(Name = "Колір")]
        public String COLOUR { get; set; }

        [Display(Name = "МФО")]
        public String KF { get; set; }
        [Display(Name = "Назва РУ")]
        public String RU_NAME { get; set; }

        [Display(Name = "Відділення")]
        public String ACC_BRANCH { get; set; }

        [Display(Name = "Валюта")]
        public Decimal? ACC_CURRENCY { get; set; }
        [Display(Name = "Кількість рахунків")]
        public Decimal? ACC_CNT { get; set; }
        [Display(Name = "Поточний ліміт")]
        public Decimal? SUM_LIM { get; set; }

        [Display(Name = "Максимальний ліміт")]
        public Decimal? SUM_LIMMAX { get; set; }

        [Display(Name = "Баланс рахунку")]
        public Decimal? SUM_BAL { get; set; }
        [Display(Name = "Сума поруш. макс ліміту")]
        public Decimal? SUM_OVERTRESHOLD { get; set; }

        [Display(Name = "% поруш. макс. ліміту")]
        public string PRC_OVERLIM { get; set; }

        [Display(Name = "К-ть днів поруш. макс. ліміту")]
        public Decimal? DIFF_DAYS { get; set; }


        [Display(Name = "Допустимий % поруш. макс. ліміту")]
        public Decimal? PERCENT_DEV { get; set; }

        [Display(Name = "Допустима к-ть днів поруш. макс. ліміту")]
        public Decimal? DAYS_VIOL { get; set; }

        [Display(Name = "Банківська дата")]
        public DateTime? BDATE { get; set; }

        [Display(Name = "Допустима к-ть днів поруш. макс. ліміту")]
        public Decimal? TRESHOLD_VIOLATION { get; set; }
        [Display(Name = "Дата початку")]
        public DateTime? PERIOD_START { get; set; }

        public DateTime? STARTD_VIOL { get; set; }

        public DateTime? MAXD_VIOL { get; set; }
    }
}