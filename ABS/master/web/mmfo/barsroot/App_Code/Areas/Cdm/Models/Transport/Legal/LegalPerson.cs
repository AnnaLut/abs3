using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalData
    {
        public string Gcif { get; set; }
        public string Rcif { get; set; }
        public string Kf { get; set; }
        public decimal? Rnk { get; set; }
        public DateTime? LastChangeDt { get; set; }
        public DateTime? DateOff { get; set; }
        public DateTime? DateOn { get; set; }
        public string FullName { get; set; }
        public string FullNameInternational { get; set; }
        public string FullNameAbbreviated { get; set; }
        public decimal? K014 { get; set; }
        public decimal? K040 { get; set; }
        public decimal? BuildStateRegister { get; set; }
        public string Okpo { get; set; }
        public string IsOkpoExclusion { get; set; }
        public decimal? K060 { get; set; }
        public decimal? K030 { get; set; }
        public string OffBalanceDepCode { get; set; }
        public string OffBalanceDepName { get; set; }

      
        //Economic regulations

        public string K070 { get; set; }
        public string K080 { get; set; }
        public string K110 { get; set; }
        public string K050 { get; set; }
        public string K051 { get; set; }


        // legal address

        public string La_Index { get; set; }
        public decimal? La_TerritoryCode { get; set; }
        public string La_Region { get; set; }
        public string La_Area { get; set; }
        public string La_Settlement { get; set; }
        public decimal? La_K040 { get; set; }
        public string La_FullAddress { get; set; }

        // actual address
        public string Aa_Index { get; set; }
        public decimal? Aa_TerritoryCode { get; set; }
        public string Aa_Region { get; set; }
        public string Aa_Area { get; set; }
        public string Aa_Settlement { get; set; }
        public decimal? Aa_K040 { get; set; }
        public string Aa_FullAddress { get; set; }


        public decimal? RegionalPi { get; set; }
        public decimal? AreaPi { get; set; }
        public string AdmRegAuthority { get; set; }
        public DateTime? AdmRegDate { get; set; }
        public DateTime? PiRegDate { get; set; }
        public string DpaRegNumber { get; set; }
        public DateTime? DpiRegDate { get; set; }
        public string VatData { get; set; }
        public string VatCertNumber { get; set; }


        public string NameByStatus { get; set; }



        public decimal? BorrowerClass { get; set; }
        public string RegionalHoldingNumber { get; set; }



        public string K013 { get; set; }
        public string GroupAffiliation { get; set; }
        public string IncomeTaxPayerRegDate { get; set; }
        public string SeparateDivCorpCode { get; set; }
        public string EconomicActivityType { get; set; }
        public string FirstAccDate { get; set; }
        public string InitialFormFillDate { get; set; }
        public string EvaluationReputation { get; set; }
        public string AuthorizedCapitalSize { get; set; }
        public string RiskLevel { get; set; }
        public string RevenueSourcesCharacter { get; set; }
        public string EssenceCharacter { get; set; }
        public string NationalProperty { get; set; }
        public string VipSign { get; set; }
        public string NoTaxpayerSign { get; set; }

        public string Branch { get; set; }
    }

    public class LegalPerson 
    {
        [XmlElement("gcif")]
        public string Gcif { get; set; }
        public bool ShouldSerializeGcif()
        {
            return !string.IsNullOrEmpty(Gcif);
        }

        [XmlElement("rcif")]
        public string Rcif { get; set; }
        public bool ShouldSerializeRcif()
        {
            return !string.IsNullOrEmpty(Rcif);
        }

        //Код Філії - МФО
        [XmlElement("kf")]
        public string Kf { get; set; }

        //Реєстраційний номер клієнта
        [XmlElement("rnk")]
        public decimal? Rnk { get; set; }

        //Дата останньої модифікації
        [XmlElement("lastChangeDt")]
        public DateTime? LastChangeDt { get; set; }
        public bool ShouldSerializeLastLastChangeDt()
        {
            return LastChangeDt.HasValue;
        }

        //Дата закриття
        [XmlElement("dateOff")]
        public DateTime? DateOff { get; set; }
        public bool ShouldSerializeDateOff()
        {
            return DateOff.HasValue;
        }

        //Дата реєстрації
        [XmlElement("dateOn")]
        public DateTime? DateOn { get; set; }
        public bool ShouldSerializeDateOn()
        {
            return DateOn.HasValue;
        }

        //Найменування кліента
        [XmlElement("fullName")]
        public string FullName { get; set; }
        public bool ShouldSerializeFullName()
        {
            return !string.IsNullOrEmpty(FullName);
        }

        //Найменування кліента (міжнародне)
        [XmlElement("fullNameInternational")]
        public string FullNameInternational { get; set; }
        public bool ShouldSerializeFullNameInternational()
        {
            return !string.IsNullOrEmpty(FullNameInternational);
        }

        //Найменування кліента (скорочене)
        [XmlElement("fullNameAbbreviated")]
        public string FullNameAbbreviated { get; set; }
        public bool ShouldSerializeFullNameAbbreviated()
        {
            return !string.IsNullOrEmpty(FullNameAbbreviated);
        }

        //Тип клієнта (K014)
        [XmlElement("k014")]
        public decimal? K014 { get; set; }
        public bool ShouldSerializeK014()
        {
            return K014 != null;
        }

        //країна клієнта (К040)
        [XmlElement("k040")]
        public decimal? K040 { get; set; }
        public bool ShouldSerializeK040()
        {
            return K040 != null;
        }

        //тип держ. реєстру
        [XmlElement("buildStateRegister")]
        public decimal? BuildStateRegister { get; set; }
        public bool ShouldSerializeBuildStateRegister()
        {
            return BuildStateRegister != null;
        }

        //Ідентифікаційний код
        [XmlElement("okpo")]
        public string Okpo { get; set; }
        public bool ShouldSerializeOkpo()
        {
            return !string.IsNullOrEmpty(Okpo);
        }

        [XmlElement("isOkpoExclusion")]
        public string IsOkpoExclusion { get; set; }
        public bool ShouldSerializeIsOkpoExclusion()
        {
            return !string.IsNullOrEmpty(IsOkpoExclusion);
        }

        //ознака інсайдера (К060)
        [XmlElement("k060")]
        public decimal? K060 { get; set; }
        public bool ShouldSerializeK060()
        {
            return K060 != null;
        }

        //Резидентність (K030)
        [XmlElement("k030")]
        public decimal? K030 { get; set; }
        public bool ShouldSerializeK030()
        {
            return K030 != null;
        }

        //код. безбалансового відділення
        [XmlElement("offBalanceDepCode")]
        public string OffBalanceDepCode { get; set; }
        public bool ShouldSerializeOffBalanceDepCode()
        {
            return !string.IsNullOrEmpty(OffBalanceDepCode);
        }

        //Назва безбалансового відділення
        [XmlElement("offBalanceDepName")]
        public string OffBalanceDepName { get; set; }
        public bool ShouldSerializeOffBalanceDepName()
        {
            return !string.IsNullOrEmpty(OffBalanceDepName);
        }

        [XmlElement("economicRegulations")]
        public LegalPersonEconomicRegulations EconomicRegulations { get; set; }

        //Юридична адреса
        [XmlElement("legalAddress")]
        public LegalPersonAddress LegalAddress { get; set; }

        //Фактична адреса
        [XmlElement("actualAddress")]
        public LegalPersonActualAddress ActualAddress { get; set; }

        //Реквізити платника податків
        [XmlElement("taxpayerDetails")]
        public TaxpayersDetails TaxpayerDetails { get; set; }

        //Реквізити клієнта
        [XmlElement("customerDetails")]
        public CustomerDetails CustomerDetails { get; set; }

        //Додаткова інформація
        [XmlElement("additionalInformation")]
        public AdditionalInformation AdditionalInformation { get; set; }

        //Додаткові реквізити
        [XmlElement("additionalDetails")]
        public AdditionalDetails AdditionalDetails { get; set; }

        //Пов’язані особи

        [XmlElement("relatedPerson")]
        public List<RelatedPerson> RelatedPersons { get; set; }
        public bool ShouldSerializeRelatedPersons()
        {
            return RelatedPersons != null && RelatedPersons.Any();
        }
    }
}