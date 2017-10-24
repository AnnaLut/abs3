using System;
using System.ComponentModel;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Кассовый счет, полученный из региона
    /// </summary>
    public class RegionAccount
    {
        [DisplayName("МФО")]
        public string Mfo { get; set; }

        [DisplayName("Бранч")]
        public string Branch { get; set; }

        [DisplayName("Тип касового рахунку")]
        public string CashType { get; set; }

        [DisplayName("ID рахунку")]
        public decimal AccountId { get; set; }

        [DisplayName("Балансовий рахунок")]
        public string BalNumber { get; set; }

        [DisplayName("Особовий рахунок")]
        public string AccountNumber { get; set; }

        [DisplayName("ОБ22")]
        public string Ob22 { get; set; }

        [DisplayName("Код валюти")]
        public short Currency { get; set; }

        [DisplayName("Назва рахунку")]
        public string AccountName { get; set; }

        /// <summary>
        /// Остаток в копейках
        /// </summary>
        [DisplayName("Залишок")]
        public decimal? Balance { get; set; }
        //[DisplayName("Максимальний ліміт завантаження")]
        //public decimal? AccMaxLoad { get; set; }

        [DisplayName("Дата відкриття рахунку")]
        public DateTime? OpenDate { get; set; }

        [DisplayName("Дата закриття рахунку")]
        public DateTime? CloseDate { get; set; }
        [DisplayName("Дата останього руху")]
        public DateTime? LastUpdateDate { get; set; }
    }
}