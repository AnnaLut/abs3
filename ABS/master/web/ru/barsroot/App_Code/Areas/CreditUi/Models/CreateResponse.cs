using System;
using System.Linq;
using System.Collections.Generic;

namespace BarsWeb.Areas.CreditUi.Models
{
    public class CreateResponse
    {
        public decimal? referense { get; set; }
        public bool error { get; set; }
        public string nlsb { get; set; }
    }
}