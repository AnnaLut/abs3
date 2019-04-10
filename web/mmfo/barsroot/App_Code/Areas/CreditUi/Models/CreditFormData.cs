using System;
using System.Linq;
using System.Collections.Generic;

namespace BarsWeb.Areas.CreditUi.Models
{
    public class CreditFormData
    {
        public CreateDeal Deal { get; set; }
        public IQueryable<MultiExtInt> MultiInts { get; set; }
        public GKD DealGkd { get; set; }
    }
}