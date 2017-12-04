using System;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrRegister
    {
        public Int32 ID { get; set; }
        public string INNER_NUMBER { get; set; }
        public string OUTER_NUMBER { get; set; }
        public DateTime? CREATE_DATE { get; set; }
        public DateTime? DATE_FROM { get; set; }
        public DateTime? DATE_TO { get; set; }
        public Int32 REG_TYPE_ID { get; set; }
        public string REG_TYPE_CODE { get; set; }
        public string REG_TYPE_NAME { get; set; }
        public Int32 REG_KIND_ID { get; set; }
        public string REG_KIND_CODE { get; set; }
        public string REG_KIND_NAME { get; set; }
        public string BRANCH { get; set; }
        public Int32 REG_LEVEL { get; set; }
        public string REG_LEVEL_CODE { get; set; }
        public Int32 USER_ID { get; set; }
        public string USER_NAME { get; set; }
        public Int32 REG_STATUS_ID { get; set; }
        public string REG_STATUS_CODE { get; set; }
        public string REG_STATUS_NAME { get; set; }
        public bool REG_UNION_FLAG { get; set; }
        public int? CREDIT_COUNT { get; set; }
        public int? ERR_COUNT { get; set; }
        public int? VALID_STATUS { get; set; }
    }
}