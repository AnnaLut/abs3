using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.Card.Models
{
    public class XRMOpenCardReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public Int64 KF;
        public String Branch;
        public Int64 Rnk;
        public String Nls;
        public String Cardcode;
        public String Embfirstname;
        public String Emblastname;
        public String Secname;
        public String Work;
        public String Office;
        public DateTime? Wdate;
        public Int64? Salaryproect;
        public Int32 Term;
        public String Branchissue;
        public String Barcode;
        public String Cobrandid;
    }
    public class XRMOpenCardResult
    {
        public Decimal nd;
        public Decimal acc;
        public String NLS;
        public String daos;
        public String date_begin;
        public Int32 status;
        public Int32 blkd;
        public Int32 blkk;
        public String dkbo_num;
        public String dkbo_in;
        public String dkbo_out;
        public Int32 ResultCode;
        public String ResultMessage;
    }
}