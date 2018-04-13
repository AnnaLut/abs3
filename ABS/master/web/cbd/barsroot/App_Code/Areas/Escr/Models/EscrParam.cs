using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrParam
    {
        public EscrRegisterForSend register { get; set; }
        public List<EscrDealParam> deals { get; set; }
    }
}