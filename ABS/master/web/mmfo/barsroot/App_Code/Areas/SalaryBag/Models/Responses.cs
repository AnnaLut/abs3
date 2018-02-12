using System;

namespace Areas.SalaryBag.Models
{
    public class ResponseSB
    {
        public ResponseSB()
        {
            Result = "OK";
            ErrorMsg = "";
            ResultMsg = "";
            ResultObj = "";
        }

        public string Result { get; set; }
        public string ErrorMsg { get; set; }
        public string ResultMsg { get; set; }

		public PostFileModel PostFileModel { get; set; }																  
        public object ResultObj { get; set; }
    }
}
