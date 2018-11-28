using System;

namespace Areas.EDeclarations.Models
{
	public class EDECL
	{
		public decimal ID { get; set; }
		public long NUMIDENT { get; set; }
		public DateTime? BIRTH_DATE { get; set; }
		public short? DOC_TYPE { get; set; }
		public string DOC_SERIAL { get; set; }
		public decimal? DOC_NUMBER { get; set; }
		public DateTime DATE_FROM { get; set; }
		public DateTime DATE_TO { get; set; }
		public string NAME { get; set; }
		public short? STATE { get; set; }
		public DateTime? CREATE_DATE { get; set; }
	}
}
