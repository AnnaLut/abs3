using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEntrepreneurV2 : PersonV2
    {
        // Найменування клієнта (нац.)
        [XmlElement("fullName")]
        public string FullName { get; set; }
        public bool ShouldSerializeFullName() { return !string.IsNullOrWhiteSpace(FullName); }

        // Найменування (міжн.)
        [XmlElement("fullNameInternational")]
        public string FullNameInternational { get; set; }
        public bool ShouldSerializeFullNameInternational() { return !string.IsNullOrWhiteSpace(FullNameInternational); }

        // Найменування (скорочене)
        [XmlElement("fullNameAbbreviated")]
        public string FullNameAbbreviated { get; set; }
        public bool ShouldSerializeFullNameAbbreviated() { return !string.IsNullOrWhiteSpace(FullNameAbbreviated); }

        // Тип клієнта (К014)
        [XmlElement("k014")]
        public decimal? K014 { get; set; }
        public bool ShouldSerializeK014() { return null != K014; }

        // Країна клієнта (К040)
        [XmlElement("k040")]
        public decimal? K040 { get; set; }
        public bool ShouldSerializeK040() { return null != K040; }

        // Тип державного реєстру
        [XmlElement("buildStateRegister")]
        public decimal? BuildStateRegister { get; set; }
        public bool ShouldSerializeBuildStateRegister() { return null != BuildStateRegister; }

        // Ознака інсайдера (К060)
        [XmlElement("k060")]
        public decimal? K060 { get; set; }
        public bool ShouldSerializeK060() { return null != K060; }

        // Характеристика клієнта (К010)
        [XmlElement("k010")]
        public decimal? K010 { get; set; }
        public bool ShouldSerializeK010() { return null != K010; }

        // Юридична адреса
        [XmlElement("legalAddress")]
        public PrivateEntrepreneurAddressV2 LegalAddress { get; set; }
        public bool ShouldSerializeLegalAddress() { return null != LegalAddress; }

        // Фактична адреса
        [XmlElement("actualAddress")]
        public PrivateEntrepreneurAddressV2 ActualAddress { get; set; }
        public bool ShouldSerializeActualAddress() { return null != ActualAddress; }

        // Реквізити платника податків
        [XmlElement("taxpayerDetails")]
        public PrivateEntepreneurTaxPayerV2 TaxpayerDetails { get; set; }
        public bool ShouldSerializeTaxpayerDetails() { return null != TaxpayerDetails; }

        // Реквізити клієнта
        [XmlElement("customerDetails")]
        public PrivateEntrepreneurCustomerDetailsV2 CustomerDetails { get; set; }
        public bool ShouldSerializeCustomerDetails() { return null != CustomerDetails; }

        // Додаткова інформація
        [XmlElement("additionalInformation")]
        public PrivateEntrepreneurAdditionalInformationV2 AdditionalInformation { get; set; }
        public bool ShouldSerializeAdditionalInformation() { return null != AdditionalInformation; }

        // Додаткові реквізити
        [XmlElement("additionalDetails")]
        public PrivateEntrepreneurAdditionalDetailsV2 AdditionalDetails { get; set; }
        public bool ShouldSerializeAdditionalDetails() { return null != AdditionalInformation; }

        // Економічні нормативи
        [XmlElement("economicRegulations")]
        public EconomicRegulationsV2 EconomicRegulations { get; set; }
        public bool ShouldSerializeEconomicRegulations() { return null != EconomicRegulations; }
    }
}