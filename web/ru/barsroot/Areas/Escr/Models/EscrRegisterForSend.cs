using System;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrRegisterForSend
    {
        public Int32 ID { get; set; }
        public string INNER_NUMBER { get; set; }
        public string OUTER_NUMBER { get; set; }
        public DateTime? CREATE_DATE { get; set; }
        public DateTime? DATE_FROM { get; set; }
        public DateTime? DATE_TO { get; set; }
        public Int32 REG_TYPE_ID { get; set; }
        public Int32 REG_KIND_ID { get; set; }
        public string BRANCH { get; set; }
        public Int32 REG_LEVEL { get; set; }
        public Int32 USER_ID { get; set; }
        public string USER_NAME { get; set; }
        public Int32 STATUS_ID { get; set; }
        public Int32 REG_UNION_FLAG { get; set; }
    }
}