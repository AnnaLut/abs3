using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class ClientSearchParams
    {
        public string Inn { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string DocSerial { get; set; }
        public string DocNumber { get; set; }
        public DateTime? BirthDate { get; set; }
        public string Gcif { get; set; }
    }
}