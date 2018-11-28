using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель счетов клиента
    /// </summary>
    public class ReceiverAccounts
    {
        public String KF { get; set; }
        public Int64 RNK { get; set; }
        public Decimal ACC { get; set; }
        public String NLS { get; set; }
        public String OB22 { get; set; }
        public Int32 KV { get; set; }
        public String NMS { get; set; }
    }
}