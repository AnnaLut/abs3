using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Reporting.Models
{
    public class ReportStructure
    {
        [Display(Name = "Код формы отчета")]
        public String Kod { get; set; }

        [Display(Name = "Номер атрибута")]
        public Decimal? AttrNum { get; set; }

        [Display(Name = "Наименование атрибута")]
        public String AttrName { get; set; }

        [Display(Name = "Формула/Значение")]
        public String Value { get; set; }

        [StringLength(1, ErrorMessage = "Значение {0} должно содержать не менее {2} символов.", MinimumLength = 0)]
        [Display(Name = "Признак Часть ключа")]
        public String IsCode { get; set; }

        [Display(Name = "Код схемы предоставления")]
        public String A017 { get; set; }

        [Display(Name = "N п/п для сортировки")]
        public Decimal? Sort { get; set; }
    }
}
