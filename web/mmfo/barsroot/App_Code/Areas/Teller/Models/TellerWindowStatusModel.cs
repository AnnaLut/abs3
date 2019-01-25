using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// модель для запроса об состоянии окна или его изменении
    /// </summary>
    public class TellerWindowStatusModel
    {
        public Decimal Amount { get; set; }
        public String Currency { get; set; }
        public String OperDesc { get; set; }
        public String Status { get; set; }
        public String Ref { get; set; }
        public String Message { get; set; }
        public String StatusText { get; set; }
    }
}