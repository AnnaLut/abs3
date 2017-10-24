using System;
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
    public class ImportUsersParams
    {
        [XmlElement(ElementName = "logname")]
        public string logname { get; set; }
        [XmlElement(ElementName = "fio")]
        public string fio { get; set; }
        [XmlElement(ElementName = "branch")]
        public string branch { get; set; }
        [XmlElement(ElementName = "canselectbranch")]
        public string canselectbranch { get; set; }
        [XmlElement(ElementName = "method")]
        public string method { get; set; }
        [XmlElement(ElementName = "dateprivstart")]
        public DateTime? dateprivstart { get; set; }
        [XmlElement(ElementName = "dateprivend")]
        public DateTime? dateprivend { get; set; }
    }
}
