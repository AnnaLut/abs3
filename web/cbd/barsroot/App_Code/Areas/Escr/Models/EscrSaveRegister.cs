using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrSaveRegister
    {
        public DateTime dateFrom { get; set; }
        public DateTime dateTo { get; set; }
        public string type { get; set; }
        public string kind { get; set; }
        public List<decimal> deals { get; set; }
    }
}