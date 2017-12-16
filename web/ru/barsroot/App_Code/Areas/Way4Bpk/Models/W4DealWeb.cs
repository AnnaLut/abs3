using System;

namespace Areas.Way4Bpk.Models
{
	public class W4DealWeb
	{
		public decimal? ND { get; set; }
		public string BRANCH { get; set; }
		public string CARD_CODE { get; set; }
		public string PRODUCT_CODE { get; set; }
		public decimal? ACC_ACC { get; set; }
		public string ACC_NLS { get; set; }
		public short? ACC_KV { get; set; }
		public string ACC_LCV { get; set; }
		public string ACC_OB22 { get; set; }
		public string ACC_TIP { get; set; }
		public string ACC_TIPNAME { get; set; }
		public decimal? ACC_OST { get; set; }
		public DateTime? ACC_DAOS { get; set; }
		public DateTime? ACC_DAZS { get; set; }
		public decimal? CUST_RNK { get; set; }
		public string CUST_NAME { get; set; }
		public string CUST_OKPO { get; set; }
		public short? CUST_TYPE { get; set; }
		public DateTime? CARD_IDAT { get; set; }
		public DateTime? CARD_IDAT2 { get; set; }
		public DateTime? CARD_IDAT_BANKDATE { get; set; }
		public string DOC_ID { get; set; }
		public string BARCOD { get; set; }
		public string COBRANDID { get; set; }
		public decimal? ISDKBO { get; set; }
		public long? DKBO_ID { get; set; }
		public string DKBO_NUMBER { get; set; }
		public DateTime? DKBO_DATE_FROM { get; set; }
		public DateTime? DKBO_DATE_TO { get; set; }
		public int? DEAL_TYPE_ID { get; set; }
		public int? DEAL_STATE_ID { get; set; }
		public DateTime? CARD_DATE_FROM { get; set; }
		public DateTime? CARD_DATE_TO { get; set; }
		public string SED { get; set; }
		public decimal? IS_ACC_CLOSE { get; set; }
        public DateTime? PASS_DATE { get; set; }
        public int? PASS_STATE { get; set; }
    }
}
