using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель добавления отсканированного файла расчета сумм реструктуризированной задолжности
    /// </summary>
    public class AddCalcRequestScanModel
    {
        public Int32 REQUEST_ID { get; set; }
        public String SCAN_NAME { get; set; }
        public String SCAN_BODY { get; set; }
    }
}