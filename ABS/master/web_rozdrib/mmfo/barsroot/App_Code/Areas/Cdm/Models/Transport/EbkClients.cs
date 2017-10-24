using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "response")]
    public class EbkClients
    {
        [XmlElement("status")]
        public string Status { get; set; }

        [XmlElement("msg")]
        public string Msg { get; set; }

        [XmlElement("qualityClients")]
        public QualityClient QualityClient { get; set; }
    }
}