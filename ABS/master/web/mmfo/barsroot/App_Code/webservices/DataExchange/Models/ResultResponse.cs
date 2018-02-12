using System;

namespace Bars.WebServices.DataExchangeService
{
    public class ResultResponse
    {
        public String message { get; set; }
        public Decimal? status { get; set; }
        public String StackTrace { get; set; }
    }   
}