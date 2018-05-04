using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEntrepreneurAdditionalInformationV2 : AdditionalInformationV2
    {
        // Належність до малого бізнесу
        [XmlElement("smallBusinessBelonging")]
        public string SmallBusinessBelonging { get; set; }
        public bool ShouldSerializeSmallBusinessBelonging() { return !string.IsNullOrWhiteSpace(SmallBusinessBelonging); }
    }
}