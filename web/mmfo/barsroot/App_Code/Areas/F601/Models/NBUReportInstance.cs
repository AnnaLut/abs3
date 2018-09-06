using System;

namespace BarsWeb.Areas.F601.Models
{
    /// <summary>
    /// Перелік сеансів передачі даних 601 форми до НБУ
    /// Отримується наступним запитом
    /// select * from nbu_gateway.v_nbu_report_instance  t order by t.id
    /// </summary>
    public class NBUReportInstance
    {
        public decimal? ID { get; set; }
        public DateTime? REPORTING_DATE { get; set; } //Дата відправки звіту
        public string STAGE_NAME { get; set; } // Статус звіту

    }
}