using System;

namespace Areas.BatchOpeningCardAccounts.Models
{
	public class BatchCardAccount
	{
		public decimal ID { get; set; }
		public string FILE_NAME { get; set; }
		public string ZIPFILE_NAME { get; set; }
		public DateTime? FILE_DATE { get; set; }
		public string CARD_CODE { get; set; }
		public string BRANCH { get; set; }
		public decimal? ISP { get; set; }
		public decimal? PROECT_ID { get; set; }
		public decimal? FILE_N { get; set; }
		public decimal? FILE_TYPE { get; set; }
		public decimal? STATE { get; set; }
		public string KF { get; set; }
	}
}
