using System;
using System.ComponentModel.DataAnnotations;

namespace Areas.Cash.Models
{


    [MetadataType(typeof(V_CLIM_CASHVIOL_GRPMFOKV_MD))]
    public partial class V_CLIM_CASHVIOL_GRPMFOKV
    {
        public string ROW_ID = Guid.NewGuid().ToString();
        [Display(Name = "Тип ліміту")]
        public String LIM_TYPE = "CASH";
    }

    public class V_CLIM_CASHVIOL_GRPMFOKV_MD
    {
        [Display(Name = "МФО")]
        public String KF { get; set; }

        [Display(Name = "Назва РУ")]
        public String RU_NAME { get; set; }

        [Display(Name = "Тип ліміту")]
        public String LIM_TYPE { get { return "CASH"; } }
               
        [Display(Name = "Валюта")]
        public Decimal? ACC_CURRENCY { get; set; }

        [Display(Name = "Поточний ліміт")]
        public Decimal? SUM_LIM { get; set; }

        [Display(Name = "Максимальний ліміт")]
        public Decimal? SUM_LIMMAX { get; set; }

        [Display(Name = "Баланс")]
        public Decimal? SUM_BAL { get; set; }

        [Display(Name = "Сума поруш. макс. ліміту")]
        public Decimal? SUM_OVERLIM { get; set; }

        [Display(Name = "% поруш. макс. ліміту")]
        public string PRC_OVER_LIM { get; set; }

        [Display(Name = "Кількість рахунків")]
        public Decimal? CNT_ACCS { get; set; }
    }
}