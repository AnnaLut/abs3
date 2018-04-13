using System;
using System.ComponentModel.DataAnnotations;

namespace Areas.Cash.Models
{


    [MetadataType(typeof (V_CLIM_MFO_LIMIT_ARC_MD))]
    public partial class V_CLIM_MFO_LIMIT_ARC
    {
    }

    public class V_CLIM_MFO_LIMIT_ARC_MD
    {
        [Display(Name = "МФО")]
        public string KF { get; set; }

        [Display(Name = "Валюта")]
        public decimal? KV{ get; set; }

        [Display(Name = "Дата")]
        public DateTime? LIM_DATE { get; set; }

        [Display(Name = "Баланс")]
        public decimal? SUM_BAL_SHARE{ get; set; }

        [Display(Name = "Поточний ліміт")]
        public decimal? LIM_CURRENT_SHARE { get; set; }
        [Display(Name = "Максимальний ліміт")]
        public decimal? LIM_MAX_SHARE { get; set; }
        /*[Display(Name = "Сума поруш. макс. ліміту")]
        public decimal? SUM_OVERTRESHOLD_SHARE { get; set; }*/
        [Display(Name = "Ліміт порушений")]
        public string NAME_VIOLATION { get; set; }
        [Display(Name = "% поруш. макс. ліміту")]
        public string PRC_OVERLIM { get; set; }
    }
}