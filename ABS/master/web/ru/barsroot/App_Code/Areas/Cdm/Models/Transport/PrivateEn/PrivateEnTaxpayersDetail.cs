using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEnTaxpayersDetail
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
            return !String.IsNullOrEmpty(AdmRegAuthority);
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
        public DateTime? Piregdate { get; set; }
        public bool ShouldSerializePiregdate()
        {
            return Piregdate.HasValue;
        }

        //Номер реєстрації у ДПА
        [XmlElement("admRegNumber")]
        public string AdmRegNumber { get; set; }
        public bool ShouldSerializeAdmRegNumber()
        {
            return !String.IsNullOrEmpty(AdmRegNumber);
        }

        //Дата реєстр. у ДПІ
        [XmlElement("piRegNumber")]
        public string PiRegNumber { get; set; }
        public bool ShouldSerializeRpd()
        {
            return !String.IsNullOrEmpty(PiRegNumber);
        }

        [XmlElement("k050")]
        public decimal? TP_K050 { get; set; }
        public bool ShouldSerializeTP_K050()
        {
            return TP_K050 != null;
        }
    }
}