using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class Payment
    {
        public int? id { get; set; }
        public DateTime date { get; set; }
        public decimal payment { get; set; }
        public string number { get; set; }
        public string purpose { get; set; }
        public string state { get; set; }
        public string recipientName { get; set; }
        public string recipientCode { get; set; }
        public string recipientBankMfo { get; set; }
        public string recipientAccountNumber { get; set; }
        public string senderName { get; set; }
        public string senderCode { get; set; }
        public string senderBankMfo { get; set; }
        public string senderAccountNumber { get; set; }
        public int? externalId { get; set; }
        public DateTime created { get; set; }
        public DateTime stateChanged { get; set; }
        public decimal? commission { get; set; }
        public string commissionType { get; set; }
    }
}