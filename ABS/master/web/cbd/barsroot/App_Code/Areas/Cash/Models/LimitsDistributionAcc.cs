using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models
{
    //todo: при експорті в ексель важливе розташування полів , 
    //а при наслідуванні власні свойства вилазять на перед 
    public class LimitsDistributionAcc //: LimitsDistributionBase
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




        [Display(Name = "Внутрішній номер рахунку")]
        public decimal? Id { get; set; }
        

        [Display(Name = "Залишок")]
        public decimal? Balance { get; set; }


        [Display(Name = "Дата закриття рахунку")]
        public DateTime? ClosedDate { get; set; }

    }
}
