using System;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrRegister
    {
        public decimal ID { get; set; }
        public string INNER_NUMBER { get; set; }
        public string OUTER_NUMBER { get; set; }
        public DateTime? CREATE_DATE { get; set; }
        public DateTime? DATE_FROM { get; set; }
        public DateTime? DATE_TO { get; set; }
        public decimal REG_TYPE_ID { get; set; }
        public string REG_TYPE_CODE { get; set; }
        public string REG_TYPE_NAME { get; set; }
        public decimal REG_KIND_ID { get; set; }
        public string REG_KIND_CODE { get; set; }
        public string REG_KIND_NAME { get; set; }
        public string BRANCH { get; set; }
        public decimal REG_LEVEL { get; set; }
        public string REG_LEVEL_CODE { get; set; }
        public decimal USER_ID { get; set; }
        public string USER_NAME { get; set; }
        public decimal REG_STATUS_ID { get; set; }
        public string REG_STATUS_CODE { get; set; }
        public string REG_STATUS_NAME { get; set; }
        public bool REG_UNION_FLAG { get; set; }
        public decimal? CREDIT_COUNT { get; set; }
        public decimal? ERR_COUNT { get; set; }
        public decimal? VALID_STATUS { get; set; }
    }
}