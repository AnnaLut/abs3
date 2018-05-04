using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalPersonAdditionalInformationV2:AdditionalInformationV2
    {
        // Рег. № холдингу
        [XmlElement("regionalHoldingNumber")]
        public string RegionalHoldingNumber { get; set; }
        public bool ShouldSerializeRegionalHoldingNumber() { return null != RegionalHoldingNumber; }
    }
}