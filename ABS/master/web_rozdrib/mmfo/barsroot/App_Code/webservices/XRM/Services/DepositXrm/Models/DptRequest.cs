using Bars.Requests;
using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class RequestCreateRequest
    {
        public string Kf { get; set; }
        public string Branch { get; set; }
        public decimal RequestType { get; set; }
        public string TrusteeType { get; set; }
        public decimal CustomerId { get; set; }
        public string CertificateNumber { get; set; }
        public DateTime CertificateDate { get; set; }
        public DateTime DateStart { get; set; }
        public DateTime DateFinish { get; set; }
        public List<AccessInfo> AccessList { get; set; }
    }
    public class RequestCreateResponse
    {
        public decimal RequestId { get; set; }
        public string Doc { get; set; }
    }
    public class RequestStateRequest
    {
        public string Kf { get; set; }
        public string Branch { get; set; }
        public decimal RequestId { get; set; }
    }
    public class RequestStateResponse
    {
        public decimal RequestState { get; set; }
        public string RequestMessage { get; set; }
    }
}