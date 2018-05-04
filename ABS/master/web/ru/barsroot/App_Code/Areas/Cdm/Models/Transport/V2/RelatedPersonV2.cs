using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class RelatedPersonV2
    {
        //Реєстраційний номер пов’язаної особи
        [XmlElement("rnk")]
        public int? Rel_Rnk { get; set; }
        public bool ShouldSerializeRel_Rnk() { return Rel_Rnk.HasValue; }

        //Назва або ПІБ повязаної особи
        [XmlElement("name")]
        public string Name { get; set; }
        public bool ShouldSerializeName()
        {
            return !String.IsNullOrEmpty(Name);
        }

        //CustType in data base
        [XmlElement("k014")]
        public decimal? K014 { get; set; }
        public bool ShouldSerializeK014() { return K014.HasValue; }

        [XmlElement("k040")]
        public decimal? K040 { get; set; }
        public bool ShouldSerializeK040() { return K040.HasValue; }

        [XmlElement("regionCode")]
        public decimal? RegionCode { get; set; }
        public bool ShouldSerializeRegionCode() { return RegionCode.HasValue; }

        //Вид ек. діяльності(К110)
        [XmlElement("k110")]
        public string K110 { get; set; }
        public bool ShouldSerializeK110()
        {
            return !String.IsNullOrEmpty(K110);
        }

        //Форма господарювання (К051)
        [XmlElement("k051")]
        public string K051 { get; set; }
        public bool ShouldSerializeK051()
        {
            return !String.IsNullOrEmpty(K051);
        }

        //Інст.сектор економіки(К070)
        [XmlElement("k070")]
        public string K070 { get; set; }
        public bool ShouldSerializeK070()
        {
            return !String.IsNullOrEmpty(K070);
        }


        //Ідент. Код / Код за ЕДРПОУ	
        [XmlElement("okpo")]
        public string Okpo { get; set; }
        public bool ShouldSerializeOkpo()
        {
            return !String.IsNullOrEmpty(Okpo);
        }

        [XmlElement("isOkpoExclusion")]
        public bool IsOkpoExclusion { get; set; }

        //Телефон	
        [XmlElement("telephone")]
        public List<string> Telephones { get; set; }
        public bool ShouldSerializeTelephones()
        {
            return null != Telephones;
        }

        [XmlElement("email")]
        public List<string> Emails { get; set; }
        public bool ShouldSerializeEmails()
        {
            return null!=Emails;
        }

        //Форма власності (K080)	
        [XmlElement("k080")]
        public string K080 { get; set; }
        public bool ShouldSerializeK080()
        {
            return !String.IsNullOrEmpty(K080);
        }
        //Адреса	
        [XmlElement("address")]
        public string Address { get; set; }
        public bool ShouldSerializeAddress()
        {
            return !String.IsNullOrEmpty(Address);
        }

        //Тип документу
        [XmlElement("docType")]
        public int? DocType { get; set; }
        public bool ShouldSerializeDocType() { return DocType.HasValue; }

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
        public bool ShouldSerializeRelSign() { return RelSign.HasValue; }
    }
}