using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for V_PFU_PENSIONER_EXCEL
/// </summary>
/// 
namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFU_PENSIONER_EXCEL
    {

        [Display(Name = "Дата народження")]
        public DateTime? bday { get; set; }

        [Display(Name = " Моб.тел")]
        public string cellphone { get; set; }
        [Display(Name = "Коментар")]
        public string comm { get; set; }
        [Display(Name = "ПІБ Клієнта")]//
        public string nmk { get; set; }
        [Display(Name = "МФО")]
        public string kf { get; set; }
        [Display(Name = "Номер")]
        public string numdoc { get; set; }
        [Display(Name = "ІПН Клієнта")]
        public string okpo { get; set; }
        [Display(Name = "Тип документа")]
        public Int32 passp { get; set; }
        [Display(Name = " Серія ")]
        public string ser { get; set; }
        [Display(Name = "Тип клієнта")]
        public int? type_pensioner { get; set; }
        [Display(Name = "Номер рахунка")]
        public string nls { get; set; }
        [Display(Name = "Дата відкриття")]
        public DateTime? daos { get; set; }
        [Display(Name = " Тип блокування")]
        public int? block_type { get; set; }
        [Display(Name = " Дата блокування")]
        public DateTime? block_date { get; set; }
        [Display(Name = "Результати перевірки ІПН")]
        public Int32 is_okpo_well { get; set; }
    }
}