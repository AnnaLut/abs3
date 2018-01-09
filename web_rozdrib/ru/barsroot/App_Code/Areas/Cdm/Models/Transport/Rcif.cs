using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "request")]
    public class Rcif
    {
        [XmlElement("batchId")]
        public string BatchId { get; set; }
        [XmlElement("kf")]
        public string Kf { get; set; }
        [XmlElement("maker")]
        public string Maker { get; set; }
        [XmlElement("rcifClients")]
        public RcifClientsContainer[] RcifClients { get; set; }
    }
}