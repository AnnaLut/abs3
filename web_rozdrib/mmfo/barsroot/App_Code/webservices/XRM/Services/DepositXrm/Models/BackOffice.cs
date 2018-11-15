using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class BOAccessRequest
    {
        public Decimal Type { get; set; }
        public String TrusteeType { get; set; }
        public Decimal Rnk { get; set; }
        public String CertifNumber { get; set; }
        public DateTime CertifDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime FinishDate { get; set; }
        public AccessList[] AccessList { get; set; }
    }

    public class AccessList
    {
        public Decimal DepositId { get; set; }
        public Decimal Amount { get; set; }
        public Decimal FlReport { get; set; }
        public Decimal FlMoney { get; set; }
        public Decimal FlEarly { get; set; }
        public Decimal FlAgreement { get; set; }
        public Decimal FlKv { get; set; }
    }

    public class BOAccessResponse
    {
        public BOAccessResponse()
        {
            Templates = new List<TemplateDoc>();
        }

        public Decimal ReqId { get; set; }

        public List<TemplateDoc> Templates { get; set; }
    }

    public class TemplateDoc
    {
        public string Name { get; set; }
        /// <summary>
        /// Base64 content of pdf file
        /// </summary>
        public string Content { get; set; }
    }


    public class BOGetAccessRequest
    {
        public Decimal RequestId { get; set; }
        public Decimal RequestType { get; set; }
        public String TrusteeType { get; set; }
        public Decimal CustomerId { get; set; }
        public String ScAccess { get; set; }
        public String ScWarrant { get; set; }
        public String ScSignsCard { get; set; }
        public Decimal?[] Deposits { get; set; }
    }

    public class BOGetStateRequest
    {
        public Decimal RequestId { get; set; }
    }

    public class BOGetStateResponse
    {
        public  string Message { get; set; }
        public Decimal? State { get; set; }
        public String Comment { get; set; }
    }
}