using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEnAddress
    {
        //Index
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

        [XmlElement("street")]
        public string La_Street { get; set; }

        public bool ShouldSerializeLa_Street()
        {
            return !string.IsNullOrEmpty(La_Street);
        }

        [XmlElement("houseNumber")]
        public string La_HouseNumber { get; set; }

        public bool ShouldSerializeLa_HouseNumber()
        {
            return !string.IsNullOrEmpty(La_HouseNumber);
        }

        [XmlElement("sectionNumber")]
        public string La_SectionNumber { get; set; }

        public bool ShouldSerializeLa_SectionNumber()
        {
            return !string.IsNullOrEmpty(La_SectionNumber);
        }

        [XmlElement("apartmentsNumber")]
        public string La_apartmentsNumber { get; set; }

        public bool ShouldSerializeLa_apartmentsNumber()
        {
            return !string.IsNullOrEmpty(La_apartmentsNumber);
        }

        [XmlElement("notes")]
        public string La_Notes { get; set; }

        public bool ShouldSerializeLa_Notes()
        {
            return !string.IsNullOrEmpty(La_Notes);
        }


    }
}