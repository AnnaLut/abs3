using System.Collections.Generic;
using System.Xml.Serialization;
namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEnContainer
    {
        [XmlElement("privateEntrepreneur")]
        public List<PrivateEnPerson> PrivateEnPersons { get; set; }
    }
}