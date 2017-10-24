using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class DupClient
    {
        [XmlAttribute("kf")]
        public string Kf { get; set; }

        [XmlAttribute("rnk")]
        public string Rnk { get; set; }
    }
}