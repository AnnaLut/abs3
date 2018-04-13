using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Escr.Models
{
    public class GroupByParams
    {
        public DateTime dateFrom { get; set; }
        public DateTime dateTo { get; set; }
        public string type { get; set; }
        public string kind { get; set; }
        public decimal reg_level { get; set; }
        public List<decimal> registers { get; set; }
    }
}