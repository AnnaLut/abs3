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
    }
}
