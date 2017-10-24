using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class OnlineClientCardContainer
    {
        [XmlElement("clientAnalysis")]
        public ClientAnalysis ClientCard { get; set; }

        [XmlElement("duplicateClient")]
        public DupClientContainer OnlineDupes { get; set; }

        [XmlElement("gcif")]
        public string Gcif { get; set; }

        [XmlElement("onlineStatus")]
        public string OnlineStatus { get; set; }
    }
}