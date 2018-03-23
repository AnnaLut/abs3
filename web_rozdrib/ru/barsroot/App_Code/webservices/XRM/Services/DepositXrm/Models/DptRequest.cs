using Bars.Requests;
using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class XRMDptRequestReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public String KF;
        public String Branch;
        public decimal req_type;
        public string TrusteeType;
        public decimal cust_id;
        public string CertifNum;
        public DateTime CertifDate;
        public DateTime DateStart;
        public DateTime DateFinish;
        public List<AccessInfo> AccessList;
    }
    public class XRMDptRequestRes
    {
        public decimal req_id;
        //public byte[] Doc;
        public string Doc;
        public decimal Status;
        public string ErrMessage;
    }
    public class XRMDptRequestStateReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public String KF;
        public String Branch;
        public decimal req_id;
    }
    public class XRMDptRequestStateRes
    {
        public decimal RequestState;
        public string RequestMessage;
        public decimal Status;
        public string ErrMessage;
    }
}