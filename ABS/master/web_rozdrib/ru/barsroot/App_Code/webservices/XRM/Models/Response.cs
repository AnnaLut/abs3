using System;

namespace Bars.WebServices.XRM.Models
{
    public class XRMResponse : IResponse
    {
        public XRMResponse()
        {
            ResultCode = 0;
            ResultMessage = "OK";
        }

        /// <summary>
        ///   0 - sucess
        ///  -1 - error
        /// </summary>
        public int ResultCode { get; set; }
        /// <summary>
        /// depends on ResultCode, if -1 then error message, else string "OK"
        /// </summary>
        public string ResultMessage { get; set; }
    }

    public class XRMResponseDetailed<T> : XRMResponse
    {
        public T Results { get; set; }
    }

    public interface IResponse
    {
        int ResultCode { get; set; }
        string ResultMessage { get; set; }
    }
}