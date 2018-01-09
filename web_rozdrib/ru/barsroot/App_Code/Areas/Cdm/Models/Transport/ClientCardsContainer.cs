using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class ClientCardsContainer
    {
        [XmlElement("clientCard")]
        public List<BufClientData> ClientCard { get; set; }
    }
}