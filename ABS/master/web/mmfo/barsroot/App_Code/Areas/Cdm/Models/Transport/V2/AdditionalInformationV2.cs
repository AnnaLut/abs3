using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class AdditionalInformationV2
    {
        // Клас позичальника
        [XmlElement("borrowerClass")]
        public string BorrowerClass { get; set; }
        public bool ShouldSerializeBorrowerClass() { return !string.IsNullOrWhiteSpace(BorrowerClass); }
    }
}