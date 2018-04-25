using System;

namespace Areas.Mcp.Models
{
    public class FileRec4Match
    {
        public decimal ID { get; set; }
        public decimal FILE_ID { get; set; }
        public decimal? DEPOSIT_ACC { get; set; }
        public int? FILIA_NUM { get; set; }
        public short? DEPOSIT_CODE { get; set; }
        public decimal? PAY_SUM { get; set; }
        public string FULL_NAME { get; set; }
        public string NUMIDENT { get; set; }
        public string PAY_DAY { get; set; }
        public string DISPLACED { get; set; }
        public short? STATE_ID { get; set; }
        public string STATE_NAME { get; set; }
        public short? BLOCK_TYPE_ID { get; set; }
        public string BLOCK_COMMENT { get; set; }
        public decimal ENVELOPE_FILE_ID { get; set; }
        public DateTime? FACT_PAY_DATE { get; set; }
    }
}
