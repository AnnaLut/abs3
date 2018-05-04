using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEntepreneurTaxPayerV2 : TaxPayerDetailsV2
    {
        // Реєстр. номер в адм.
        [XmlElement("admRegNumber")]
        public string AdmRegNumber { get; set; }
        public bool ShouldSerializeAdmRegNumber() { return !string.IsNullOrWhiteSpace(AdmRegNumber); }

        // Реєстр. номер у ПІ
        [XmlElement("piRegNumber")]
        public string PiRegNumber { get; set; }
        public bool ShouldSerializePiRegNumber() { return !string.IsNullOrWhiteSpace(PiRegNumber); }

        // Податковий код (К050)
        [XmlElement("k050")]
        public string K050 { get; set; }
        public bool ShouldSerializeK050() { return !string.IsNullOrWhiteSpace(K050); }
    }
}