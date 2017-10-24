using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class QualityClientsContainer
    {
        [XmlElement("clientCard")]
        public BufClientData ClientCard { get; set; }

        //qualityAttr
    }
}