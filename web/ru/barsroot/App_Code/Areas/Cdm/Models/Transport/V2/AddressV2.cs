using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class AddressV2
    {
        // Індекс
        [XmlElement("index")]
        public string Index { get; set; }
        public bool ShouldSerializeIndex() { return !string.IsNullOrWhiteSpace(Index); }

        // Код території
        [XmlElement("territoryCode")]
        public decimal? TerritoryCode { get; set; }
        public bool ShouldSerializeTerritoryCode() { return null != TerritoryCode; }

        // Область
        [XmlElement("region")]
        public string Region { get; set; }
        public bool ShouldSerializeRegion() { return !string.IsNullOrWhiteSpace(Region); }

        // Район
        [XmlElement("area")]
        public string Area { get; set; }
        public bool ShouldSerializeArea() { return !string.IsNullOrWhiteSpace(Area); }

        // Населений пункт
        [XmlElement("settlement")]
        public string Settlement { get; set; }
        public bool ShouldSerializeSettlement() { return !string.IsNullOrWhiteSpace(Settlement); }
    }
}