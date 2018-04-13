using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class AttrributeAnalysis
    {
        [DataMember(IsRequired = true)]
        [RegularExpression(@"^[CWN]", ErrorMessage = "Unknown Quality signature.")]
        [XmlAttribute("quality")]
        public string Quality { get; set; }

        [DataMember(IsRequired = true)]
        [AttrNameValid]
        [XmlAttribute("name")]
        public string Name { get; set; }

        [XmlElement("value")]
        public string Value { get; set; }

        [XmlElement("check")]
        public AttributeCheck[] Check { get; set; }
    }
}