using System;
using System.ComponentModel;

namespace BarsWeb.Areas.Cash.Infrastructure.Sync
{
    /// <summary>
    /// Остаток по счету, полученный из региона
    /// </summary>
    public class RegionAccountRest
    {
        [DisplayName("ID рахунку")]
        public decimal AccountId { get; set; }

        [DisplayName("МФО")]
        public string Mfo { get; set; }

        [DisplayName("Банківська дата")]
        public DateTime? BankDate { get; set; }

        /// <summary>
        /// Баланс в единицах (не в копейках)
        /// </summary>
        [DisplayName("Баланс рахунку")]
        public decimal Balance { get; set; }
    }
}