using System;

namespace Areas.SyncTablesEditor.Models
{
    public class SelectObj
    {
        public string sql { get; set; }
    }

    public class FileInput
    {
        public string FilePath { get; set; }
        public int TabId { get; set; }
    }
}
