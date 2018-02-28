using System;

namespace Bars.WebServices.XRM.Services.SKRN.Models
{
    public class TemplatesCrtRequest
    {
        /// <summary>
        /// Номер договору
        /// </summary>
        public Int64? Nd { get; set; }

        /// <summary>
        /// Рнк клієнта
        /// </summary>
        public Int64? Rnk { get; set; }
        /// <summary>
        /// Ідентификатор шаблону (назва frx файлу)
        /// </summary>
        public string TemplateId { get; set; }
    }
}