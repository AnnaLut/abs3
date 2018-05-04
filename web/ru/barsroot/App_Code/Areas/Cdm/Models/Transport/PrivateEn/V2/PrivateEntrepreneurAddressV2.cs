using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEntrepreneurAddressV2 : AddressV2
    {
        // вул., просп., б-р.
        [XmlElement("street")]
        public string Street { get; set; }
        public bool ShouldSerializeStreet() { return !string.IsNullOrWhiteSpace(Street); }

        // № буд., д/в
        [XmlElement("houseNumber")]
        public string HouseNumber { get; set; }
        public bool ShouldSerializeHouseNumber() { return !string.IsNullOrWhiteSpace(HouseNumber); }

        // № корп., секц.
        [XmlElement("sectionNumber")]
        public string SectionNumber { get; set; }
        public bool ShouldSerializeSectionNumber() { return !string.IsNullOrWhiteSpace(SectionNumber); }

        // № кв., кімн., оф.
        [XmlElement("apartmentsNumber")]
        public string ApartmentsNumber { get; set; }
        public bool ShouldSerializeApartmentsNumber() { return !string.IsNullOrWhiteSpace(ApartmentsNumber); }

        // Примітка
        [XmlElement("notes")]
        public string Notes { get; set; }
        public bool ShouldSerializeNotes() { return !string.IsNullOrWhiteSpace(Notes); }
    }
}