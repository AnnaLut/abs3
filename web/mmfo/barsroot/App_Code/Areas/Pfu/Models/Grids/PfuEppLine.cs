using System;

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class PfuEppLine
    {
        public decimal? ID { get; set; }
        public decimal? BATCH_REQUEST_ID { get; set; }
        public DateTime? BATCH_DATE { get; set; }
        public decimal? LINE_ID { get; set; }
        public string EPP_NUMBER { get; set; }
        public string EPP_EXPIRY_DATE { get; set; }
        public string PERSON_RECORD_NUMBER { get; set; }
        public string LAST_NAME { get; set; }
        public string FIRST_NAME { get; set; }
        public string MIDDLE_NAME { get; set; }
        public string GENDER { get; set; }
        public string DATE_OF_BIRTH { get; set; }
        public string PHONE_NUMBERS { get; set; }
        public string EMBOSSING_NAME { get; set; }
        public string TAX_REGISTRATION_NUMBER { get; set; }
        public string DOCUMENT_TYPE { get; set; }
        public string DOCUMENT_ID { get; set; }
        public string DOCUMENT_ISSUE_DATE { get; set; }
        public string DOCUMENT_ISSUER { get; set; }
        public string DISPLACED_PERSON_FLAG { get; set; }
        public string LEGAL_COUNTRY { get; set; }
        public string LEGAL_ZIP_CODE { get; set; }
        public string LEGAL_REGION { get; set; }
        public string LEGAL_DISTRICT { get; set; }
        public string LEGAL_SETTLEMENT { get; set; }
        public string LEGAL_STREET { get; set; }
        public string LEGAL_HOUSE { get; set; }
        public string LEGAL_HOUSE_PART { get; set; }
        public string LEGAL_APARTMENT { get; set; }
        public string ACTUAL_COUNTRY { get; set; }
        public string ACTUAL_ZIP_CODE { get; set; }
        public string ACTUAL_REGION { get; set; }
        public string ACTUAL_DISTRICT { get; set; }
        public string ACTUAL_SETTLEMENT { get; set; }
        public string ACTUAL_STREET { get; set; }
        public string ACTUAL_HOUSE { get; set; }
        public string ACTUAL_HOUSE_PART { get; set; }
        public string ACTUAL_APARTMENT { get; set; }
        public string BANK_MFO { get; set; }
        public string BANK_NUM { get; set; }
        public string BANK_NAME { get; set; }
        public decimal? STATE_ID { get; set; }
        public string LINE_SIGN { get; set; }
        public DateTime? ACTIVATION_DATE { get; set; }
        public DateTime? DESTRUCTION_DATE { get; set; }
        public DateTime? BLOCK_DATE { get; set; }
        public DateTime? UNBLOCK_DATE { get; set; }
        public string ACCOUNT_NUMBER { get; set; }
        public DateTime? SIGN_PASS_CHANGE_FLAG { get; set; }
        public string BRANCH { get; set; }
        public string PENS_TYPE { get; set; }
        public string TYPE_CARD { get; set; }
        public decimal? TERM_CARD { get; set; }
        public decimal? RNK { get; set; }
        public string STATE_NAME { get; set; }
        
    }
}