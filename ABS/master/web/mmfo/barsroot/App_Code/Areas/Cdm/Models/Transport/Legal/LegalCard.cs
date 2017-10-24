using System.Collections.Generic;
using System.Xml.Serialization;
using BarsWeb.Areas.Cdm.Models.Transport.Legal;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "request")]
    public class LegalCard
    {
        [XmlElement("batchId")]
        public string BatchId { get; set; }
        [XmlElement("kf")]
        public string Kf { get; set; }

        [XmlElement("maker")]
        public string Maker { get; set; }

        [XmlElement("legalPerson")]
        public LegalPerson LegalPersonCard { get; set; }

        public LegalCard()
        {
            
        }
        public LegalCard(string kf, string batchId, string maker, LegalPerson body)
        {
            BatchId = batchId;
            Kf = kf;
            Maker = maker;
            LegalPersonCard = body;
        }

    }

}


