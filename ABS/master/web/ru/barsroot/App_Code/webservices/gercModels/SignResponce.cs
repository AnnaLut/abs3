using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Summary description for SignResponce
    /// </summary>
    public class SignResponce
    {
        public string Sign { set; get; }
        public string State { set; get; }
        public string Error { set; get; }
    }
}