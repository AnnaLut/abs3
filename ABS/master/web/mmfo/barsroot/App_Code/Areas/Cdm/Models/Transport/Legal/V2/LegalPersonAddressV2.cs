using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalPersonAddressV2 : AddressV2
    {
        // Країна клієнта (К040)
        [XmlElement("k040")]
        public decimal? K040 { get; set; }
        public bool ShouldSerializeK040() { return null != K040; }

        // Вул.,буд., кв
        [XmlElement("fullAddress")]
        public string FullAddress { get; set; }
        public bool ShouldSerializeFullAddress() { return !string.IsNullOrWhiteSpace(FullAddress); }
    }
}