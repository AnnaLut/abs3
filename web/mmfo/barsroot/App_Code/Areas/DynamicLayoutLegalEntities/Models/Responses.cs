using System;

namespace Areas.DynamicLayoutLegalEntities.Models
{
    public class ResponseDL
    {
        public ResponseDL()
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
