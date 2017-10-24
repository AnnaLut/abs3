using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class AdditionalDetails
    {
        //Код виду клієнта (K013)
        [XmlElement("k013")]
        public string K013 { get; set; }
        public bool ShouldSerializeK013()
        {
            return !String.IsNullOrEmpty(K013);
        }

        //КП-г.53 Приналежність до групи
        [XmlElement("groupAffiliation")]
        public string GroupAffiliation { get; set; }
        public bool ShouldSerializeGroupAffiliation()
        {
            return !String.IsNullOrEmpty(GroupAffiliation);
        }

        //Дата реєстрації як платника податку на прибуток
        [XmlElement("incomeTaxPayerRegDate")]
        public string IncomeTaxPayerRegDate { get; set; }
        public bool ShouldSerializeIncomeTaxPayerRegDate()
        {
            return !String.IsNullOrEmpty(IncomeTaxPayerRegDate);
        }

        //Код відокремленого підрозділу корп. Клієнта
        [XmlElement("separateDivCorpCode")]
        public string SeparateDivCorpCode { get; set; }
        public bool ShouldSerializeSeparateDivCorpCode()
        {
            return !String.IsNullOrEmpty(SeparateDivCorpCode);
        }

        //Вид (види) господарської (економічної) діяльності
        [XmlElement("economicActivityType")]
        public string EconomicActivityType { get; set; }
        public bool ShouldSerializeEconomicActivityType()
        {
            return !String.IsNullOrEmpty(EconomicActivityType);
        }

        //Дата відкриття першого рахунку
        [XmlElement("firstAccDate")]
        public string FirstAccDate { get; set; }
        public bool ShouldSerializeFirstAccDate()
        {
            return !String.IsNullOrEmpty(FirstAccDate);
        }

        //Дата первинного заповнення анкети
        [XmlElement("initialFormFillDate")]
        public string InitialFormFillDate { get; set; }
        public bool ShouldSerializeInitialFormFillDate()
        {
            return !String.IsNullOrEmpty(InitialFormFillDate);
        }

        //Оцінка репутації клієнта
        [XmlElement("evaluationReputation")]
        public string EvaluationReputation { get; set; }
        public bool ShouldSerializeEvaluationReputation()
        {
            return !String.IsNullOrEmpty(EvaluationReputation);
        }

        //Оцінка фiн.стану: Розмiр статутного капiталу
        [XmlElement("authorizedCapitalSize")]
        public string AuthorizedCapitalSize { get; set; }
        public bool ShouldSerializeAuthorizedCapitalSize()
        {
            return !String.IsNullOrEmpty(AuthorizedCapitalSize);
        }

        //Рiвень ризику
        [XmlElement("riskLevel")]
        public string RiskLevel { get; set; }
        public bool ShouldSerializeRiskLevel()
        {
            return !String.IsNullOrEmpty(RiskLevel);
        }

        //Характеристика джерел надходжень коштiв
        [XmlElement("revenueSourcesCharacter")]
        public string RevenueSourcesCharacter { get; set; }
        public bool ShouldSerializeRevenueSourcesCharacter()
        {
            return !String.IsNullOrEmpty(RevenueSourcesCharacter);
        }

        //Характеристика суті діяльності
        [XmlElement("essenceCharacter")]
        public string EssenceCharacter { get; set; }
        public bool ShouldSerializeEssenceCharacter()
        {
            return !String.IsNullOrEmpty(EssenceCharacter);
        }

        //Частка державної власності
        [XmlElement("nationalProperty")]
        public string NationalProperty { get; set; }
        public bool ShouldSerializeNationalProperty()
        {
            return !String.IsNullOrEmpty(NationalProperty);
        }

        //Ознака VIP-клієнта
        [XmlElement("vipSign")]
        public string VipSign { get; set; }
        public bool ShouldSerializeVipSign()
        {
            return !String.IsNullOrEmpty(VipSign);
        }

        //Ознака неплатника податків
        [XmlElement("noTaxpayerSign")]
        public string NoTaxpayerSign { get; set; }
        public bool ShouldSerializeNoTaxpayerSign()
        {
            return !String.IsNullOrEmpty(NoTaxpayerSign);
        }
    }
}