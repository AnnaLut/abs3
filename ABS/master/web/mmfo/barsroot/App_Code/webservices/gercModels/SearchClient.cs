using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// класс реквизитов поиска клиентов
    public class SearchClient
    {
        public Decimal? Rnk { get; set; }
        public string OKPO { get; set; }
        public string Nmk { get; set; }
        public Decimal? CUSTTYPE { get; set; }
        public Decimal? PASSP { get; set; }
        public string SER { get; set; }
        public string DOCNUM { get; set; }
    }
}