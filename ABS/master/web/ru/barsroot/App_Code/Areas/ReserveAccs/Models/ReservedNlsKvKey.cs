namespace BarsWeb.Areas.ReserveAccs.Models.Bases
{ 
	public class ReservedNlsKvKey
	{
		public string nls { get; set; }
		public int kv { get; set; }
	}
	public class ReservedPrintKey : ReservedNlsKvKey
	{
		public string templateId { get; set; }
	}
}