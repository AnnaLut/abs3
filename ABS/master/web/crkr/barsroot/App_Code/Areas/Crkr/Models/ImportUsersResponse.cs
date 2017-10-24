using System.Xml.Serialization;
namespace BarsWeb.Areas.Crkr.Models
{
    /*public class ImportUsersParams
    {
        public string logname { get; set; }
        public string fio { get; set; }
        public string branch { get; set; }
        public string canselectbranch { get; set; }
        public string method { get; set; }
    }*/

    [XmlRoot(ElementName = "user")]
    public class ImportUsersResponse
    {
        [XmlElement(ElementName = "logname")]
        public string logname { get; set; }
        [XmlElement(ElementName = "success")]
        public decimal success  { get; set; }
        [XmlElement(ElementName = "message")]
        public string message { get; set; }
    }
}
