using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// модель запроса
    /// </summary>
    public class TellerRequestModel
    {
        public String Sql { get; set; }
        public List<Decimal> Ref { get; set; }
        public String Method { get; set; }
    }
}