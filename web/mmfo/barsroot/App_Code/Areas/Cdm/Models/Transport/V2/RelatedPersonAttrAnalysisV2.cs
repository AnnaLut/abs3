using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class RelatedPersonAttrAnalysisV2
    {
        // Значення
        [XmlAttribute("value")]
        public string Value { get; set; }

        // Рекомендоване значення
        [XmlAttribute("recommendValue")]
        public string RrecommendValue { get; set; }

        // Перевірки
        [XmlAttribute("descr")]
        public string Descr { get; set; }

        // Ім’я атрибуту
        [XmlAttribute("name")]
        [RpAttrNameValidV2]
        public string Name { get; set; }
    }
}