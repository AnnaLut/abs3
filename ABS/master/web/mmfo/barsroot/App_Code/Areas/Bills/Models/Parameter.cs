using System;

namespace BarsWeb.Areas.Bills.Model
{

    /// <summary>
    /// Модель параметров отчетов
    /// </summary>
    public class Parameter
    {
        public Int32? PARAM_ID { get; set; }
        public String PARAM_CODE { get; set; }
        public String PARAM_NAME { get; set; }
        public String PARAM_TYPE { get; set; }
        public Int32? NULLABLE { get; set; }
        public Int32? VALUE_ID { get; set; }
        public String VALUE { get; set; }
        public String KF { get; set; }
    }
}