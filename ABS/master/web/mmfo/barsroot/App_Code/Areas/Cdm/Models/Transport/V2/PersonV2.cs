using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class PersonV2
    {
        // Ідентифікатор майстер-запису
        [XmlElement("gcif")]
        public string Gcif { get; set; }
        public bool ShouldSerializeGcif()
        {
            return !string.IsNullOrEmpty(Gcif);
        }

        // Код Філії - МФО
        [XmlElement("kf")]
        public string Kf { get; set; }

        // Реєстраційний номер клієнта
        [XmlElement("rnk")]
        public decimal? Rnk { get; set; }

        // Дата останньої модифікації
        [XmlElement("lastChangeDt")]
        public DateTime? LastChangeDt { get; set; }
        public bool ShouldSerializeLastLastChangeDt()
        {
            return LastChangeDt.HasValue;
        }

        // Дата закриття
        [XmlElement("dateOff")]
        public DateTime? DateOff { get; set; }
        public bool ShouldSerializeDateOff()
        {
            return DateOff.HasValue;
        }

        // Дата реєстрації
        [XmlElement("dateOn")]
        public DateTime? DateOn { get; set; }
        public bool ShouldSerializeDateOn()
        {
            return DateOn.HasValue;
        }

        // Ідентифікаційний код (ЄДРПОУ, ІПН)
        [XmlElement("okpo")]
        public string Okpo { get; set; }
        public bool ShouldSerializeOkpo()
        {
            return !string.IsNullOrEmpty(Okpo);
        }

        // Ознака виключення Ідентифікаційного Коду / Коду за ЕДРПОУ
        [XmlElement("isOkpoExclusion")]
        public bool IsOkpoExclusion { get; set; }

        [XmlElement("relatedPerson")]
        public List<RelatedPersonV2> RelatedPersons { get; set; }
        public bool ShouldSerializeRelatedPersons()
        {
            return RelatedPersons != null && RelatedPersons.Any();
        }

    }
}