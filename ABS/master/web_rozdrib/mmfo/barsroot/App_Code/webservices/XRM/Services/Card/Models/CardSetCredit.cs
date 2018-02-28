using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.Card.Models
{
    public class XRMCardCreditReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Int64 KF;                //delete this
        public long[] acc;
        public decimal maxSum;
        public decimal desiredSum;
        public decimal installedSum;
        public string[] template;
    }
    public class XRMCardCreditRes
    {
        public long[] acc;
        //public byte[] Docs;
        public string Docs;
        public int ResultCode;
        public string ResultMessage;
    }
}