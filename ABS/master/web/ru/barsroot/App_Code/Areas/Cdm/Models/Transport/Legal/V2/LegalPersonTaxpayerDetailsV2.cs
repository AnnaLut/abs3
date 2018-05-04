using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalPersonTaxpayerDetailsV2:TaxPayerDetailsV2
    {
        //Номер реєстрації у ДПА
        [XmlElement("dpaRegNumber")]
        public string DpaRegNumber { get; set; }
        public bool ShouldSerializeDpaRegNumber()
        {
            return !string.IsNullOrEmpty(DpaRegNumber);
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
            return !string.IsNullOrEmpty(VatData);
        }

        //№ свідоцтва платника ПДВ
        [XmlElement("vatCertNumber")]
        public string VatCertNumber { get; set; }
        public bool ShouldSerializeVatCertNumber()
        {
            return !string.IsNullOrEmpty(VatCertNumber);
        }

    }
}