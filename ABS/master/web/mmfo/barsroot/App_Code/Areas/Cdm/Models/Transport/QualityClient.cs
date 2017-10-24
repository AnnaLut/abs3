using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class QualityClient
    {
        [XmlElement("qualityClient")]
        public QualityClientsContainer[] FindedClientsCards { get; set; }
    }
}