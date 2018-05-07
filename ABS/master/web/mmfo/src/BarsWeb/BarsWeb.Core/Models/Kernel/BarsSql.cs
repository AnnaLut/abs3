using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Core.Models.Kernel
{
    public class BarsSql
    {
        public string SqlText { get; set; }
        public object[] SqlParams { get; set; }
    }
}