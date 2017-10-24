using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    [XmlRoot(ElementName = "request")]
    public class PrivateEnCard
    {
        [XmlElement("batchId")]
        public string BatchId { get; set; }
        [XmlElement("kf")]
        public string Kf { get; set; }

        [XmlElement("maker")]
        public string Maker { get; set; }

        [XmlElement("privateEntrepreneur")]
        public PrivateEnPerson PrivateEnPerson { get; set; }

        public PrivateEnCard()
        {

        }

        public PrivateEnCard(string kf, string batchId, string maker, PrivateEnPerson body)
        {
            BatchId = batchId;
            Kf = kf;
            Maker = maker;
            PrivateEnPerson = body;
        }
    }
}