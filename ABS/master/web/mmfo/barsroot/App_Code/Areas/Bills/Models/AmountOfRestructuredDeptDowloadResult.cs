using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель результата загрузки файла расчета реструктуризированной задолжности с ДКСУ
    /// </summary>
    public class AmountOfRestructuredDeptDowloadResult
    {
        public String TextResult { get; set; }
        public Int32 ID { get; set; }
    }
}