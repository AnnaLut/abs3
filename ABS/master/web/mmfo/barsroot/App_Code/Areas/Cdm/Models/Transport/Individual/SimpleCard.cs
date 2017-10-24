using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Individual
{
    [XmlRoot(ElementName = "request")]
    public class SimpleCard
    {
        [XmlElement("batchId")]
        public string BatchId { get; set; }
        [XmlElement("kf")]
        public string Kf { get; set; }

        [XmlElement("maker")]
        public string Maker { get; set; }

        [XmlElement("individualPerson")]
        public BufClientData ClientCard { get; set; }

        public SimpleCard()
        {

        }
        public SimpleCard(string kf, string batchId, string maker, BufClientData body)
        {
            BatchId = batchId;
            Kf = kf;
            Maker = maker;
            ClientCard = body;
        }

    }
}