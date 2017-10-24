using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class AdditionalInformation
    {
        //Клас позичальника
        [XmlElement("borrowerClass")]
        public decimal? BorrowerClass { get; set; }
        public bool ShouldSerializeBorrowerClass()
        {
            return BorrowerClass.HasValue;
        }

        //Рег. № холдингу
        [XmlElement("regionalHoldingNumber")]
        public string RegionalHoldingNumber { get; set; }
        public bool ShouldSerializeRegionalHoldingNumber()
        {
            return !String.IsNullOrEmpty(RegionalHoldingNumber);
        }

    }
}