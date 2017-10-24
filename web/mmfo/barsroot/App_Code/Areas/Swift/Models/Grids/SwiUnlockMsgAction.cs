using System;
using System.Collections.Generic;

namespace Areas.Swift.Models
{
    public class SwiUnlockMsgAction
    {
        public string aType { get; set; }
        public List<decimal> swrefs { get; set; }
        public int p_retOpt { get; set; }
    }
}
