using System.Collections.Generic;
using System.Xml.Serialization;
using BarsWeb.Areas.Cdm.Models.Transport.PrivateEn;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "request")]
    public class PrivateEnCards
    {
        [XmlElement("kf")]
        public string Kf { get; set; }

        [XmlElement("batchId")]
        public string BatchId { get; set; }

        [XmlElement("maker")]
        public string Maker { get; set; }

        [XmlElement("privateEntrepreneurs")]
        public PrivateEnContainer PrivateEnContainer { get; set; }

        public PrivateEnCards()
        {

        }
        public PrivateEnCards(string kf, string batchId, string maker, List<PrivateEnPerson> body)
        {
            BatchId = batchId;
            Kf = kf;
            Maker = maker;
            PrivateEnContainer = new PrivateEnContainer
            {
                PrivateEnPersons = body
            };
        }
    }
}