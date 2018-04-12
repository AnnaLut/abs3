using System;

namespace Areas.Mcp.Models
{
	public class Files
	{
        public decimal ID { get; set; }
        public string FILE_PATH { get; set; }
        public string PAYMENT_TYPE { get; set; }
        public string FILE_NAME { get; set; }
        public decimal? COUNT_TO_PAY { get; set; }
        public decimal? SUM_TO_PAY { get; set; }
        public decimal? BALANCE_2909 { get; set; }
        public decimal? BALANCE_2560 { get; set; }
        public DateTime? LAST_BALANCE_REQ { get; set; }
        public DateTime? FACT_PAYMENT_DATE { get; set; }
        public string FACT_PAYMENT_SUM { get; set; }
        public string RETURN_PAYMENT_SUM { get; set; }
        public string FILE_BANK_NUM { get; set; }
        public string FILE_FILIA_NUM { get; set; }
        public string FILE_PAY_DAY { get; set; }
        public string FILE_SEPARATOR { get; set; }
        public string FILE_UPSZN_CODE { get; set; }
        public short? HEADER_LENGHT { get; set; }
        public string FILE_DATE { get; set; }
        public DateTime? FILE_DATETIME { get; set; }
        public int? REC_COUNT { get; set; }
        public int? PAYER_MFO { get; set; }
        public long? PAYER_ACC { get; set; }
        public int? RECEIVER_MFO { get; set; }
        public long? RECEIVER_ACC { get; set; }
        public string ACC_NUM_2560 { get; set; }
        public string DEBIT_KREDIT { get; set; }
        public decimal? PAY_SUM { get; set; }
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
        public int? ENVELOPE_STATE_ID { get; set; }
        public string ENVELOPE_STATE_NAME { get; set; }        
    }
}
