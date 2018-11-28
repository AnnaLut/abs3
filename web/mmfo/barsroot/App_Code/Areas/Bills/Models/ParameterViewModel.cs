using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель параметра модели отчетов для отображения
    /// </summary>
    public class ParameterViewModel
    {
        public Int32? PARAM_ID { get; set; }
        public String PARAM_CODE { get; set; }
        public String PARAM_NAME { get; set; }
        public String PARAM_TYPE { get; set; }
        public Int32? NULLABLE { get; set; }
        public String VALUES { get; set; }
    }
}