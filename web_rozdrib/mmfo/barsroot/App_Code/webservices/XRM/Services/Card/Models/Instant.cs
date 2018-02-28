using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.Card.Models
{
    public class XRMInstantDict
    {
        public String ProductCode;
        public String ProductName;
        public String CardCode;
        public String CardName;
        public String KV;
    }
    public class XRMInstantList
    {
        public String NLS;
        public String KV;
        public String Branch;
        public String ErrorMessage;
    }
    public class XRMInstantOrderReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Int64 KF;
        public String CardCode;
        public String Branch;
        public Int16 CardCount;
    }
}