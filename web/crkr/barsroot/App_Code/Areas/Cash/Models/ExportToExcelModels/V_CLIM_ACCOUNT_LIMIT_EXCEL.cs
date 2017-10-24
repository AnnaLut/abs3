using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models.ExportToExcelModels
{

    public class V_CLIM_ACCOUNT_LIMIT_EXCEL
    {
        [StringLength(6, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "МФО")]
        public String KF { get; set; }
        [Display(Name = "Назва РУ")]
        public String RU_NAME { get; set; }

        [StringLength(30, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Відділення")]
        public String ACC_BRANCH { get; set; }

        [StringLength(10, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Тип ліміту")]
        public String LIM_TYPE { get; set; }

        [StringLength(15, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Рахукнок")]
        public String ACC_NUMBER { get; set; }
        
        [StringLength(70, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Назва рахунку")]
        public String ACC_NAME { get; set; }
        [Display(Name = "Валюта")]
        public Decimal? ACC_CURRENCY { get; set; }


        [Display(Name = "Поточний ліміт")]
        public Decimal? LIM_CURRENT { get; set; }

        [Display(Name = "Максимальний ліміт")]
        public Decimal? LIM_MAX { get; set; }

        [Display(Name = "Баланс")]
        public Decimal? ACC_BAL { get; set; }


        [Display(Name = "Сума поруш. макс. ліміту")]
        public Decimal? OVER_LIM { get; set; }

        [Display(Name = "% поруш. макс. ліміту")]
        public string PRC_OVERLIM { get; set; }




        [StringLength(16, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Тип рахунку")]
        public String ACC_CASHTYPE { get; set; }

        [StringLength(30, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Назва типу рахунку")]
        public String NAME_CASHTYPE { get; set; }

        [Display(Name = "Дата закриття рахунку")]
        public DateTime? ACC_CLOSE_DATE { get; set; }

        [Display(Name = "Ліміт порушений")]
        public string LIMIT_VIOLATION_NAME { get; set; }

    }

}