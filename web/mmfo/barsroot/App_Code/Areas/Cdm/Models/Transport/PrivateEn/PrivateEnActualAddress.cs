using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEnActualAddress
    {        
        [XmlElement("index")]
        public string Aa_Index { get; set; }
        public bool ShouldSerializeAa_Index()
        {
            return !string.IsNullOrEmpty(Aa_Index);
        }

        [XmlElement("territoryCode")]
        public decimal? Aa_territoryCode { get; set; }
        public bool ShouldSerializeAa_territoryCode()
        {
            return Aa_territoryCode != null;
        }

        [XmlElement("region")]
        public string Aa_Region { get; set; }
        public bool ShouldSerializeAa_Region()
        {
            return !string.IsNullOrEmpty(Aa_Region);
        }

        [XmlElement("area")]
        public string Aa_Area { get; set; }
        public bool ShouldSerializeAa_Area()
        {
            return !string.IsNullOrEmpty(Aa_Area);
        }

        [XmlElement("settlement")]
        public string Aa_Settlement { get; set; }
        public bool ShouldSerializeAa_Settlement()
        {
            return !string.IsNullOrEmpty(Aa_Settlement);
        }

        [XmlElement("street")]
        public string Aa_Street { get; set; }
        public bool ShouldSerializeAa_Street()
        {
            return !string.IsNullOrEmpty(Aa_Street);
        }

        [XmlElement("houseNumber")]
        public string Aa_HouseNumber { get; set; }
        public bool ShouldSerializeAa_HouseNumber()
        {
            return !string.IsNullOrEmpty(Aa_HouseNumber);
        }

        [XmlElement("sectionNumber")]
        public string Aa_SectionNumber { get; set; }
        public bool ShouldSerializeAa_SectionNumber()
        {
            return !string.IsNullOrEmpty(Aa_SectionNumber);
        }

        [XmlElement("apartmentsNumber")]
        public string Aa_ApartmentsNumber { get; set; }
        public bool ShouldSerializeAa_ApartmentsNumber()
        {
            return !string.IsNullOrEmpty(Aa_ApartmentsNumber);
        }

        [XmlElement("notes")]
        public string Aa_Notes { get; set; }
        public bool ShouldSerializeAa_Notes()
        {
            return !string.IsNullOrEmpty(Aa_Notes);
        }

    }
}