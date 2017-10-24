using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.PrivateEn
{
    public class PrivateEnAdditionalInformation
    {
        //Клас позичальника
        [XmlElement("borrowerClass")]
        public decimal? BorrowerClass { get; set; }
        public bool ShouldSerializeBorrowerClass()
        {
            return BorrowerClass.HasValue;
        }

        [XmlElement("smallBusinessBelonging")]
        public string SmallBusinessBelonging { get; set; }
        public bool ShouldSerializeSmallBusinessBelonging()
        {
            return !string.IsNullOrEmpty(SmallBusinessBelonging);
        }
    }
}
