using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class TaxpayersDetails
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
        public DateTime? PiRegDate { get; set; }
        public bool ShouldSerializePiRegDate()
        {
            return PiRegDate.HasValue;
        }

        //Номер реєстрації у ДПА
        [XmlElement("dpaRegNumber")]
        public string DpaRegNumber { get; set; }
        public bool ShouldSerializeDpaRegNumber()
        {
            return !String.IsNullOrEmpty(DpaRegNumber);
        }

        //Дата реєстр. у ДПІ
        [XmlElement("dpiRegDate")]
        public DateTime? DpiRegDate { get; set; }
        public bool ShouldSerializeDpiRegDate()
        {
            return DpiRegDate.HasValue;
        }

        //Дані про платника ПДВ
        [XmlElement("vatData")]
        public string VatData { get; set; }
        public bool ShouldSerializeVatData()
        {
            return !String.IsNullOrEmpty(VatData);
        }

        //№ свідоцтва платника ПДВ
        [XmlElement("vatCertNumber")]
        public string VatCertNumber { get; set; }
        public bool ShouldSerializeVatCertNumber()
        {
            return !String.IsNullOrEmpty(VatCertNumber);
        }
        
    }
}