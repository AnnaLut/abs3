using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// модель данных логирования о действиях пользователя!
    /// </summary>
    public class ReceiverLog
    {
        //ІД очікуваного отримувача, отриманий з ДКСУ
        public Int32 EXP_ID { get; set; }

        public DateTime? REC_DATE { get; set; }
        public String USER_REF { get; set; }
        public String ACTION { get; set; }
        public String RESULT { get; set; }
        public Int32 ID { get; set; }
    }
}