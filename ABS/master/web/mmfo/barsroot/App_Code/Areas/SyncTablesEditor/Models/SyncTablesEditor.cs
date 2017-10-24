using System;

namespace Areas.SyncTablesEditor.Models
{
	public class SyncTables
	{
		public decimal TABID { get; set; }
		public string S_SELECT { get; set; }
		public string S_INSERT { get; set; }
		public string S_UPDATE { get; set; }
		public string S_DELETE { get; set; }
		public DateTime? FILE_DATE { get; set; }
		public short? SYNC_FLAG { get; set; }
		public string ENCODE { get; set; }
		public string FILE_NAME { get; set; }
		public string BRANCH { get; set; }
        public string SEMANTIC { get; set; }
        public string TABNAME { get; set; }        
    }
}
