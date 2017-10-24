using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalPersonActualAddress
    {
        //Індекс
        [XmlElement("index")]
        public string Aa_Index { get; set; }
        public bool ShouldSerializeAa_Index()
        {
            return !string.IsNullOrEmpty(Aa_Index);
        }

        //Код території
        [XmlElement("territoryCode")]
        public decimal? Aa_TerritoryCode { get; set; }
        public bool ShouldSerializeAa_TerritoryCode()
        {
            return Aa_TerritoryCode != null;
        }

        //Область
        [XmlElement("region")]
        public string Aa_Region { get; set; }
        public bool ShouldSerializeAa_Region()
        {
            return !string.IsNullOrEmpty(Aa_Region);
        }

        //Район
        [XmlElement("area")]
        public string Aa_Area { get; set; }
        public bool ShouldSerializeAa_Area()
        {
            return !string.IsNullOrEmpty(Aa_Area);
        }

        //Населений пункт
        [XmlElement("settlement")]
        public string Aa_Settlement { get; set; }
        public bool ShouldSerializeAa_Settlement()
        {
            return !string.IsNullOrEmpty(Aa_Settlement);
        }

        //країна клієнта (К040)
        [XmlElement("k040")]
        public decimal? Aa_K040 { get; set; }
        public bool ShouldSerializeAa_K040()
        {
            return Aa_K040 != null;
        }

        //Вул.,буд., кв
        [XmlElement("fullAddress")]
        public string Aa_FullAddress { get; set; }
        public bool ShouldSerializeAa_FullAddress()
        {
            return !string.IsNullOrEmpty(Aa_FullAddress);
        }
    }
}
