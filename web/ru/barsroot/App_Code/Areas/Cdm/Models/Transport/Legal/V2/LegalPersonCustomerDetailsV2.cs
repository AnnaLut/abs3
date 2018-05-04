using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalPersonCustomerDetailsV2
    {
        // Найменування по статуту
        [XmlElement("nameByStatus")]
        public string NameByStatus { get; set; }
        public bool ShouldSerializeNameByStatus() { return !string.IsNullOrWhiteSpace(NameByStatus); }
    }
}