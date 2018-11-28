using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель параметра для формирования файла отчета (FastReport)
    /// </summary>
    public class ReportParameter
    {
        public Int32? ID { get; set; }
        public String INFO { get; set; }
        public String TYPE { get; set; }
        public String PARAMETER { get; set; }
        public Int32? NULLABLE { get; set; }
    }
}