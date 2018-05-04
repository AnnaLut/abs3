using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class ClientAnalysisV2
    {
        // Якість за атрибутами
        [XmlElement("attr")]
        public List<AttributeAnalysisV2> Attributes { get; set; }
        public bool ShouldSerializeAttr()
        {
            return null != Attributes;
        }

        // Результати аналізу контактів клієнта
        [XmlElement("rpAnalysis")]
        public List<RelatedPersonAnalysisV2> RpAnalysis { get; set; }
        public bool ShouldSerializeRpAnalysis()
        {
            return null != RpAnalysis;
        }

        // Загальна якість картки клієнта
        [XmlAttribute("summaryQuality")]
        public decimal SummaryQuality { get; set; }

        // Якість картки клієнта за групою ідентифікації
        [XmlAttribute("defaultQuality")]
        public decimal DefaultQuality { get; set; }
    }
}