using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalPersonsContainer
    {
        [XmlElement("legalPerson")]
        public List<LegalPerson> LegalPerosns { get; set; }
    }
}