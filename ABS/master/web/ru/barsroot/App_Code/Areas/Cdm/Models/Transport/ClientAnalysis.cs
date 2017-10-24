using System.Xml.Serialization;
using Newtonsoft.Json;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class ClientAnalysis
    {
        [XmlAttribute("kf")]
        public string Kf { get; set; }

        [XmlAttribute("rnk")]
        public string Rnk { get; set; }

        [XmlAttribute("quality")]
        public decimal Quality { get; set; }

        [XmlAttribute("defaultGroupQuality")]
        public decimal DefaultGroupQuality { get; set; }

        [XmlElement("attr")]
        [JsonProperty(PropertyName = "attr")]
        public AttrributeAnalysis[] AttrAnalysis  { get; set; }
        
        [XmlElement("groupQuality")]
        public GroupQuality[] CustomQualityGroups { get; set; }
    }
}