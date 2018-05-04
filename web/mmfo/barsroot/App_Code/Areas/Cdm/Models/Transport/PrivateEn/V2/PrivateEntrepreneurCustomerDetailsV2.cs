using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEntrepreneurCustomerDetailsV2
    {
        // Тип документа
        [XmlElement("docType")]
        public decimal? DocType { get; set; }
        public bool ShouldSerializeDocType() { return null != DocType; }

        // Серія документа
        [XmlElement("docSer")]
        public string DocSer { get; set; }
        public bool ShouldSerializeDocSer() { return !string.IsNullOrWhiteSpace(DocSer); }

        // Номер документа
        [XmlElement("docNumber")]
        public string DocNumber { get; set; }
        public bool ShouldSerializeDocNumber() { return !string.IsNullOrWhiteSpace(DocNumber); }

        // Ким виданий
        [XmlElement("docOrgan")]
        public string DocOrgan { get; set; }
        public bool ShouldSerializeDocOrgan() { return !string.IsNullOrWhiteSpace(DocOrgan); }

        // Коли виданий
        [XmlElement("docIssueDate")]
        public DateTime? DocIssueDate { get; set; }
        public bool ShouldSerializeDocIssueDate() { return DocIssueDate.HasValue; }

        // Дійсний до
        [XmlElement("actualDate")]
        public DateTime? ActualDate { get; set; }
        public bool ShouldSerializeActualDate() { return ActualDate.HasValue; }

        // Унікальний номер запису ЄДДР
        [XmlElement("eddrId")]
        public string EddrId { get; set; }
        public bool ShouldSerializeEddrId() { return !string.IsNullOrWhiteSpace(EddrId); }

        // Дата народження
        [XmlElement("birthDate")]
        public DateTime? BirthDate { get; set; }
        public bool ShouldSerializeBirthDate() { return BirthDate.HasValue; }

        // Місце народження
        [XmlElement("birthPlace")]
        public string BirthPlace { get; set; }
        public bool ShouldSerializeBirthPlace() { return !string.IsNullOrWhiteSpace(BirthPlace); }

        // Стать
        [XmlElement("sex")]
        public string Sex { get; set; }
        public bool ShouldSerializeSex() { return !string.IsNullOrWhiteSpace(Sex); }

        // Моб.тел.
        [XmlElement("mobilePhone")]
        public string MobilePhone { get; set; }
        public bool ShouldSerializeMobilePhone() { return !string.IsNullOrWhiteSpace(MobilePhone); }
    }
}