using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models.ExportToExcelModels
{
    public class LimitsDistributionAccExcelForUpload
    {
        [Display(Name = "Внутрішній номер рахунку")]
        public decimal? AccId { get; set; }
        [Display(Name = "Відділення")]
        public string Branch { get; set; }
        [Display(Name = "МФО")]
        public string Kf { get; set; }
        [Display(Name = "Рахунок")]
        public string AccNumber { get; set; }
        [Display(Name = "Назва рахунку")]
        public string Name { get; set; }
        [Display(Name = "Код валюти")]
        public decimal? Currency { get; set; }
        [Display(Name = "Баланс рахунку")]
        public decimal? Balance { get; set; }
        [Display(Name = "Поточний ліміт")]
        public decimal? LimitCurrent { get; set; }
        [Display(Name = "Максимальний ліміт")]
        public decimal? LimitMax { get; set; }
        [Display(Name = "Тип рахунку")]
        public string CashType { get; set; }
        [Display(Name = "Назва РУ")]
        public DateTime? AccDateClose { get; set; }

    }
}
