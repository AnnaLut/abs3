using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.Card.Models
{
    public class XRMBulkCardReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Int64 KF;
        public string Branch;
        public string ext_id;
        public string type_code;
        public string receiver_url;
        public String request_data;
        public String hash;
    }
    public class XRMBulkCardRes
    {
        public decimal BulkID;
        public int ResultCode;
        public string ResultMessage;
    }

    public class XRMBulkCardTicketReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Int64 KF;
        public string Branch;
        public decimal BulkID;
    }
    public class XRMBulkCardTicketRes
    {
        public string Ticket;
        public int ResultCode;
        public string ResultMessage;
    }
}