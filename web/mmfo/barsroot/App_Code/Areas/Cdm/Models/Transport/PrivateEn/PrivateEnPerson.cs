using BarsWeb.Areas.Cdm.Models.Transport.Legal;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEnData
    {
        public string Kf { get; set; }

        public decimal? Rnk { get; set; }

        public DateTime? LastChangeDt { get; set; }

        public DateTime? DateOff { get; set; }       
        public DateTime? DateOn { get; set; }

        public string FullName { get; set; }

        public string FullNameInternational { get; set; }

        public string FullNameAbbreviated{ get; set; }

        public decimal? K014 { get; set; }

        public decimal? BuildStateRegister { get; set; }

        public string Okpo { get; set; }

        public string K070 { get; set; }

        public string k080 { get; set; }

        public string K110 { get; set; }

        public string K050 { get; set; }

        public string K051 { get; set; }

        public decimal? K040 { get; set; }

        public decimal? K060 { get; set; }

        public Int16? K010 { get; set; }

        public string La_Index { get; set; }

        public int? La_TerritoryCode { get; set; }

        public string La_Region { get; set; }

        public string La_Area { get; set; }

        public string La_Settlement { get; set; }

        public string La_Street { get; set; }

        public string La_HouseNumber { get; set; }

        public string La_SectionNumber { get; set; }

        public string La_ApartmentsNumber { get; set; }

        public string La_Notes { get; set; }

        public string Aa_Index { get; set; }

        public int? Aa_TerritoryCode { get; set; }

        public string Aa_Region { get; set; }

        public string Aa_Area { get; set; }

        public string Aa_Settlemet { get; set; }

        public string Aa_Street { get; set; }

        public string Aa_HouseNumber { get; set; }

        public string Aa_SectionNumber { get; set; }


        public string Aa_ApartmentsNumber { get; set; }

        public string Aa_Notes { get; set; }

        public decimal? RegionalPi { get; set; }

        public decimal? AreaPi { get; set; }

        public string AdmRegAuthority { get; set; }

        public DateTime? AdmRegDate { get; set; }

        public DateTime? Piregdate { get; set; }

        public DateTime? BirthDate { get; set; }

        public string DocSer { get; set; }

        public decimal? TP_K050 { get; set; }

        public DateTime? ActualDate { get; set; }

        public string BirthPlace { get; set; }

        public string MobilePhone { get; set; }

        public string DocNumber { get; set; }

        public string DocOrgan { get; set; }

        public decimal? DocType { get; set; }

        public DateTime? DocIssueDate { get; set; }

        public string AdmRegNumber { get; set; }

        public string PiRegNumber { get; set; }

        public string EddrId { get; set; }

        public string Sex { get; set; }

        public decimal? BorrowerClass { get; set; }

        public string SmallBusinessBelonging { get; set; }

        public string K013 { get; set; }

        public string Email { get; set; }

        public string GroupAffiliation { get; set; }

        public string EmploymentStatus { get; set; }

        public string Gcif { get; set; }

        public string Branch { get; set; }

        public string IsOkpoExclusion { get; set; }
    }

    public class PrivateEnPerson
    {
        [XmlElement("gcif")]
        [DataMember]
        public string Gcif { get; set; }
        public bool ShouldSerializeGcif()
        {
            return !string.IsNullOrEmpty(Gcif);
        }

        //Код Філії - МФО
        [XmlElement("kf")]
        [DataMember(IsRequired = true)]
        [StringLength(maximumLength: 12, MinimumLength = 6)]
        public string Kf { get; set; }

        //Реєстраційний номер клієнта
        [XmlElement("rnk")]
        public decimal? Rnk { get; set; }

        //Дата останньої модифікації
        [XmlElement("lastChangeDt")]
        public DateTime? LastChangeDt { get; set; }
        
        public bool ShouldSerializeLastChangeDt()
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
        public string fullName { get; set; }
        public bool ShouldSerializefullName()
        {
            return !string.IsNullOrEmpty(fullName);
        }

        //Найменування кліента (міжнародне)
        [XmlElement("fullNameInternational")]
        public string fullNameInternational { get; set; }
        public bool ShouldSerializefullNameInternational()
        {
            return !string.IsNullOrEmpty(fullNameInternational);
        }

        //Найменування кліента (скорочене)
        [XmlElement("fullNameAbbreviated")]
        public string fullNameAbbreviated { get; set; }
        public bool ShouldSerializefullNameAbbreviated()
        {
            return !string.IsNullOrEmpty(fullNameAbbreviated);
        }

        //Тип клієнта (K014)
        [XmlElement("k014")]
        public decimal? K014 { get; set; }
        public bool ShouldSerializeK014()
        {
            return K014 != null;
        }

        //Country in Data base
        [XmlElement("k040")]
        public decimal? K040 { get; set; }
        public bool ShouldSerializeK040()
        {
            return K040 != null;
        }

        //тип держ. реєстру
        [XmlElement("buildStateRegister")]
        public decimal? buildStateRegister { get; set; }
        public bool ShouldSerializebuildStateRegister()
        {
            return buildStateRegister != null;
        }

        //Ідентифікаційний код
        [XmlElement("okpo")]
        public string Okpo { get; set; }
        public bool ShouldSerializeOkpo()
        {
            return !string.IsNullOrEmpty(Okpo);
        }

        [XmlElement("isOkpoExclusion")]
        [DataMember]
        public bool IsOkpoExclusion { get; set; }

        //код. безбалансового відділення
        [XmlElement("branch")]
        [StringLength(maximumLength: 30)]
        public string Branch { get; set; }
        public bool ShouldSerializeBranch()
        {
            return !string.IsNullOrEmpty(Branch);
        }

        //Preinsider in Data base
        [XmlElement("k060")]
        public decimal? K060 { get; set; }
        public bool ShouldSerializeK060()
        {
            return K060 != null;
        }

        [XmlElement("k010")]
        public Int16? K010 { get; set; }
        public bool ShouldSerializeK010()
        {
            return K010 != null;
        }

        [XmlElement("economicRegulations")]
        public EconomicRegulations economicRegulations { get; set; }

        [XmlElement("legalAddress")]
        public PrivateEnAddress LegalAddress { get; set; }

        [XmlElement("actualAddress")]
        public PrivateEnActualAddress ActualAddress { get; set; }

        [XmlElement("taxpayerDetails")]
        public PrivateEnTaxpayersDetail TaxpayersDetail { get; set; }

        [XmlElement("customerDetails")]
        public PrivateEnCustomerDetails CustomerDetails { get; set; }

        [XmlElement("additionalInformation")]
        public PrivateEnAdditionalInformation AdditionalInformation { get; set; }

        [XmlElement("additionalDetails")]
        public PrivateEnAdditionalDetails additionalDetails { get; set; }

        //Пов’язані особи
        [XmlElement("relatedPerson")]
        public List<RelatedPerson> RelatedPersons { get; set; }
        public bool ShouldSerializeRelatedPersons()
        {
            return RelatedPersons != null && RelatedPersons.Any();
        }
    }
}