using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class ErrorRowsExcel
    {
        [Display(Name = " МФО(ПФУ)")]
        public string MFO { get; set; }
        [Display(Name = "MFO_NAME")]
        public string MFO_NAME { get; set; }
        [Display(Name = "Відділення")]
        public string BRANCH { get; set; }
        [Display(Name = "МФО")]
        public string KF_BANK { get; set; }
        [Display(Name = " ID")]
        public decimal? PFU_ENVELOPE_ID { get; set; }
        [Display(Name = "ID реєстру")]
        public decimal? FILE_ID { get; set; }
        [Display(Name = "ID інформаційного рядка")]
        public decimal? ID { get; set; }
        [Display(Name = "Рахунок(ПФУ)")]
        public string NLS_PFU { get; set; }
        [Display(Name = "Рахунок(АБС)")]
        public string NLS_BANK { get; set; }
        [Display(Name = "ПІБ Пенсіонера ПФУ")]
        public string NMK_PFU { get; set; }
        [Display(Name = "ІПН АБС")]
        public string NMK_BANK { get; set; }
        [Display(Name = "ІПН ПФУ")]
        public string OKPO_PFU { get; set; }
        [Display(Name = " ПІБ Пенсіонера АБС")]
        public string OKPO_BANK { get; set; }
        [Display(Name = "РНК Пенсіонера")]
        public decimal? RNK_BANK { get; set; }
        [Display(Name = "Статус")]
        public string STATE_NAME { get; set; }
        [Display(Name = "Статус")]
        public decimal? STATE { get; set; }
        [Display(Name = "Опис помилки")]
        public string ERR_MESS_TRACE { get; set; }
        /*[Display(Name = "ID інформаційного рядка")]
        public decimal? ID { get; set; }

        [Display(Name = "ID реєстру")]
        public decimal? FILE_ID { get; set; }

        [Display(Name = "ID конверту")]
        public decimal? PFU_ENVELOPE_ID { get; set; }

        [Display(Name = "МФО")]
        public string MFO { get; set; }
        [Display(Name = "МФО_NAME")]
        public string MFO_NAME { get; set; }

        [Display(Name = "Дата зарахування")]
        public DateTime? PAYMENT_DATE { get; set; }

        [Display(Name = "Номер рахунку")]
        public string NUM_ACC { get; set; }

        [Display(Name = "Сума")]
        public decimal? SUM_PAY { get; set; }

        [Display(Name = "ПІБ отримувача")]
        public string FULL_NAME { get; set; }

        [Display(Name = "ІПН")]
        public string NUMIDENT { get; set; }

        [Display(Name = "Статус")]
        public decimal? STATE { get; set; }
        [Display(Name = "Статус")]
        public string STATE_NAME { get; set; }

        [Display(Name = "Опис помилки")]
        public string ERR_MESS_TRACE { get; set; }*/

    }
}