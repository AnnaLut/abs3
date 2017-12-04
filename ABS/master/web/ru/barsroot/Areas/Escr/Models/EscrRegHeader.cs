﻿using System;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrRegHeader
    {
        public int NUM { get; set; }
        public Int32 CUSTOMER_ID { get; set; }
        public string CUSTOMER_NAME { get; set; }
        public string CUSTOMER_OKPO { get; set; }
        public string CUSTOMER_REGION { get; set; }
        public string CUSTOMER_FULL_ADDRESS { get; set; }
        public int CUSTOMER_TYPE { get; set; }
        public string SUBS_NUMB { get; set; }
        public DateTime? SUBS_DATE { get; set; }
        public string SUBS_DOC_TYPE { get; set; }
        public Int32 DEAL_ID { get; set; }
        public string DEAL_NUMBER { get; set; }
        public DateTime? DEAL_DATE_FROM { get; set; }
        public DateTime? DEAL_DATE_TO { get; set; }
        public int DEAL_TERM { get; set; }
        public string DEAL_PRODUCT { get; set; }
        public string DEAL_STATE { get; set; }
        public string DEAL_TYPE_NAME { get; set; }
        public decimal? DEAL_SUM { get; set; }
        public int? CREDIT_STATUS_ID { get; set; }
        public string CREDIT_STATUS_NAME { get; set; }
        public string CREDIT_STATUS_CODE { get; set; }
        public string CREDIT_COMMENT { get; set; }
        public string STATE_FOR_UI { get; set; }
        public decimal? GOOD_COST { get; set; }
        public string NLS { get; set; }
        public DateTime? DOC_DATE { get; set; }
        public string MONEY_DATE { get; set; }
        public decimal? COMP_SUM { get; set; }
        public Int32? VALID_STATUS { get; set; }
        public string BRANCH_CODE { get; set; }
        public string BRANCH_NAME { get; set; }
        public string MFO { get; set; }
        public Int32 USER_ID { get; set; }
        public string USER_NAME { get; set; }
        public Int32 REG_TYPE_ID { get; set; }
        public Int32 REG_KIND_ID { get; set; }
        public Int32 REG_ID { get; set; }
    }
}