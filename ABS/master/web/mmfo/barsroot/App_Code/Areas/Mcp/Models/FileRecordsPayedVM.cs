using System;

namespace Areas.Mcp.Models
{
    public class FileRecordsPayedVM
    {
        public DateTime? Date { get; set; }
        public decimal[] FileRecords { get; set; }
    }
}