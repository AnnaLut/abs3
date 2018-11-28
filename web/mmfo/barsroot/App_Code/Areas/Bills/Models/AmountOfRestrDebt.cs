using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель View расчета суммы реструктуризированной задолжности
    /// </summary>
    public class AmountOfRestrDebt
    {
        // Внутренний ид расчета
        public Int32 REQUEST_ID { get; set; }

        // Имя файла расчета
        public String REQUEST_NAME { get; set; }

        // Дата с
        public DateTime DATE_FROM { get; set; }

        // Дата по
        public DateTime? DATE_TO { get; set; }

        // Системная дата получения расчета
        public DateTime? REQUEST_DATE { get; set; }

        // Имя файла скана
        public String SCAN_NAME { get; set; }

        //Дата отправки скана
        public DateTime? SCAN_DATE { get; set; }
        public String STATUS { get; set; }
    }
}