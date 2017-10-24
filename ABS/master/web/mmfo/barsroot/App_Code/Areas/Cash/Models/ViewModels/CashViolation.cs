using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models
{
    public class CashViolation
    {
        [Display(Name = "Колір")]
        public String Colour { get; set; }
        [Display(Name = "Мфо")]
        public String Mfo { get; set; }
        [Display(Name = "Тип ліміту")]
        public String LimitType { get; set; }

        [Display(Name = "Валюта")]
        public Decimal? Currency { get; set; }

        [Display(Name = "Ліміт поточний")]
        public Decimal? LimitCurrent { get; set; }

        [Display(Name = "Ліміт максимальний")]
        public Decimal? LimitMax { get; set; }

        [Display(Name = "Баланс")]
        public Decimal? Balance { get; set; }
        
        [Display(Name = "Ліміт порушений")]
        public String LimitViolationText { get; set; }

        [Display(Name = "Сума поруш. ліміту")]
        public Decimal? OverLimit { get; set; }

    }
}
