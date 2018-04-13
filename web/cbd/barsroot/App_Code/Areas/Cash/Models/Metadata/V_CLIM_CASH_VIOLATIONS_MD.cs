using System;
using System.ComponentModel.DataAnnotations;

namespace Areas.Cash.Models
{
    [MetadataType(typeof(V_CLIM_CASH_VIOLATION_MD))]
    public partial class V_CLIM_CASH_VIOLATION
    {
        public class V_CLIM_CASH_VIOLATION_MD
        {
            [StringLength(6, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "МФО")]
            public String MFO { get; set; }

            [StringLength(50, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "Назва РУ")]
            public String NAME { get; set; }

            [StringLength(30, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "Відділення")]
            public String ACC_BRANCH { get; set; }

            [StringLength(10, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "Тип ліміту")]
            public String LIM_TYPE { get; set; }

            [StringLength(15, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "Рахунок")]
            public String ACC_NUMBER { get; set; }

            [StringLength(70, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "Назва рахунку")]
            public String ACC_NAME { get; set; }

            [Display(Name = "Валюта")]
            public Decimal? ACC_CURRENCY { get; set; }
            
            [Display(Name = "Поточний ліміт ")]
            public Decimal? LIM_CURRENT { get; set; }

            [Display(Name = "Максимальний ліміт ")]
            public Decimal? LIM_MAX { get; set; }

            [Display(Name = "Баланс рахунку")]
            public Decimal? ACC_BAL { get; set; }

            [Display(Name = "Сума поруш. макс. ліміту")]
            public Decimal? OVER_LIM { get; set; }

            [Display(Name = "% поруш. макс. ліміту")]
            public string PRC_OVERLIM { get; set; }


            [Display(Name = "К-ть днів порушення")]
            public Decimal? DIFF_DAYS { get; set; }

            [Display(Name = "Допустимий % поруш. макс. ліміту")]
            public Decimal? PERCENT_DEV { get; set; }

            [Display(Name = "Допустима к-ть днів поруш. макс. ліміту")]
            public Decimal? DAYS_VIOL { get; set; }








            [Required]
            [Display(Name = "Дата початку порушення")]
            public DateTime? STARTD_VIOL { get; set; }

            [Display(Name = "")]
            public DateTime? MAXD_VIOL { get; set; }



            [StringLength(16, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "Тип рахунку")]
            public String ACC_CASHTYPE { get; set; }

            [StringLength(30, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "Назва типу рахунку")]
            public String NAME_CASHTYPE { get; set; }



            [StringLength(10, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "Флаг")]
            public String CHECK_FLAG { get; set; }

            [Display(Name = "Дата закриття рах.")]
            public DateTime? ACC_CLOSE_DATE { get; set; }

            [Display(Name = "Ліміт порушений")]
            public Decimal? LIMIT_VIOLATION { get; set; }


            [StringLength(20, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
            [Display(Name = "Колір")]
            public String COLOUR { get; set; }

            [Display(Name = "Дата початку поруш.")]
            public DateTime? PERIOD_START { get; set; }

            [Display(Name = "")]
            public Decimal? TRESHOLD_VIOLATION { get; set; }

            [Display(Name = "")]
            public Decimal? SUM_OVERTRESHOLD { get; set; }

            [Display(Name = "Дата")]
            public DateTime? BDATE { get; set; }



            [Display(Name = "Баланс рахунку")]
            public Decimal? ACC_BALANCE { get; set; }
            [Display(Name = "Ід рахунку")]
            public Decimal? ACC_ID { get; set; }
        }
    }
}