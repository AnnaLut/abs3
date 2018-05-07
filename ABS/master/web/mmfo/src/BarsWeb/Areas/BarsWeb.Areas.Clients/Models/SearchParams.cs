using BarsWeb.Areas.Clients.Models.Enums;
using System;

namespace BarsWeb.Areas.Clients.Models
{
    public class SearchParams
    {
        public string CustomerCode { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string DocumentSerial { get; set; }
        public string DocumentNumber { get; set; }
        public DateTime? BirthDate { get; set; }
        public string Gcif { get; set; }
        public DateTime?  DateOn { get; set; }
        public string FullNameInternational { get; set; }
        public string FullName { get; set; }
        public string EddrId { get; set; }
        public CustomerType CustomerType { get; set; }

    }
}
