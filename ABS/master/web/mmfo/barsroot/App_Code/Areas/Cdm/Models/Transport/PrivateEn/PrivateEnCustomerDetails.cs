using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEnCustomerDetails
    {
        //Тип документу
        [XmlElement("docType")]
        public decimal? DocType { get; set; }
        public bool ShouldSerializeDocType()
        {
            return DocType != null;
        }

        //Серія документу	
        [XmlElement("docSer")]
        public string DocSer { get; set; }
        public bool ShouldSerializeDocSer()
        {
            return !String.IsNullOrEmpty(DocSer);
        }

        //Номер документу	
        [XmlElement("docNumber")]
        public string DocNumber { get; set; }
        public bool ShouldSerializeDocNumber()
        {
            return !String.IsNullOrEmpty(DocNumber);
        }

        //Місце видачі документу	
        [XmlElement("docOrgan")]
        public string DocOrgan { get; set; }
        public bool ShouldSerializeDocOrgan()
        {
            return !String.IsNullOrEmpty(DocOrgan);
        }

        //Дата видачі документу
        [XmlElement("docIssueDate")]
        public DateTime? DocIssueDate { get; set; }
        public bool ShouldSerializeDocIssueDate()
        {
            return DocIssueDate.HasValue;
        }

        //Дата видачі документу
        [XmlElement("actualDate")]
        public DateTime? ActualDate { get; set; }
        public bool ShouldSerializeActualDate()
        {
            return ActualDate.HasValue;
        }

        [XmlElement("eddrId")]
        public string EddrId { get; set; }
        public bool ShouldSerializeEddrId()
        {
            return !String.IsNullOrEmpty(EddrId);
        }

        //Дата народження
        [XmlElement("birthDate")]
        public DateTime? BirthDate { get; set; }
        public bool ShouldSerializeBirthDate()
        {
            return BirthDate.HasValue;
        }

        //Місце народження	
        [XmlElement("birthPlace")]
        public string BirthPlace { get; set; }
        public bool ShouldSerializeBirthPlace()
        {
            return !String.IsNullOrEmpty(BirthPlace);
        }

        [XmlElement("sex")]
        public string Sex { get; set; }
        public bool ShouldSerializeSex()
        {
            return !String.IsNullOrEmpty(Sex);
        }

        // Mobile phone
        [XmlElement("mobilePhone")]
        public string MobilePhone { get; set; }
        public bool ShouldSerializeMobilePhone()
        {
            return !String.IsNullOrEmpty(MobilePhone);
        }
    }
}