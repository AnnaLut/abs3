using System.ComponentModel;

namespace BarsWeb.Areas.Cash.ViewModels
{
    /// <summary>
    /// Лимит на счет
    /// </summary>
    public class AccountLimit
    {
        [DisplayName("ID рахунку")]
        public decimal AccountId { get; set; }

        /// <summary>
        /// Текущий лимит в единицах (не в копейках)
        /// </summary>
        [DisplayName("Поточний ліміт")]
        public decimal? CurrentLimit { get; set; }

        /// <summary>
        /// Максимальный лимит в единицах (не в копейках)
        /// </summary>
        [DisplayName("Максимальний ліміт")]
        public decimal? MaxLimit { get; set; }

        [DisplayName("Відділення")]
        public string Branch { get; set; }

        [DisplayName("Тип касового рахунку")]
        public string CashType { get; set; }

        [DisplayName("Тип касового рахунку")]
        public string CashTypeName { get; set; }

        [DisplayName("Особовий рахунок")]
        public string PrivateAccount { get; set; }

        [DisplayName("Назва рахунку")]
        public string AccountName { get; set; }

        [DisplayName("Код валюти")]
        public short CurrencyCode { get; set; }

        [DisplayName("МФО")]
        public string Mfo { get; set; }
        [DisplayName("Назва РУ")]
        public string MfoName { get; set; }

        /// <summary>
        /// Текущий баланс в единицах (не в копейках)
        /// </summary>
        [DisplayName("Поточний баланс")]
        public decimal? Balance { get; set; }

        public bool CurrentLimitViolated
        {
            get
            {
                var currentLimit = CurrentLimit ?? 0;
                var balance = Balance ?? 0;
                return balance > currentLimit;
            }
        }

        public bool MaxLimitViolated
        {
            get
            {
                var maxLimit = MaxLimit ?? 0;
                var balance = Balance ?? 0;
                return balance > maxLimit;
            }
        }

        [DisplayName("Ліміт порушений")]
        public bool LimitViolated { get; set; }

        [DisplayName("Ліміт порушений")]
        public string LimitViolatedName { get; set; }
    }
}