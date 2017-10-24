using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Individual
{
    public class ClientCardsContainer
    {
        [XmlElement("individualPerson")]
        public List<BufClientData> ClientCard { get; set; }
    }
}