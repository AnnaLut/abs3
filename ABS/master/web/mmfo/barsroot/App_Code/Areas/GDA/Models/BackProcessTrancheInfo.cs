using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.GDA.Models
{
    public class BackProcessTrancheInfo
    {
        public long DEPOSIT_ID { get; set; }
        public string CONTRACT_NUMBER { get; set; }
        public string OKPO { get; set; }
        public DateTime? START_DATE { get; set; }
        public DateTime? EXPIRY_DATE { get; set; }
        public DateTime? CLOSE_DATE { get; set; }
        public int? CUSTOMER_ID { get; set; }
        public int? PROCESS_ID { get; set; }
        public string DEAL_NUMBER_NAME { get; set; }
        public string TRANSACTION_TYPE { get; set; }
        public string STATE_NAME { get; set; }
        public DateTime? SYS_TIME { get; set; }
        public int? USER_ID { get; set; }
        public string FIO { get; set; }
        public string PROCESS_CODE { get; set; }
        public string PROCESS_NAME { get; set; }
        public string PROCESS_STATE_CODE { get; set; }
        public int? PROCESS_STATE_ID { get; set; }
        public string PROCESS_STATE_NAME { get; set; }
        public string OBJECT_STATE_CODE { get; set; }
        public string OBJECT_STATE_NAME { get; set; }
        public string DEPOSIT_TYPE_CODE { get; set; }
        public string OBJECT_TYPE_NAME { get; set; }
        public int? PROCESS_HISTORY_ID { get; set; }
        public string DEAL_NUMBER { get; set; }
        public DateTime? START_DATE_ { get; set; }
        public DateTime? ACTION_DATE_ { get; set; }
        public int? CURRENCY_ID { get; set; }
        public string LCV { get; set; }
        public string CUSTOMER_NAME { get; set; }
        public string ACCOUNT_NUMBER { get; set; }
        public decimal? AMOUNT_DEPOSIT { get; set; }
        public float? INTEREST_RATE { get; set; }
        public decimal? TOTAL_AMOUNT_DEPOSIT { get; set; }
        public string FREQUENCY_PAYMENT_NAME { get; set; }
        public string BRANCH_ID { get; set; }
        public int? IS_EXPIRED_AND_BLOCKED { get; set; }

        public string RNK {
            get
            {
                return CUSTOMER_ID.HasValue ? CUSTOMER_ID.ToString() : "";
            }
        }
    }
}