using System;

namespace BarsWeb.Areas.F601.Models
{
    /// <summary>
    /// Дельта сеансів передачі даних 601 форми до НБУ
    /// Отримується наступним запитом:
    /// SELECT * FROM   TABLE(nbu_gateway.f_get_tab_compare_json(:p_sessionId,:p_reportId )) ORDER BY id
    /// Результат такий:
    /// Женя Остапенко, [09.08.18 12:23]
    /// CREATE OR REPLACE TYPE t_compare_json AS OBJECT(t_compare_json
    ///  id        NUMBER,
    ///  report_id NUMBER,
    ///  object_id NUMBER,
    ///  json      CLOB
    ///)
    /// 
    /// </summary>
    public class NBUSessionData
    {
        public decimal? id { get; set; } // просто порядковий № рядка
        public decimal? report_id { get; set; } // p_reportId --> NBUSessionHistory.REPORT_ID
        public decimal? object_id { get; set; } // p_sessionId --> NBUSessionHistory.OBJECT_ID
        public string json { get; set; } // власне дані в форматі json, формат залежить від значення поля --> NBUSessionHistory.OBJECT_TYPE_ID 

    }
}