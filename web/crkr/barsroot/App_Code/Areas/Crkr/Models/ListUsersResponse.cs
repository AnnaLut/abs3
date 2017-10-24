using System.Collections.Generic;
using System.Xml.Serialization;
namespace BarsWeb.Areas.Crkr.Models
{
    /*public class ListUsersParams
    {
        public List<ImportUsersParams> user { get; set; }
    }*/
    [XmlRoot(ElementName = "ListUsersResponse")]
    public class ListUsersResponse
    {
        [XmlElement(ElementName = "user")]
        public List<ImportUsersResponse> user { get; set; }
    }
}
