using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Pfu.Models.ApiModels
{
    public class ResponseDataBase
    {
        public int Status { get; set; }
    }

    public class ResponseDataResult
    {
        public int State { get; set; }
        public string Message { get; set; }
        public string Data { get; set; }
    }

    /// <summary>
    /// Default answer model for API call
    /// </summary>
    public class ResponseData : ResponseDataBase
    {
        public string ErrorMessage { get; set; }
        public string ErrorStackTrace { get; set; }
        public ResponseDataResult Result { get; set; }
    }
}