using System;

namespace BarsWeb.Areas.CorpLight.Models.Acsk
{
    public class AcskCertificate
    {
        public decimal? Id { get; set; }
        public decimal? RelCustId { get; set; }
        public DateTime? RequesTime { get; set; }
        public int? RequestState { get; set; }
        public string CertificateSn { get; set; }
        public string RequestStateMessage { get; set; }
        public string TemplateName { get; set; }
        public string TemplateOid { get; set; }
        public string CertificateId { get; set; }
        public string CertificateBody { get; set; }
        public int? RevokeCode { get; set; }
        public string TokenSn { get; set; }
        public string TokenName { get; set; }
    }
}