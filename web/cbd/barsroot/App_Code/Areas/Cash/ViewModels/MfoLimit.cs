using System.ComponentModel;

namespace BarsWeb.Areas.Cash.ViewModels
{
    /// <summary>
    /// Лимит на МФО
    /// </summary>
    public class MfoLimit
    {
        [DisplayName("МФО")]
        public string Mfo { get; set; }
        [DisplayName("Назва РУ")]
        public string MfoName { get; set; }

        [DisplayName("Тип ліміту")]
        public string LimitType { get; set; }

        [DisplayName("Назва типу ліміту")]
        public string LimitTypeName { get; set; }

        [DisplayName("Код валюти")]
        public short CurrencyCode { get; set; }

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