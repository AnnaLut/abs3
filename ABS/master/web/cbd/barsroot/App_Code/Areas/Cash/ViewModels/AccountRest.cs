using System;
using System.ComponentModel;

namespace BarsWeb.Areas.Cash.ViewModels
{
    /// <summary>
    /// Остаток по счету
    /// </summary>
    public class AccountRest
    {
        [DisplayName("ID рахунку")]
        public decimal AccountId { get; set; }

        [DisplayName("МФО")]
        public string Mfo { get; set; }
        [DisplayName("Назва РУ")]
        public string MfoName { get; set; }

        /// <summary>
        /// Баланс в единицах (не в копейках)
        /// </summary>
        [DisplayName("Баланс рахунку")]
        public decimal? Balance { get; set; }

        [DisplayName("Відділення")]
        public string Branch { get; set; }

        [DisplayName("Тип рахунку")]
        public string CashType { get; set; }

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
        
        [DisplayName("Дата відкриття рахунку")]
        public DateTime? OpenDate { get; set; }

        [DisplayName("Дата закриття рахунку")]
        public DateTime? CloseDate { get; set; }
        [DisplayName("Дата останнього оновлення")]
        public DateTime? BalanceDate { get; set; }
        [DisplayName("ID рахунку РУ")]
        public decimal AccountSourceId { get; set; }
    }
}