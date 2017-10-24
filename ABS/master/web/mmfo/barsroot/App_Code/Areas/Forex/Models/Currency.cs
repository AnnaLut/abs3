using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Forex.Models
{
    public class Currency
    {
        public string ISO { get; set; }
        public string NAME { get; set; }
        public decimal NDIG { get; set; }
        public decimal VES { get; set; }
    }
}