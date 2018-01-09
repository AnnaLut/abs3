using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "request", Namespace = "")]
    public class AdvisoryCards
    {
        [XmlElement("batchId")]
        public string BatchId { get; set; }
        
        [XmlElement("kf")]
        public string Kf { get; set; }
        [XmlElement("maker")]
        public string Maker { get; set; }
        
        [XmlElement("clientAnalysis")]
        public ClientAnalysis[] ClientsAnalysis { get; set; }

        /*[XmlElement("errorClient")]
        public ErrorClient[] ErrorsClient { get; set; }*/
    }
}