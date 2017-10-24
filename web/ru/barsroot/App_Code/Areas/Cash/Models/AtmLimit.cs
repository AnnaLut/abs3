using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models
{
    //todo: при експорті в ексель важливе розташування полів , 
    //а при наслідуванні власні свойства вилазять на перед 
    public class AtmLimit //: LimitsDistributionBase
    {
        [Key]
        [Display(Name = "Внутрішній номер рахунку", Order = 1)]
        public decimal? Id { get; set; }
        [Display(Name = "Код банкомату", Order = 2)]
        public string AtmCode { get; set; }
        [Display(Name = "Бранч", Order = 3)]
        public string Branch { get; set; }
        [Display(Name = "Код філії", Order = 4)]
        public string Kf { get; set; }
        [Display(Name = "Назва РУ", Order = 5)]
        public string MfoName { get; set; }
        [Display(Name = "Номер рахунку", Order = 6)]
        public string AccNumber { get; set; }
        [Display(Name = "Назва рахунку", Order = 7)]
        public string Name { get; set; }
        [Display(Name = "Код валюти", Order = 8)]
        public decimal? Currency { get; set; }
        [Display(Name = "Залишок", Order = 9)]
        public decimal? Balance { get; set; }
        //[Display(Name = "Поточний ліміт", Order = 10)]
        //public decimal? AccMaxLoad { get; set; }
        [Display(Name = "Максимальний ліміт завантаження", Order = 11)]
        public decimal? LimitMaxLoad { get; set; }
        [Display(Name = "Ліміт порушений", Order = 11)]
        public decimal? LimitViolated { get; set; }
        [Display(Name = "Ліміт порушений", Order = 11)]
        public string LimitViolatedName { get; set; }
        [Display(Name = "Тип рахунку", Order = 20)]
        public string CashType { get; set; }
        [Display(Name = "Дата закриття рахунку", Order = 21)]
        public DateTime? ClosedDate { get; set; }

        public decimal? DaysShow { get; set; }
        public string Colour { get; set; }

    }
}
