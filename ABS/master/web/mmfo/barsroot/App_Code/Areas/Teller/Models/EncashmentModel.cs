using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// модель запроса инкассации
    /// </summary>
    public class EncashmentModel
    {
        public String Method { get; set; }
        public String Currency { get; set; }
        public Decimal NonAmount { get; set; }
        public String EncashmentType { get; set; }
    }
}