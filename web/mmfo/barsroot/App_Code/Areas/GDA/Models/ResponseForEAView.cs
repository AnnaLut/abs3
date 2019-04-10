using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Areas.GDA.Models
{
    /// <summary>
    /// Модель для отображения данных с Электронного архива
    /// </summary>
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