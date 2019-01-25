using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// модель инкассации
    /// </summary>
    public class TellerEncashmentList
    {
        public Int32 Id { get; set; }
        public DateTime Last_DT { get; set; }
        public Decimal Cur_code { get; set; }
        public Decimal? Amount { get; set; }
        public Decimal? Doc_ref { get; set; }
        public String Cash_direction { get; set; }
        public String Oper_status { get; set; }
        public Int32 CanDelete { get; set; }
    }
}