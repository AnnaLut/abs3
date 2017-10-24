using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "request", Namespace = "")]
    public class DupesAndGcifs
    {
        [XmlElement("batchId")]
        public string BatchId { get; set; }

        [XmlElement("kf")]
        public string Kf { get; set; }

        [XmlElement("maker")]
        public string Maker { get; set; }

        [XmlElement("client")]
        public DupPackage[] DuplicatedClients { get; set; }

        [XmlElement("masterCard")]
        public MasterCard[] MasterCards { get; set; }
    }
}