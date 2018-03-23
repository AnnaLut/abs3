using System.Xml.Serialization;

namespace BarsWeb.Areas.Transp.Models.ApiModels
{

    /// <summary>
    /// Summary description for TagValueXml
    /// </summary>

    public class Headparam
    {
        [XmlElement("tag")]
        public string tag { get; set; }

        [XmlElement("value")]
        public string value { get; set; }
    }
}