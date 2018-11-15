using System;
using System.Collections.Generic;


namespace Areas.Way4Bpk.Models
{
    public class ResponseForEaView
    {
        public ResponseForEaView()
        {
            Result = "OK";
            ErrorMsg = "";
            ResultMsg = "";
            ResultObj = "";
        }

        public string Result { get; set; }
        public string ErrorMsg { get; set; }
        public string ResultMsg { get; set; }

        public object ResultObj { get; set; }
    }
}