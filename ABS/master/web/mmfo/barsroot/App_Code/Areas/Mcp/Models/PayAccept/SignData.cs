using System;

namespace Areas.Mcp.Models
{
    public class SignData
    {
        public decimal id { get; set; }
        public short kvitId { get; set; }
        public string sign { get; set; }
        public short type { get; set; }
    }

    public class SignDataAll
    {
        public string paymentType { get; set; }
        public string paymentPeriod { get; set; }
    }
}
