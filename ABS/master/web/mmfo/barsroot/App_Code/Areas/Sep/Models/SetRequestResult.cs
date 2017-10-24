using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Sep.Models
{
    public class SetRequestResult
    {
        public SetRequestResult(string nd, string error)
        {
            ND = nd;
            ERROR = error;
        }
        public string ND { get; set; }
        public string ERROR { get; set; }
    }
}