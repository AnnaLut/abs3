using System;

namespace Areas.Mcp.Models
{
    public class Payment
    {
        public string SenderBankId { get; set; }
        public string SenderAccNum { get; set; }
        public string SenderCustCode { get; set; }
        public string SenderName { get; set; }
        public string RecipientBankId { get; set; }
        public string RecipientAccNum { get; set; }
        public string RecipientCustCode { get; set; }
        public string RecipientName { get; set; }
        public string OpCode { get; set; }
        public string Narrative { get; set; }
        public decimal? Sum { get; set; }
    }
}