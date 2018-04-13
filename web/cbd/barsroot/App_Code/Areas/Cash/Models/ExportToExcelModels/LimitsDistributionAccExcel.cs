using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models.ExportToExcelModels
{
    public class LimitsDistributionAccExcel
    {
        [Display(Name = "МФО")]
        public string Kf { get; set; }
        [Display(Name = "Назва РУ")]
        public string MfoName { get; set; }
        [Display(Name = "Відділення")]
        public string Branch { get; set; }
        [Display(Name = "Рахунок")]
        public string AccNumber { get; set; }
        [Display(Name = "Назва рахунку")]
        public string Name { get; set; }
        [Display(Name = "Тип рахунку")]
        public string CashType { get; set; }
        [Display(Name = "Код валюти")]
        public decimal? Currency { get; set; }
        [Display(Name = "ОБ22")]
        public string Ob22 { get; set; }
        [Display(Name = "Поточний ліміт")]
        public decimal? LimitCurrent { get; set; }
        [Display(Name = "Максимальний ліміт")]
        public decimal? LimitMax { get; set; }

    }
}
