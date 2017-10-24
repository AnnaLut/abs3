using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport.Legal
{
    public class LegalPersonEconomicRegulations
    {
        //інст.сектор.економіки (К070)
        [XmlElement("k070")]
        public string K070 { get; set; }
        public bool ShouldSerializeK070()
        {
            return !string.IsNullOrEmpty(K070);
        }

        //Форма власності (К080)
        [XmlElement("k080")]
        public string K080 { get; set; }
        public bool ShouldSerializeK080()
        {
            return !string.IsNullOrEmpty(K080);
        }

        //вид ек. діяльності (К110)
        [XmlElement("k110")]
        public string K110 { get; set; }
        public bool ShouldSerializeK110()
        {
            return !string.IsNullOrEmpty(K110);
        }

        //форма господарювання (К050)
        [XmlElement("k050")]
        public string K050 { get; set; }
        public bool ShouldSerializeK050()
        {
            return !string.IsNullOrEmpty(K050);
        }

        //Форма господарювання (К051)
        [XmlElement("k051")]
        public string K051 { get; set; }
        public bool ShouldSerializeK051()
        {
            return !string.IsNullOrEmpty(K051);
        }
    }
}
