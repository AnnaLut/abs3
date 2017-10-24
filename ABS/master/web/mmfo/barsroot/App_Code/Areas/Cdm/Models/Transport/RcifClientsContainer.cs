using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class RcifClientsContainer
    {
        [XmlElement("rcifClient")]
        public RcifClient RcifClient { get; set; }
    }
}