using System;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class ClientSearchParams
    {
        public decimal? Rnk { get; set; }
        public string Inn { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string DocSerial { get; set; }
        public string DocNumber { get; set; }
        public DateTime? BirthDate { get; set; }
        public string Gcif { get; set; }
        public string EddrId { get; set; }
        public string CustomerType { get; set; }
        public DateTime? DateOn { get; set; }
        public string FullName { get; set; }
        public string FullNameInternational { get; set; }
    }
}