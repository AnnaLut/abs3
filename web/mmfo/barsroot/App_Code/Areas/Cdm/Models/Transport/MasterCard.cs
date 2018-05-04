using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class MasterCard : ICard
    {
        [XmlAttribute("kf")]
        public string Kf { get; set; }

        [XmlAttribute("rnk")]
        public string Rnk { get; set; }

        [XmlElement("gcif")]
        public string Gcif { get; set; }

        [XmlElement("slaveClient")]
        public SlaveClient[] SlaveClients { get; set; }
    }
}