using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class CardInsurance
    {
        public decimal? ND { get; set; }
        public string BRANCH { get; set; }
        public string ACC_NLS { get; set; }
        public string ACC_LCV { get; set; }
        public string ACC_OB22 { get; set; }
        public string ACC_TIPNAME { get; set; }
        public string CARD_CODE { get; set; }
        public DateTime? CARD_IDAT { get; set; }
        public decimal? ACC_OST { get; set; }
        public decimal? CUST_RNK { get; set; }
        public string CUST_OKPO { get; set; }
        public string CUST_NAME { get; set; }
        public DateTime? ACC_DAOS { get; set; }
        public DateTime? ACC_DAZS { get; set; }
        public string STATE { get; set; }
        public string ERR_MSG { get; set; }
        public decimal? INS_EXT_ID { get; set; }
        public decimal? INS_EXT_TMP { get; set; }
        public string DEAL_ID { get; set; }
        public DateTime? DATE_FROM { get; set; }
        public DateTime? DATE_TO { get; set; }
    }
}