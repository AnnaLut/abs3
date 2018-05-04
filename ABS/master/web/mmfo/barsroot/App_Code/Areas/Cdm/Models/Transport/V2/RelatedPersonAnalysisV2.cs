using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class RelatedPersonAnalysisV2
    {
        // Якість за атрибутами
        [XmlElement("attr")]
        public List<RelatedPersonAttrAnalysisV2> Attr { get; set; }

        // РНК повязаної особи
        [XmlAttribute("rnk")]
        public int Rnk { get; set; }

        // Загальна якість контакта
        [XmlAttribute("summaryQuality")]
        public decimal SummaryQuality { get; set; }
    }
}