using System;
using System.ComponentModel.DataAnnotations;

namespace Areas.Cash.Models
{


    [MetadataType(typeof (V_CLIM_MFOLIM_MD))]
    public partial class V_CLIM_MFOLIM
    {
    }

    public class V_CLIM_MFOLIM_MD
    {
        [Display(Name = "МФО")]
        public string KF { get; set; }
        [Display(Name = "Назва РУ")]
        public String RU_NAME { get; set; }

        [Display(Name = "Тип ліміту")]
        public String LIM_NAME { get; set; }
        
        [Display(Name = "Валюта")]
        public decimal? KV{ get; set; }

        [Display(Name = "Поточний ліміт")]
        public Decimal? LIM_CURRENT { get; set; }

        [Display(Name = "Максимальний ліміт")]
        public Decimal? LIM_MAX { get; set; }

        [Display(Name = "Баланс")]
        public Decimal? SUM_BAL { get; set; }

        [Display(Name = "Сума поруш. макс. ліміту")]
        public Decimal? OVER_LIM { get; set; }

        [Display(Name = "% поруш. макс. ліміту")]
        public string PRC_OVER_LIM { get; set; }

        [Display(Name = "Ліміт порушений")]
        public string LIMIT_VIOLATION_NAME { get; set; }

    }
}