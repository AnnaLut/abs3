using System.Collections.Generic;
using System.Xml.Serialization;
using BarsWeb.Areas.Cdm.Models.Transport.Legal;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "request")]
    public class LegalCards
    {
        [XmlElement("batchId")]
        public string BatchId { get; set; }
        [XmlElement("kf")]
        public string Kf { get; set; }

        [XmlElement("maker")]
        public string Maker { get; set; }

        [XmlElement("legalPersons")]
        public LegalPersonsContainer LegalPersonsContainer { get; set; }

        public LegalCards()
        {
            
        }

        public LegalCards(string kf, string batchId, string maker, List<LegalPerson> body)
        {
            BatchId = batchId;
            Kf = kf;
            Maker = maker;
            LegalPersonsContainer = new LegalPersonsContainer
            {
                LegalPerosns = body
            };
        }

    }

}


