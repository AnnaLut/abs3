using System;

namespace Bars.WebServices.XRM.Services.SKRN.Models
{
    public class SetDocIsSignedRequest
    {
        /// <summary>
        /// Номер договору
        /// </summary>
        public Int64? Nd { get; set; }
        /// <summary>
        /// Ідентификатор шаблону (назва frx файлу)
        /// </summary>
        public string TemplateId { get; set; }
        /// <summary>
        /// Номер доп.угоди
        /// </summary>
        public Int64? Adds { get; set; }
    }
}