using System;

namespace BarsWeb.Areas.BpkW4.Models
{
	public class BatchesMmsbResult
	{
		public decimal ID { get; set; }
		public string NAME { get; set; }
		public string CARD_CODE { get; set; }
		public string PRODNAME { get; set; }
		public decimal NUMBERCARDS { get; set; }
		public string LCV { get; set; }
		public string OB22 { get; set; }
		public string TIP { get; set; }
		public DateTime REGDATE { get; set; }
		public string LOGNAME { get; set; }
	}
}