using System;

namespace BarsWeb.Areas.WebApi.OnlineWay4.Models
{
    public class IssPaymentRequest
    {
        public string UniqueRefNumber { get; set; }

        public string MsgCode { get; set; }

        public string RRN { get; set; }

        public string ContractSearchMethod { get; set; }

        public string ContractScope { get; set; }

        public string ContractIdentifier { get; set; }

        public string ContractRelation { get; set; }

        public string CardSequenceNumber { get; set; }

        public string ExpirationDate { get; set; }

        public string SourceMemberID { get; set; }

        public string SourceContractNumber { get; set; }

        public decimal Amount { get; set; }

        public string Currency { get; set; }

        public string TransactionAttributes { get; set; }

        public string TransactionDetails { get; set; }

        public DateTime? TransactionDate { get; set; }

        public string CustomData { get; set; }

        public string OperatorID { get; set; }

        //public DateTime? PostingDate { get; set; }

        public string UserInfo { get; set; }
    }
}
