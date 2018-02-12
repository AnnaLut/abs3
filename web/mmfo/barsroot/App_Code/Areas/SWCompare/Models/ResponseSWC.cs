using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.SWCompare.Models
{
    public class ResponseSWC
    {
        public ResponseSWC()
        {
            Result = "OK";
            ErrorMsg = "";
            ResultMsg = "";
            ResultObj = "";
        }

        public string Result { get; set; }
        public string ErrorMsg { get; set; }
        public string ResultMsg { get; set; }
        public decimal Total { get; set; }

        public object ResultObj { get; set; }
    }
}
