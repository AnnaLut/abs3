using System;

namespace BarsWeb.Areas.Payreg.Models
{
    public class CustomerInfo
    {
        public decimal Rnk { get; set; }
        public string CustomerName { get; set; }
        public string Okpo { get; set; }
        public string Adr { get; set; }
        public string DocumentNumber { get; set; }
        public string Branch { get; set; }
        public DateTime? DayOfBirth { get; set; }
        public bool HasActiveAccounts { get; set; }
    }
}