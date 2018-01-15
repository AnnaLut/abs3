using System;

namespace Areas.Mcp.Models
{
    public class File4Match
    {
        public decimal ID { get; set; }
        public string PAYMENT_TYPE { get; set; }
        public string FILE_PATH { get; set; }
        public string FILE_NAME { get; set; }
        public string FILE_BANK_NUM { get; set; }
        public string FILE_FILIA_NUM { get; set; }
        public string FILE_PAY_DAY { get; set; }
        public string FILE_SEPARATOR { get; set; }
        public string FILE_UPSZN_CODE { get; set; }
        public short? HEADER_LENGHT { get; set; }
        public string FILE_DATE { get; set; }
        public int? REC_COUNT { get; set; }
        public int? PAYER_MFO { get; set; }
        public long? PAYER_ACC { get; set; }
        public int? RECEIVER_MFO { get; set; }
        public long? RECEIVER_ACC { get; set; }
        public string DEBIT_KREDIT { get; set; }
        public decimal? PAY_SUM { get; set; }
        public decimal? SUM_TO_PAY { get; set; }
        public short? PAY_TYPE { get; set; }
        public string PAY_OPER_NUM { get; set; }
        public string ATTACH_FLAG { get; set; }
        public string PAYER_NAME { get; set; }
        public string RECEIVER_NAME { get; set; }
        public string PAYMENT_PURPOSE { get; set; }
        public int? FILIA_NUM { get; set; }
        public short? DEPOSIT_CODE { get; set; }
        public string PROCESS_MODE { get; set; }
        public string CHECKSUM { get; set; }
        public short? STATE_ID { get; set; }
        public string STATE_CODE { get; set; }
        public string STATE_NAME { get; set; }
        public decimal ENVELOPE_FILE_ID { get; set; }
        public string ENVELOPE_FILE_NAME { get; set; }
        public short? ENVELOPE_FILE_STATE { get; set; }
        public string ENVELOPE_COMMENT { get; set; }

    }
}
