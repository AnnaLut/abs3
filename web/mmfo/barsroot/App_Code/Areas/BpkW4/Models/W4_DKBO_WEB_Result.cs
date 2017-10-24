using System;
namespace BarsWeb.Areas.BpkW4.Models
{
    public class W4_DKBO_WEB_Result
    {
        public string DKBO_STATUS {get; set;}
        public string DKBO_CONTRACT_ID {get; set;}
        public DateTime? DKBO_DATE_FROM { get; set; }
        public DateTime? DKBO_DATE_TO { get; set; }
        public string CARD_ACC { get; set; }
        public string BRANCH { get; set; }
        public string CURRENCY { get; set; }
        public string SUBPRODUCT { get; set; }
        public string CARD_TYPE { get; set; }
        public string ACC_OB22 { get; set; }
        public decimal ACC_OST { get; set; }
        public DateTime? CARD_DATE_FROM { get; set; }
        public DateTime? CARD_DATE_TO { get; set; }
        public int CUSTOMER_ID { get; set; }
        public string CUSTOMER_NAME { get; set; }
        public string CUSTOMER_ZKPO { get; set; }
        public int CUSTOMER_TYPE { get; set; }
        public string SED { get; set; }
        public decimal? DEAL_ID { get; set; }
        public string DOC_ID { get; set; }
        public decimal ACC_ACC { get; set; }
        public decimal DKBO_EXISTS { get; set; }
        public DateTime? CUSTOMER_BDAY { get; set; }
        public string PASS_SERIAL { get; set; }
        public string PASS_NUMBER { get; set; }
        public DateTime? PASS_DATE { get; set; }
        public string PASS_ORGAN { get; set; }
        public int? ID_SAL_PR { get; set; }
        public string NAME_SAL_PR { get; set; }
        public string OKPO_SAL_PR { get; set; }
    }
}
