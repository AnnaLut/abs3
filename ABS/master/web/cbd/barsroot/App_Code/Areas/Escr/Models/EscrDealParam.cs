using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrDealParam
    {
        public EscrRegHeader credit { get; set; }
        public List<EscrHeaderEvents> events { get; set; }
    }
}