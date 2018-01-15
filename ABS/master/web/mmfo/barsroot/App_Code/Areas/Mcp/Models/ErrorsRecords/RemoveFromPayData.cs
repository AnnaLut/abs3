using System;

namespace Areas.Mcp.Models
{
    public class RemoveFromPayData
    {
        public decimal id { get; set; }
        public string comment { get; set; }
        public short block_type { get; set; }
    }
}