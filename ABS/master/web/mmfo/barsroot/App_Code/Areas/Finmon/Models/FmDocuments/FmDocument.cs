using System;

namespace Areas.Finmom.Models
{
    public class Document : DocumentBase
    {
        public Document()
        {
            Otm = "";
        }
        public decimal? Id { get; set; }
        public decimal? Ref { get; set; }
        public string Tt { get; set; }
        public string Nd { get; set; }
        public decimal? SumEquivalent { get; set; }
        public short? Dk { get; set; }
        public decimal? Sum2 { get; set; }
        public decimal? SumEquivalent2 { get; set; }
        public string Lcv2 { get; set; }
        public short? Sk { get; set; }
        public DateTime? VDate { get; set; }
        public string Otm { get; set; }
        public string Tobo { get; set; }
        public string Fio { get; set; }
        public DateTime? InDate { get; set; }
        public string Comments { get; set; }
        public string Rules { get; set; }
        public string StatusName { get; set; }
        public short? Sos { get; set; }
        public string Fv2Agg { get; set; }
    }

    public class DocumentBase
    {
        public string NlsA { get; set; }
        public string NlsB { get; set; }
        public string Nazn { get; set; }
        public string Lcv { get; set; }
        public decimal? Sum { get; set; }
        public string MfoA { get; set; }
        public string MfoB { get; set; }
        public string NameA { get; set; }
        public string NameB { get; set; }
        public string OprVid2 { get; set; }
        public string OprVid3 { get; set; }
        public string Status { get; set; }
        public DateTime? DateD { get; set; }
    }
}