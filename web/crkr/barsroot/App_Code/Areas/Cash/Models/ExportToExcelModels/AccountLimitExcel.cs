using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models.ExportToExcelModels
{
    /// <summary>
    /// Лимит на счет
    /// </summary>
    public class AccountLimitExcel
    {
        [Display(Name ="МФО")]
        public string Mfo { get; set; }
        [Display(Name = "Назва РУ")]
        public string MfoName { get; set; }
        [Display(Name = "Відділення")]
        public string Branch { get; set; }
        [Display(Name = "Тип рахунку")]
        public string CashTypeName { get; set; }
        [Display(Name = "Рахунок")]
        public string PrivateAccount { get; set; }

        [Display(Name = "Код валюти")]
        public short CurrencyCode { get; set; }
        [Display(Name = "Назва рахунку")]
        public string AccountName { get; set; }

        /// <summary>
        /// Текущий лимит в единицах (не в копейках)
        /// </summary>
        [Display(Name = "Поточний ліміт")]
        public decimal? CurrentLimit { get; set; }

        /// <summary>
        /// Максимальный лимит в единицах (не в копейках)
        /// </summary>
        [Display(Name = "Максимальний ліміт")]
        public decimal? MaxLimit { get; set; }
        /// <summary>
        /// Текущий баланс в единицах (не в копейках)
        /// </summary>
        [Display(Name = "Баланс рахунку")]
        public decimal? Balance { get; set; }
        [Display(Name = "Ліміт порушений")]
        public string LimitViolatedName { get; set; }

    }
}