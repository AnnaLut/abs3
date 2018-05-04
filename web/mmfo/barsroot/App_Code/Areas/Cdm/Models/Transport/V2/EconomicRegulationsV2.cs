using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class EconomicRegulationsV2
    {
        //інст.сектор.економіки (К070)
        [XmlElement("k070")]
        public string K070 { get; set; }
        public bool ShouldSerializeK070()
        {
            return !string.IsNullOrWhiteSpace(K070);
        }

        //Форма власності (К080)
        [XmlElement("k080")]
        public string K080 { get; set; }
        public bool ShouldSerializeK080()
        {
            return !string.IsNullOrWhiteSpace(K080);
        }

        //вид ек. діяльності (К110)
        [XmlElement("k110")]
        public string K110 { get; set; }
        public bool ShouldSerializeK110()
        {
            return !string.IsNullOrWhiteSpace(K110);
        }

        //форма господарювання (К050)
        [XmlElement("k050")]
        public string K050 { get; set; }
        public bool ShouldSerializeK050()
        {
            return !string.IsNullOrWhiteSpace(K050);
        }

        //Форма господарювання (К051)
        [XmlElement("k051")]
        public string K051 { get; set; }
        public bool ShouldSerializeK051()
        {
            return !string.IsNullOrWhiteSpace(K051);
        }
    }
}