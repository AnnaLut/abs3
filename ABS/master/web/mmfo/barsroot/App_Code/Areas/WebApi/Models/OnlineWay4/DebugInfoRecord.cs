using System.Xml.Serialization;

namespace BarsWeb.Areas.WebApi.OnlineWay4.Models
{
    public partial class DebugInfoRecord
    {
        [XmlElement("name")]
        public string Name { get; set; }
        [XmlElement("value")]
        public string Value { get; set; }
    }
}
