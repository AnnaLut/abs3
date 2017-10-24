using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Reporting.Models {
    public class DetailedReport
    {
        [Display(Name = "Відділення")]
        public string BRANCH { get; set; }

        [Display(Name = "Код показника")]
        public string FIELD_CODE { get; set; }

        [Display(Name = "Значення показника")]
        public string FIELD_VALUE { get; set; }

        [Display(Name = "Ідентифікатор рахунку")]
        public long? ACC_ID { get; set; }

        [Display(Name = "Номер рахунку")]
        public string ACC_NUM { get; set; }

        [Display(Name = "Код валюти")]
        public int? KV { get; set; }

        [Display(Name = "Дата погашення")]
        public DateTime? MATURITY_DATE { get; set; }

        [Display(Name = "РНК контрагента")]
        public long? CUST_ID { get; set; }

        [Display(Name = "ІІН контрагента")]
        public string CUST_CODE { get; set; }

        [Display(Name = "Назва контрагента")]
        public string CUST_NMK { get; set; }

        [Display(Name = "РЕФ кредитного договору")]
        public long? ND { get; set; }

        [Display(Name = "Номер договору")]
        public string AGRM_NUM { get; set; }

        [Display(Name = "Початок дії договору")]
        public DateTime? BEG_DT { get; set; }

        [Display(Name = "Дата завершення договору")]
        public DateTime? END_DT { get; set; }

        [Display(Name = "Номер документу")]
        public long? REF { get; set; }

        [Display(Name = "Коментар")]
        public string DESCRIPTION { get; set; }
    }
}

