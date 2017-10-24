using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "request")]
    public class Card
    {
        [XmlElement("batchId")]
        public string BatchId { get; set; }
        [XmlElement("kf")]
        public string Kf { get; set; }

        [XmlElement("maker")]
        public string Maker { get; set; }
        
        [XmlElement("clientsCards")]
        public ClientCardsContainer ClientCard { get; set; }

        public Card()
        {
            
        }

        public Card(string kf, string batchId, string maker, List<BufClientData> body)
        {
            BatchId = batchId;
            Kf = kf;
            Maker = maker;
            ClientCard = new ClientCardsContainer()
            {
                ClientCard = body
            };
        }

    }
}