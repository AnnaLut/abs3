using System.ComponentModel.DataAnnotations;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class AttributeAnalysisV2
    {
        // Значення
        [XmlAttribute("value")]
        public string Value { get; set; }

        // Рекомендоване значення
        [XmlAttribute("recommendValue")]
        public string RecommendValue { get; set; }

        // Перевірки
        [XmlAttribute("descr")]
        public string Descr { get; set; }

        // Им’я атрибуту
        [XmlAttribute("name")]
        [AttrNameValidV2]
        public string Name { get; set; }

        // Якість
        [RegularExpression(@"^[CWN]", ErrorMessage = "Unknown Quality signature.")]
        [XmlAttribute("quality")]
        public string Quality { get; set; }
    }
}