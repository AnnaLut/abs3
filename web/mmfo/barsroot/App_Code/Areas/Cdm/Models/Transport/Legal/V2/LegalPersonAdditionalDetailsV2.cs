using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalPersonAdditionalDetailsV2 : AdditionalDetailsV2
    {
        //Дата реєстрації як платника податку на прибуток
        [XmlElement("incomeTaxPayerRegDate")]
        public string IncomeTaxPayerRegDate { get; set; }
        public bool ShouldSerializeIncomeTaxPayerRegDate()
        {
            return !string.IsNullOrEmpty(IncomeTaxPayerRegDate);
        }

        //Код відокремленого підрозділу корп. Клієнта
        [XmlElement("separateDivCorpCode")]
        public string SeparateDivCorpCode { get; set; }
        public bool ShouldSerializeSeparateDivCorpCode()
        {
            return !string.IsNullOrEmpty(SeparateDivCorpCode);
        }

        //Вид (види) господарської (економічної) діяльності
        [XmlElement("economicActivityType")]
        public string EconomicActivityType { get; set; }
        public bool ShouldSerializeEconomicActivityType()
        {
            return !string.IsNullOrEmpty(EconomicActivityType);
        }

        //Дата відкриття першого рахунку
        [XmlElement("firstAccDate")]
        public string FirstAccDate { get; set; }
        public bool ShouldSerializeFirstAccDate()
        {
            return !string.IsNullOrEmpty(FirstAccDate);
        }

        //Дата первинного заповнення анкети
        [XmlElement("initialFormFillDate")]
        public string InitialFormFillDate { get; set; }
        public bool ShouldSerializeInitialFormFillDate()
        {
            return !string.IsNullOrEmpty(InitialFormFillDate);
        }

        //Оцінка репутації клієнта
        [XmlElement("evaluationReputation")]
        public string EvaluationReputation { get; set; }
        public bool ShouldSerializeEvaluationReputation()
        {
            return !string.IsNullOrEmpty(EvaluationReputation);
        }

        //Оцінка фiн.стану: Розмiр статутного капiталу
        [XmlElement("authorizedCapitalSize")]
        public string AuthorizedCapitalSize { get; set; }
        public bool ShouldSerializeAuthorizedCapitalSize()
        {
            return !string.IsNullOrEmpty(AuthorizedCapitalSize);
        }

        //Рiвень ризику
        [XmlElement("riskLevel")]
        public string RiskLevel { get; set; }
        public bool ShouldSerializeRiskLevel()
        {
            return !string.IsNullOrEmpty(RiskLevel);
        }

        //Характеристика джерел надходжень коштiв
        [XmlElement("revenueSourcesCharacter")]
        public string RevenueSourcesCharacter { get; set; }
        public bool ShouldSerializeRevenueSourcesCharacter()
        {
            return !string.IsNullOrEmpty(RevenueSourcesCharacter);
        }

        //Характеристика суті діяльності
        [XmlElement("essenceCharacter")]
        public string EssenceCharacter { get; set; }
        public bool ShouldSerializeEssenceCharacter()
        {
            return !string.IsNullOrEmpty(EssenceCharacter);
        }

        //Частка державної власності
        [XmlElement("nationalProperty")]
        public string NationalProperty { get; set; }
        public bool ShouldSerializeNationalProperty()
        {
            return !string.IsNullOrEmpty(NationalProperty);
        }

        //Ознака VIP-клієнта
        [XmlElement("vipSign")]
        public string VipSign { get; set; }
        public bool ShouldSerializeVipSign()
        {
            return !string.IsNullOrEmpty(VipSign);
        }

        //Ознака неплатника податків
        [XmlElement("noTaxpayerSign")]
        public string NoTaxpayerSign { get; set; }
        public bool ShouldSerializeNoTaxpayerSign()
        {
            return !string.IsNullOrEmpty(NoTaxpayerSign);
        }

    }
}