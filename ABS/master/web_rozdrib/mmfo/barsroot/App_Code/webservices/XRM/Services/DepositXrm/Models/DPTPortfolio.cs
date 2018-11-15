using System;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class PortfolioRecord
    {
        public decimal DepositId { get; set; }
        public string DepositNumber { get; set; }
        public string TypeName { get; set; }
        public DateTime? DateZ { get; set; }
        public DateTime? DateEnd { get; set; }
        public string Nls { get; set; }
        public string Lcv { get; set; }
        public Int16 DepositLock { get; set; }
        public decimal ArchiveDocId { get; set; }
        public decimal OstC { get; set; }
        public decimal OstInt { get; set; }
    }
    public class PortfolioRequest
    {
        public string Kf { get; set; }
        public string Branch { get; set; }
        public decimal Rnk { get; set; }
    }
}