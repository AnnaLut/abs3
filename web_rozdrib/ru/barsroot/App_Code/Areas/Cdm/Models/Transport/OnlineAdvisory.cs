using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "response")]
    public class OnlineAdvisory : Response
    {
        [XmlElement("onlineClientCardResp")]
        public OnlineClientCardContainer OnlineClientCard { get; set; }
    }
}