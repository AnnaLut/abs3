using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class AdditionalDetailsV2
    {
        //Код виду клієнта (K013)
        [XmlElement("k013")]
        public string K013 { get; set; }
        public bool ShouldSerializeK013()
        {
            return !string.IsNullOrWhiteSpace(K013);
        }

        //КП-г.53 Приналежність до групи
        [XmlElement("groupAffiliation")]
        public string GroupAffiliation { get; set; }
        public bool ShouldSerializeGroupAffiliation()
        {
            return !string.IsNullOrWhiteSpace(GroupAffiliation);
        }
    }
}