using System;
using System.Collections.Specialized;

namespace Bars.WebServices.MSP
{
    /// <summary>
    /// Summary description for HeaderParser
    /// </summary>
    public class HeaderParser
    {
        const string ActionTypeHeaderKey = "Action-Type";

        public HeaderParser()
        {

        }

        public int Parse(NameValueCollection headers)
        {           
            string value = headers[ActionTypeHeaderKey];
            if (string.IsNullOrEmpty(value))
                return -1;

            return Convert.ToInt32(value);
        }
    }
}

