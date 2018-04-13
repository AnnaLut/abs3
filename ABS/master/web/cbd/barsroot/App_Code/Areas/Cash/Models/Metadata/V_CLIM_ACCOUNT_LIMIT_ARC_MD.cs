using System;
using System.ComponentModel.DataAnnotations;

namespace Areas.Cash.Models
{


    [MetadataType(typeof (V_CLIM_ACCOUNT_LIMIT_ARC_MD))]
    public partial class V_CLIM_ACCOUNT_LIMIT_ARC
    {
    }

    public class V_CLIM_ACCOUNT_LIMIT_ARC_MD
    {
        [StringLength(6, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "МФО")]
        public String KF { get; set; }
        [Display(Name = "Назва РУ")]
        public String KF_NAME { get; set; }
        [Display(Name = "Відділення")]
        public string ACC_BRANCH{ get; set; }
        [Display(Name = "Рахукнок")]
        public String ACC_NUMBER { get; set; }

        [StringLength(70, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Назва рахунку")]
        public String ACC_NAME { get; set; }
        [Display(Name = "Валюта")]
        public Decimal? ACC_CURRENCY { get; set; }
        [Display(Name = "Дата")]
        public DateTime? LDAT{ get; set; }
        [Display(Name = "Поточний ліміт")]
        public Decimal? LIM_CURRENT_SHARE { get; set; }

        [Display(Name = "Максимальний ліміт")]
        public Decimal? LIM_MAX_SHARE { get; set; }

        [Display(Name = "Баланс")]
        public Decimal? ACC_BAL_SHARE { get; set; }
        [Display(Name = "Сума поруш. макс. ліміту")]
        public Decimal? SUM_OVERTRESHOLD_SHARE { get; set; }
        [Display(Name = "% поруш. макс. ліміту")]
        public string PRC_OVERLIM { get; set; }

        [Display(Name = "Ліміт порушений")]
        public string NAME_VIOLATION { get; set; }
        [Display(Name = "Кількість днів")]
        public Decimal? DIFF_DAYS { get; set; }
    }
}