using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель для параметров отчетов
    /// </summary>
    public class ReportParam
    {
        public Int32 Report_Id { get; set; }
        public Int32? Param_Id { get; set; }

        [Display(Name = "Значення змінної")]
        public String Param_Code { get; set; }

        [Display(Name = "Назва змінної")]
        public String Param_Name { get; set; }

        [Display(Name = "Тип змінної")]
        public String Param_Type { get; set; }

        [Display(Name = "Обов'язковість змінної")]
        public Int32? Nullable { get; set; }
    }
}