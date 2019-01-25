using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// возвращаемые данные
    /// </summary>
    public class TellerResponseModel
    {
        public Int32 Result { get; set; }
        public String P_errtxt { get; set; }
    }
}