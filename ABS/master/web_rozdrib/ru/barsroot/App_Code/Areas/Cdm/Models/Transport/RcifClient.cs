using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class RcifClient
    {
        [XmlAttribute("kf")]
        public string Kf { get; set; }

        [XmlAttribute("rnk")]
        public decimal Rnk { get; set; }

        [XmlElement("rcif")]
        public string Rcif { get; set; }
    }
}