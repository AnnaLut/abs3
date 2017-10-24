using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalPersonAddress
    {
        //Індекс
        [XmlElement("index")]
        public string La_Index { get; set; }
        public bool ShouldSerializeLa_Index()
        {
            return !string.IsNullOrEmpty(La_Index);
        }

        //Код території
        [XmlElement("territoryCode")]
        public decimal? La_TerritoryCode { get; set; }
        public bool ShouldSerializeLa_TerritoryCode()
        {
            return La_TerritoryCode != null;
        }

        //Область
        [XmlElement("region")]
        public string La_Region { get; set; }
        public bool ShouldSerializeLa_Region()
        {
            return !string.IsNullOrEmpty(La_Region);
        }

        //Район
        [XmlElement("area")]
        public string La_Area { get; set; }
        public bool ShouldSerializeLa_Area()
        {
            return !string.IsNullOrEmpty(La_Area);
        }

        //Населений пункт
        [XmlElement("settlement")]
        public string La_Settlement { get; set; }
        public bool ShouldSerializeLa_Settlement()
        {
            return !string.IsNullOrEmpty(La_Settlement);
        }

        //країна клієнта (К040)
        [XmlElement("k040")]
        public decimal? La_K040 { get; set; }
        public bool ShouldSerializeLa_K040()
        {
            return La_K040 != null;
        }

        //Вул.,буд., кв
        [XmlElement("fullAddress")]
        public string La_FullAddress { get; set; }
        public bool ShouldSerializeLa_FullAddress()
        {
            return !string.IsNullOrEmpty(La_FullAddress);
        }

        
    }
}