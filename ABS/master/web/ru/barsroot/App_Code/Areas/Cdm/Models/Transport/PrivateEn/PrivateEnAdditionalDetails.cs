using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEnAdditionalDetails
    {
        //Код виду клієнта (K013)
        [XmlElement("k013")]
        public string K013 { get; set; }
        public bool ShouldSerializeK013()
        {
            return !String.IsNullOrEmpty(K013);
        }

        //КП-г.53 Приналежність до групи
        [XmlElement("groupAffiliation")]
        public string GroupAffiliation { get; set; }
        public bool ShouldSerializeGroupAffiliation()
        {
            return !String.IsNullOrEmpty(GroupAffiliation);
        }
       
        [XmlElement("email")]
        public string Email { get; set; }
        public bool ShouldSerializeEmail()
        {
            return !String.IsNullOrEmpty(Email);
        }

        
        [XmlElement("employmentStatus")]
        public string EmploymentStatus { get; set; }
        public bool ShouldSerializeGroupEmploymentStatus()
        {
            return !String.IsNullOrEmpty(EmploymentStatus);
        }
    }
}
