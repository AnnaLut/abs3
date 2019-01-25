using BarsWeb.Areas.Teller.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// статус состояния АТМ
    /// </summary>
    public class TellerStatusModel
    {
        public TellerStatusCode TellerStatusCode { get; set; }
        public String Message { get; set; }
    }
}