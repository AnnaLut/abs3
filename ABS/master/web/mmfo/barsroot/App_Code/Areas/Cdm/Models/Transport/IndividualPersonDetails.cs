using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class IndividualPersonDetails
    {
        //Тип документу
        [XmlElement("docType")]
        public int? DocType { get; set; }
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

        //Дата видачі документу
        [XmlElement("docIssueDate")]
        public DateTime? DocIssueDate { get; set; }
        public bool ShouldSerializeDocIssueDate()
        {
            return DocIssueDate.HasValue;
        }

        //Місце видачі документу	
        [XmlElement("docOrgan")]
        public string DocOrgan { get; set; }
        public bool ShouldSerializeDocOrgan()
        {
            return !String.IsNullOrEmpty(DocOrgan);
        }

        [XmlElement("actualDate")]
        public DateTime? ActualDate { get; set; }
        public bool ShouldSerializeActualDate()
        {
            return DocIssueDate.HasValue;
        }

        [XmlElement("eddrId")]
        public string EddrId { get; set; }
        public bool ShouldSerializeEddrId()
        {
            return !String.IsNullOrEmpty(EddrId);
        }

        //Дата народження
        [XmlElement("birthDay")]
        public DateTime? BirthDay { get; set; }
        public bool ShouldSerializeBirthDay()
        {
            return BirthDay.HasValue;
        }

        //Місце народження	
        [XmlElement("birthPlace")]
        public string BirthPlace { get; set; }
        public bool ShouldSerializeBirthPlace()
        {
            return !String.IsNullOrEmpty(BirthPlace);
        }

        //Стать
        [XmlElement("sex")]
        public string Sex { get; set; }
        public bool ShouldSerializeSex()
        {
            return !String.IsNullOrEmpty(Sex);
        }


        [XmlElement("notes")]
        public string Notes { get; set; }
        public bool ShouldSerializeNotes()
        {
            return !String.IsNullOrEmpty(Notes);
        }

        [XmlElement("relSign")]
        public decimal? RelSign { get; set; }
        public bool ShouldSerializeRelSign()
        {
            return RelSign != null;
        }
    }
}