using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalPersonV2 : PersonV2
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

        // Резидентність (К030)
        [XmlElement("k030")]
        public decimal? K030 { get; set; }
        public bool ShouldSerializeK030() { return null != K030; }


        // Код безбалансового відділення
        [XmlElement("offBalanceDepCode")]
        public string OffBalanceDepCode { get; set; }
        public bool ShouldSerializeOffBalanceDepCode() { return !string.IsNullOrWhiteSpace(OffBalanceDepCode); }

        // Назва безбалансового відділення
        [XmlElement("offBalanceDepName")]
        public string OffBalanceDepName { get; set; }
        public bool ShouldSerializeOffBalanceDepName() { return !string.IsNullOrWhiteSpace(OffBalanceDepCode); }

        // Юридична адреса
        [XmlElement("legalAddress")]
        public LegalPersonAddressV2 LegalAddress { get; set; }
        public bool ShouldSerializeLegalAddress() { return null != LegalAddress; }

        // Фактична адреса
        [XmlElement("actualAddress")]
        public LegalPersonAddressV2 ActualAddress { get; set; }
        public bool ShouldSerializeActualAddress() { return null != ActualAddress; }

        // Реквізити платника податків
        [XmlElement("taxpayerDetails")]
        public LegalPersonTaxpayerDetailsV2 TaxpayerDetails { get; set; }
        public bool ShouldSerializeTaxpayerDetails() { return null != TaxpayerDetails; }

        // Реквізити клієнта
        [XmlElement("customerDetails")]
        public LegalPersonCustomerDetailsV2 CustomerDetails { get; set; }
        public bool ShouldSerializeCustomerDetails() { return null != CustomerDetails; }

        // Додаткова інформація
        [XmlElement("additionalInformation")]
        public LegalPersonAdditionalInformationV2 AdditionalInformation { get; set; }
        public bool ShouldSerializeAdditionalInformation() { return null != AdditionalInformation; }

        // Додаткові реквізити
        [XmlElement("additionalDetails")]
        public LegalPersonAdditionalDetailsV2 AdditionalDetails { get; set; }
        public bool ShouldSerializeAdditionalDetails() { return null != AdditionalDetails; }

        // Економічні нормативи
        [XmlElement("economicRegulations")]
        public EconomicRegulationsV2 EconomicRegulations { get; set; }
        public bool ShouldSerializeEconomicRegulations() { return null != EconomicRegulations; }
    }
}