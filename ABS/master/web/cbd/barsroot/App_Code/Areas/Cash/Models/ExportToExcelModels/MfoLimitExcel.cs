using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Cash.Models.ExportToExcelModels
{
    /// <summary>
    /// Лимит на МФО
    /// </summary>
    public class MfoLimitExcel
    {
        [Display(Name = "МФО")]
        public string Mfo { get; set; }
        [Display(Name = "Назва РУ")]
        public string MfoName { get; set; }

        [Display(Name = "Назва типу ліміту")]
        public string LimitTypeName { get; set; }

        [Display(Name = "Код валюти")]
        public short CurrencyCode { get; set; }

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