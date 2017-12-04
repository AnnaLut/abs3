using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.PfuSync.SyncModels
{
    public class RuResponse
    {
        public decimal Total { get; set; }
        public string Tag { get; set; }
        public string Data { get; set; }
        public string State { get; set; }
        public string Error { get; set; }
    }
}