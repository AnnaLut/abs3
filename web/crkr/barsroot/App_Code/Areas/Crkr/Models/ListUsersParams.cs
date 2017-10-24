using System.Collections.Generic;
using System.Xml.Serialization;
namespace BarsWeb.Areas.Crkr.Models
{
    /*public class ListUsersParams
    {
        public List<ImportUsersParams> user { get; set; }
    }*/
    [XmlRoot(ElementName = "ListUsersParams")]
    public class ListUsersParams
    {
        [XmlElement(ElementName = "user")]
        public List<ImportUsersParams> user { get; set; }
    }
}
