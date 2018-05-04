using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class TaxPayerDetailsV2
    {
        //Обласна ПІ
        [XmlElement("regionalPi")]
        public decimal? RegionalPi { get; set; }
        public bool ShouldSerializeRegionalPi()
        {
            return RegionalPi != null;
        }

        //Районна ПІ
        [XmlElement("areaPi")]
        public decimal? AreaPi { get; set; }
        public bool ShouldSerializeAreaPi()
        {
            return AreaPi != null;
        }

        //Адміністративний орган реєстрації
        [XmlElement("admRegAuthority")]
        public string AdmRegAuthority { get; set; }
        public bool ShouldSerializeAdmRegAuthority()
        {
            return !string.IsNullOrEmpty(AdmRegAuthority);
        }

        //Дата реєстр. у Адм.
        [XmlElement("admRegDate")]
        public DateTime? AdmRegDate { get; set; }
        public bool ShouldSerializeAdmRegDate()
        {
            return AdmRegDate.HasValue;
        }

        //Дата реєстр. у ПІ
        [XmlElement("piRegDate")]
        public DateTime? PiRegDate { get; set; }
        public bool ShouldSerializePiRegDate()
        {
            return PiRegDate.HasValue;
        }

    }
}