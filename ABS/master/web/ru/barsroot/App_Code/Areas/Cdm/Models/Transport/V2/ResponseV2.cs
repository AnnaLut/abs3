using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "response")]
    public class ResponseV2:BaseResponse
    {
        [XmlElement("message")]
        public string Message { get; set; }

        [XmlElement("card")]
        public List<CardDataV2> Cards { get; set; }
        public bool ShouldSerializeCards()
        {
            return null != Cards;
        }
    }
}