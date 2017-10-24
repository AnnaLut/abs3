using System;
using System.ComponentModel.DataAnnotations;

namespace Areas.Cash.Models
{


    [MetadataType(typeof (V_CLIM_ATM_LIMIT_ARC_MD))]
    public partial class V_CLIM_ATM_LIMIT_ARC
    {
    }

    public class V_CLIM_ATM_LIMIT_ARC_MD
    {
        [Display(Name = "МФО")]
        public string KF { get; set; }
        [Display(Name = "Відділення")]
        public string ACC_BRANCH{ get; set; }
        [Display(Name = "Валюта")]
        public decimal? ACC_CURRENCY{ get; set; }

        [Display(Name = "Код банкомату")]
        public string COD_ATM { get; set; }

        [Display(Name = "Дата")]
        public DateTime? FDAT { get; set; }

        [Display(Name = "Сума транзакції")]
        public decimal? S_SHARE{ get; set; }
        [Display(Name = "Ліміт макс. загрузки")]
        public string LIM_MAXLOAD_SHARE { get; set; }

        [Display(Name = "Поточний ліміт")]
        public decimal? OVER_MAXLOAD_SHARE { get; set; }
    }
}