using System;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class DepositAgreementAddInfo
    {
        public long? AgreementId { get; set; }
        public int? AgreementType { get; set; }
        public long? DocId { get; set; }
        public long? ArchdocId { get; set; }
        public int? Status { get; set; }
        public int? IsSigned { get; set; }
        public DateTime? ConclusionDate { get; set; }
        public DateTime? DateBegin { get; set; }
        public DateTime? DateEnd { get; set; }
        public long? ClientRNK { get; set; }
    }
}