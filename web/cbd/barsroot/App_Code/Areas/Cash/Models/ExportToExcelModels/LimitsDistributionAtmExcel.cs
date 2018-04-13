using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models.ExportToExcelModels
{
    //todo: при експорті в ексель важливе розташування полів , 
    //а при наслідуванні власні свойства вилазять на перед 
    public class LimitsDistributionAtmExcel  //: LimitsDistributionBase
    {   
        [Display(Name = "МФО", Order = 4)]
        public string Kf { get; set; }

        [Display(Name = "Назва РУ", Order = 4)]
        public string MfoName { get; set; }
     
        [Display(Name = "Відділення", Order = 3)]
        public string Branch { get; set; }

        [Display(Name = "Код банкомату", Order = 2)]
        public string AtmCode { get; set; }
        [Display(Name = "Тип рахунку", Order = 20)]
        public string CashType { get; set; }
        [Display(Name = "Рахунок", Order = 5)]
        public string AccNumber { get; set; }

        [Display(Name = "Назва рахунку", Order = 6)]
        public string Name { get; set; }
        [Display(Name = "Код валюти", Order = 7)]
        public decimal? Currency { get; set; }

        [Display(Name = "Баланс рахунку", Order = 8)]
        public decimal? Balance { get; set; }

        [Display(Name = "Ліміт макс. загрузки", Order = 11)]
        public decimal? LimitMaxLoad { get; set; }
    }
}
