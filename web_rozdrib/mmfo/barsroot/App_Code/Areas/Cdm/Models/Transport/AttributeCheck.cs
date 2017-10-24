using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class AttributeCheck
    {
        [XmlElement("recommendValue")]
        public string RecommendValue { get; set; }

        [XmlElement("descr")]
        public string Descr { get; set; }
    }
}