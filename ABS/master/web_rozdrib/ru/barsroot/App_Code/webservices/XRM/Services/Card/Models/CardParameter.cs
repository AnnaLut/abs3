using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.Card.Models
{
    public class XRMCardParam
    {
        public String TAG;
        public String VAL;
        public String ERR;
    }
    public class XRMCardParams
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Int64 KF;
        public String ND;
        public String ErrorMessage;
        public XRMCardParam[] XRMCardParamList;
    }
}