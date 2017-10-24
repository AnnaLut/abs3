using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class DupClientContainer
    {
        [XmlElement("duplicateClient")]
        public DupClient[] Duplicate { get; set; }
    }
}