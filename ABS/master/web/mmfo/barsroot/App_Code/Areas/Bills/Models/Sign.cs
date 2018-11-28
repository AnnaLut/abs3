using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель данных подписи!
    /// </summary>
    public class Sign
    {
        public Int32 EXP_ID { get; set; }
        public String SIGNER { get; set; }
        public Byte[] SIGNATURE { get; set; }
        public String SignString { get; set; }
    }
}