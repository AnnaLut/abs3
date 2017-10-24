using System;

namespace BarsWeb.Areas.Mbdk.Models
{
    public class UpdateDealResponse
    {
        /// <summary>
        /// "OK" if successful , "ERROR" if not
        /// </summary>
        public string result { get; set; }

        /// <summary>
        /// if result = "ERROR" here will be error message
        /// </summary>
        public string error { get; set; }
    }
}