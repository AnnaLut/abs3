using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class CustomerDetails
    {
        //Найменування по статуту
        [XmlElement("nameByStatus")]
        public string NameByStatus { get; set; }
        public bool ShouldSerializeNameByStatus()
        {
            return !String.IsNullOrEmpty(NameByStatus);
        }

    }
}