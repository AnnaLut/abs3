using System;
using System.ComponentModel.DataAnnotations;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель значений для р=параметров отчетов
    /// Используется в случае задания значений по умолчанию
    /// </summary>
    public class ParameterValue
    {
        public Int32 PARAMETER_ID { get; set; }
        public Int32 ID { get; set; }
        [Display(Name = "Значення параметру")]
        public String VALUE { get; set; }
    }
}