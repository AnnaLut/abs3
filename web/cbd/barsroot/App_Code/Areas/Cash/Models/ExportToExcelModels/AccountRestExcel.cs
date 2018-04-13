using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models.ExportToExcelModels
{
    /// <summary>
    /// Остаток по счету
    /// </summary>
    public class AccountRestExcel
    {
        [Display(Name = "МФО")]
        public string Mfo { get; set; }
        [Display(Name = "Назва РУ")]
        public string MfoName { get; set; }

        [Display(Name = "Відділення")]
        public string Branch { get; set; }
        [Display(Name = "Тип рахунку")]
        public string CashType { get; set; }
        [Display(Name = "Балансовий рахунок")]
        public string BalNumber { get; set; }
        [Display(Name = "Рахунок")]
        public string AccountNumber { get; set; }
        [Display(Name = "ОБ22")]
        public string Ob22 { get; set; }

        [Display(Name = "Код валюти")]
        public short Currency { get; set; }
        /// <summary>
        /// Баланс в единицах (не в копейках)
        /// </summary>
        [Display(Name = "Баланс рахунку")]
        public decimal? Balance { get; set; }
        
        [Display(Name = "Дата відкриття рахунку")]
        public DateTime? OpenDate { get; set; }
        [Display(Name="Дата останнього оновлення")]
        public DateTime? BalanceDate { get; set; }



        /*[Display(Name="Назва рахунку")]
        public string AccountName { get; set; }


        [Display(Name="Дата закриття рахунку")]
        public DateTime? CloseDate { get; set; }

        [Display(Name="ID рахунку РУ")]
        public decimal AccountSourceId { get; set; }*/
    }
}