using System;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class AccessRequestReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Decimal Type;
        public String TrusteeType;
        public Decimal Rnk;
        public String CertifNumber;
        public DateTime CertifDate;
        public DateTime StartDate;
        public DateTime FinishDate;
        public AccessList[] AccessList;
    }

    public class AccessList
    {
        public Decimal DepositId;
        public Decimal Amount;
        public Decimal Fl_Report;
        public Decimal Fl_Money;
        public Decimal Fl_Early;
        public Decimal Fl_Agreement;
        public Decimal Fl_Kv;
    }

    public class AccessRequestRes
    {
        public Int16 ResultCode;
        public String ResultMessage;
        public Decimal ReqId;
    }

    public class BackOfficeGetAccessReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Decimal Req_id;
        public Decimal Req_type;
        public String TrusteeType;
        public Decimal Cust_id;
        public String ScAccess;
        public String ScWarrant;
        public String ScSignsCard;
        public Decimal?[] Deposits;
    }

    public class BackOfficeGetAccessRes
    {
        public Decimal ResultCode;
        public String ResultMessage;
    }

    public class BackOfficeGetStateProcReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Decimal ReqId;
    }

    public class BackOfficeGetStateProcRes
    {
        public Decimal? State;
        public String Comment;
        public Int32 ResultCode;
        public String ResultMessage;
    }
}