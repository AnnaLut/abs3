using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.WebApi.OnlineWay4.Models
{
    public class InfoRecord
    {
        public long ID { get; set; }
        public string ContractNumber { get; set; }
        public string RBSNumber { get; set; }
        public string ContractName { get; set; }
        public string ProductCode { get; set; }
        public string ContractStatus { get; set; }
        public string IsReady { get; set; }
        public decimal AmountAvailable { get; set; }
        public decimal TotalBalance { get; set; }
        public decimal TotalBlocked { get; set; }
        public decimal CreditLimit { get; set; }
        public decimal Virtual { get; set; }
        public decimal Savings { get; set; }
        public string Currency { get; set; }
        public string AddInfo { get; set; }
    }
}