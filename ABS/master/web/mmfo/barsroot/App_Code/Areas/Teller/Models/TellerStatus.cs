using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// информация о состоянии
    /// </summary>
    public class TellerStatus
    {
        public String TellerInfo { get; set; }
        public String tellerStatus { get; set; }
        public Int32 IsButtonVisible { get; set; }
    }
}