using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.Card.Models
{
    public class XRMArrestAccReq
    {
        public string UserLogin;
        public decimal TransactionId;
        public string Branch;
        public string Nls;
        public int Kv;
        public int Blkd;
        public int Blkk;
    }

    public class XRMArrestAccRes
    {
        public string status;
        public string message;
    }
}