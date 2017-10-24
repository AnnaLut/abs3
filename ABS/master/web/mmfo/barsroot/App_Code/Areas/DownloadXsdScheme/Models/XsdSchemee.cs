using System;

namespace Areas.DownloadXsdScheme.Models
{
	public class XsdSchemee
	{
		public int FILE_ID { get; set; }
		public string FILE_CODE { get; set; }
		public string FILE_NAME { get; set; }
		public DateTime? SCHEMA_DATE { get; set; }
		public DateTime? CHANGE_DATE { get; set; }
		public string XSD { get; set; }
	}
}
