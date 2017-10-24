using BarsWeb.Areas.Cdm.Models.Transport.Individual;
using BarsWeb.Areas.Cdm.Models.Transport.Legal;
using BarsWeb.Areas.Cdm.Models.Transport.PrivateEn;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class QualityClientsContainer
    {
        [XmlElement("individualPerson")]
        public BufClientData ClientCard { get; set; }

        [XmlElement("legalPerson")]
        public LegalPerson ClientLegalCard { get; set; }

        [XmlElement("privateEntrepreneur")]
        public PrivateEnPerson ClientPrivateEnCard { get; set; }
    }
}