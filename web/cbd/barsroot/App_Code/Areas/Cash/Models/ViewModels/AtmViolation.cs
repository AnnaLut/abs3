using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models
{
    public class AtmViolation
    {
        [Display(Name = "Колір")]
        public String Colour { get; set; }
        [Display(Name = "Мфо")]
        public String Mfo { get; set; }
        [Display(Name = "Назва РУ")]
        public String MfoName { get; set; }

        [Display(Name = "Відділення")]
        public String Branch { get; set; }
        [Display(Name = "Код банкомату")]
        public String AtmCode { get; set; }

        [Display(Name = "Рахунок")]
        public String AccNumber { get; set; }

        [Display(Name = "Валюта")]
        public Decimal? AccCurrency { get; set; }
        [Display(Name = "Ліміт макс. загрузки")]
        public Decimal? LimitMaxLoad { get; set; }

        //[Display(Name = "Баланс рахунку")]
        //public Decimal? Balance { get; set; }
        [Display(Name = "Сума транзакції")]
        public Decimal? TransactionSumma { get; set; }
        [Display(Name = "Дата транзакції")]
        public DateTime? Date { get; set; }  
      

        [Display(Name = "Сума поруш. ліміту макс. загрузки")]
        public Decimal? OverSumma { get; set; }


    }
}
