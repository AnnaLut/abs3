using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using System.Xml.Serialization;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [DataContract]
    public class DuplicatesV2
    {
        // Код РУ (код МФО)
        [XmlAttribute("kf")]
        [DataMember(IsRequired = true)]
        [Required]
        public string Kf { get; set; }


        // Реєстраційний номер
        [XmlAttribute("rnk")]
        [DataMember(IsRequired = true)]
        [Required]
        public long Rnk { get; set; }

        // Ідентифікатор майстер-запису
        [XmlAttribute("gcif")]
        public string Gcif { get; set; }
        public bool ShouldSerializeGcif()
        {
            return !string.IsNullOrEmpty(Gcif);
        }

        // Ідентифікатор майстер-запису майстер-картки
        [XmlAttribute("masterGcif")]
        public string MasterGcif { get; set; }
        public bool ShouldSerializeMasterGcif()
        {
            return !string.IsNullOrEmpty(MasterGcif);
        }
    }
}