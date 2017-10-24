using System.ComponentModel.DataAnnotations;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class AttrributeAnalysis
    {
        
        [RegularExpression(@"^[CWN]", ErrorMessage = "Unknown Quality signature.")]
        [XmlAttribute("quality")]
        public string Quality { get; set; }
        
        [AttrNameValid]
        [XmlAttribute("name")]
        public string Name { get; set; }

        [XmlElement("value")]
        public string Value { get; set; }

        [XmlElement("check")]
        public AttributeCheck[] Check { get; set; }
        
    }
}