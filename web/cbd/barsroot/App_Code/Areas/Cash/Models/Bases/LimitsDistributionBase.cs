using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models.Bases
{
    public class LimitsDistributionBase
    {
        [Display(Name = "Внутрішній номер рахунку", Order = 1)]
        public decimal? Id { get; set; }
        [Display(Name = "Бранч", Order = 2)]
        public string Branch { get; set; }
        [Display(Name = "Код філії", Order = 3 )]
        public string Kf { get; set; }
        [Display(Name = "Номер рахунку", Order = 4)]
        public string AccNumber { get; set; }
        [Display(Name = "Назва рахунку", Order = 5)]
        public string Name { get; set; }
        [Display(Name = "Код валюти", Order = 6)]
        public decimal? Currency { get; set; }
        [Display(Name = "Залишок", Order = 7)]
        public decimal? Balance { get; set; }
        [Display(Name = "Тип рахунку", Order = 20)]
        public string CashType { get; set; }
        [Display(Name = "Дата закриття рахунку", Order = 21)]
        public DateTime? ClosedDate { get; set; }
    }
}
