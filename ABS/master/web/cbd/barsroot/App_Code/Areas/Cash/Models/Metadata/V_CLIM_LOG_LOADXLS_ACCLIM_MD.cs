using System;
using System.ComponentModel.DataAnnotations;

namespace Areas.Cash.Models
{
    [MetadataType(typeof(V_CLIM_LOG_LOADXLS_ACCLIM_MD))]
    public partial class V_CLIM_LOG_LOADXLS_ACCLIM
    {
    }
    public class V_CLIM_LOG_LOADXLS_ACCLIM_MD
    {
        [Display(Name = "Внутрішній номер рахунку")]
        public decimal? ACC_ID { get; set; }
        [Display(Name = "Відділення")]
        public string ACC_BRANCH { get; set; }
        [Display(Name = "МФО")]
        public string KF { get; set; }
        [Display(Name = "Рахунок")]
        public string ACC_NUMBER { get; set; }
        [Display(Name = "Назва рахунку")]
        public string ACC_NAME { get; set; }
        [Display(Name = "Код валюти")]
        public decimal? KV { get; set; }
        [Display(Name = "Баланс рахунку")]
        public decimal? BALANCE { get; set; }
        [Display(Name = "Поточний ліміт")]
        public decimal? LIM_CURRENT { get; set; }
        [Display(Name = "Максимальний ліміт")]
        public decimal? LIM_MAX { get; set; }
        [Display(Name = "Тип рахунку")]
        public string TYPE_ACC { get; set; }
        [Display(Name = "Назва РУ")]
        public DateTime? ACC_CLOSE_DATE { get; set; }




        [Display(Name = "Дата початку дії ліміту")]
        public DateTime? LIM_START_DATE { get; set; }

        [Display(Name = "Дата та час завантаження")]
        public DateTime? PROCESS_DATE { get; set; }

        [Display(Name = "Статус")]
        public string STATUS { get; set; }

        [Display(Name = "Помилка")]
        public string TEXT { get; set; }
    }
}
