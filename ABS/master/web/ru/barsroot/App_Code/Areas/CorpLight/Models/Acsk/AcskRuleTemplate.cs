using System.Collections.Generic;

namespace BarsWeb.Areas.CorpLight.Models
{
    public class AcskRuleTemplate
    {
        public AcskRuleTemplate()
        {
        }

        public int? TemplateId { get; set; }
        public bool IncludeInn { get; set; }
        public bool IncludeEdrpou { get; set; }
        public string Name { get; set; }
        public string Oid { get; set; }
        public string Description { get; set; }
        public List<AcskCryptoProvider> CryptoProviders { get; set; }
        public int? KeySizeMin { get; set; }
        public int? KeySizeMax { get; set; }
        public int? KeySize { get; set; }
        public List<object> Extensions { get; set; }
        public bool IsPrintRequest { get; set; }
        public int IsPublished { get; set; }
        public int HashCertSign { get; set; }
        public int KeyType { get; set; }
        public bool UseSubjectTitle { get; set; }
        public bool UseSubjectEmail { get; set; }
        public bool UseSubjectSn { get; set; }
        public bool UseSubjectGn { get; set; }
        public bool UseSubjectMn { get; set; }
        public bool UseDescription { get; set; }
        public List<AcskDke> Dke { get; set; }
    }
}