using System;
using System.ComponentModel;

namespace BarsWeb.Areas.Cash.ViewModels
{
    /// <summary>
    /// Кассовый счет
    /// </summary>
    public class Account
    {
        [DisplayName("МФО")]
        public string Mfo { get; set; }
        [DisplayName("Назва РУ")]
        public string MfoName { get; set; }
        [DisplayName("Відділення")]
        public string Branch { get; set; }

        [DisplayName("Тип касового рахунку")]
        public string CashType { get; set; }
        
        [DisplayName("Тип рахунку")]
        public string CashTypeName { get; set; }

        [DisplayName("ID рахунку")]
        public decimal AccountId { get; set; }

        [DisplayName("Балансовий рахунок")]
        public string BalNumber { get; set; }

        [DisplayName("Рахунок")]
        public string AccountNumber { get; set; }

        [DisplayName("ОБ22")]
        public string Ob22 { get; set; }

        [DisplayName("Код валюти")]
        public short Currency { get; set; }

        [DisplayName("Назва рахунку")]
        public string AccountName { get; set; }

        /// <summary>
        /// Остаток в единицах (не в копейках)
        /// </summary>
        [DisplayName("Баланс рахунку")]
        public decimal? Balance { get; set; }

        [DisplayName("Дата відкриття рахунку")]
        public DateTime? OpenDate { get; set; }

        [DisplayName("Дата закриття рахунку")]
        public DateTime? CloseDate { get; set; }

        [DisplayName("ID рахунку РУ")]
        public decimal AccountSourceId { get; set; }

        [DisplayName("Дата останнього оновлення")]
        public DateTime? LastDate { get; set; }
    }
}