using System.ComponentModel.DataAnnotations;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEntrepreneurAdditionalDetailsV2 : AdditionalDetailsV2
    {
        // Адреса електронної пошти
        [XmlElement("email")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }
        public bool ShouldSerializeEmail() { return !string.IsNullOrWhiteSpace(Email); }

        // Статус зайнятості особи
        [XmlElement("employmentStatus")]
        public string EmploymentStatus { get; set; }
        public bool ShouldSerializeEmploymentStatus() { return !string.IsNullOrWhiteSpace(EmploymentStatus); }
    }
}