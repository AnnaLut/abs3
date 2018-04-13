using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models
{
    public class CashBranchViolation
    {
        [Display(Name = "Колір")]
        public String Colour { get; set; }
        [Display(Name = "МФО")]
        public String Mfo { get; set; }
        [Display(Name = "Назва РУ")]
        public String RuName { get; set; }
        [Display(Name = "Відділення")]
        public String Branch { get; set; }
        [Display(Name = "Тип ліміту")]
        public String LimitType { get { return "BRANCH"; } }

        [Display(Name = "Валюта")]
        public Decimal? Currency { get; set; }
        [Display(Name = "Кількість рахунків")]
        public Decimal? AccCount { get; set; }
        [Display(Name = "Поточний ліміт")]
        public Decimal? LimitCurrent { get; set; }

        [Display(Name = "Максимальний ліміт")]
        public Decimal? LimitMax { get; set; }
        
        [Display(Name = "Баланс рахунку")]
        public Decimal? Balance { get; set; }
        [Display(Name = "Сума поруш. макс ліміту")]
        public Decimal? OverLimit { get; set; }

        [Display(Name = "% поруш. макс. ліміту")]
        public string PrcOverLim{ get; set; }

        [Display(Name = "К-ть днів поруш. макс. ліміту")]
        public Decimal? DaysCountViolation { get; set; }


        [Display(Name = "Допустимий % поруш. макс. ліміту")]
        public Decimal? PercentDev { get; set; }

        [Display(Name = "Допустима к-ть днів поруш. макс. ліміту")]
        public Decimal? DaysViol { get; set; }

        [Display(Name = "Ліміт порушений")]
        public String LimitViolationText { get; set; }
    }
}
