using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Escr.Models
{
    public class ImportParams
    {
        public DateTime dealDate { get; set; }
        public string dealNumber { get; set; }
        public decimal dealSum { get; set; }
        public string okpo { get; set; }
        public string comment { get; set; }
        public decimal? regId { get; set; }
        public decimal? dealId { get; set; }
        public string status_code { get; set; }
    }
}