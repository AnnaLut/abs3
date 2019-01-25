using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// модель для работы со всплывающим окном
    /// </summary>
    public class ATMModel
    {
        public Int32 SbonFlag { get; set; }
        public String Ref { get; set; }
        public Decimal Amount { get; set; }
        public Decimal NonAmount { get; set; }
        public String Method { get; set; }

        public Boolean RJ = false;

        public String isSWI = "0";
    }
}