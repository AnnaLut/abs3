using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.Glory
{
    /// <summary>
    /// Модель с данными запроса
    /// </summary>
    public class RequestModel
    {
        public String Xml { get; set; }
        public String IP { get; set; }
        public String Action { get; set; }
        public String SessionId { get; set; }
        public String Url { get; set; }
        public String IsLongRequest { get; set; }
        public String User { get; set; }
    }
}