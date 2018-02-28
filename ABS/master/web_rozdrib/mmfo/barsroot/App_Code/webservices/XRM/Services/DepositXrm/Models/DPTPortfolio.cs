using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class XRMDPTPortfolioRec
    {
        public string mark;
        public decimal dpt_id;
        public string dpt_num;
        public string type_name;
        public DateTime? datz;
        public DateTime? dat_end;
        public string nls;
        public string lcv;
        public Int16 dpt_lock;
        public decimal archdoc_id;
        public decimal ostc;
        public decimal ost_int;
    }
    public class XRMDPTPortfolioRequest
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public String KF;
        public String Branch;
        public decimal RNK;
    }
    public class XRMDPTPortfolioResponce
    {
        public XRMDPTPortfolioRec[] XRMDPTPortfolioRec;
        public int ResultCode;
        public string ResultMessage;
    }
}