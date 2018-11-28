using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель для отображения документов!
    /// </summary>
    public class V_Documents
    {
        public Int32 DOC_ID { get; set; }
        public Int32? REC_ID { get; set; }
        public Int32 TYPE_ID { get; set; }
        public String TYPE_CODE { get; set; }
        public String TYPE_DESCRIPTION { get; set; }
        public String STATUS { get; set; }
        public String STATUS_NAME { get; set; }
        public DateTime? LAST_DT { get; set; }
        public String LAST_USER { get; set; }
        public String FILENAME { get; set; }
        public Int32? EXT_ID { get; set; }
        public String DESCRIPT { get; set; }
    }
}