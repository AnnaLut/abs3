using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class RelatedPerson : IndividualPersonDetails
    {
        //Реєстраційний номер клієнта
        [XmlElement("rnk")]
        public int? Rel_Rnk { get; set; }

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
        public bool ShouldSerializeK014()
        {
            return K014 != null;
        }

        [XmlElement("k040")]
        public string K040 { get; set; }
        public bool ShouldSerializeK040()
        {
            return !String.IsNullOrEmpty(K040);
        }

        [XmlElement("regionCode")]
        public string RegionCode { get; set; }
        public bool ShouldSerializeRegionCode()
        {
            return !String.IsNullOrEmpty(RegionCode);
        }

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
        public string IsOkpoExclusion { get; set; }
        public bool ShouldSerializeIsOkpoExclusion()
        {
            return !String.IsNullOrEmpty(IsOkpoExclusion);
        }

        //Телефон	
        [XmlElement("telephone")]
        public string Telephone { get; set; }
        public bool ShouldSerializeTelephone()
        {
            return !String.IsNullOrEmpty(Telephone);
        }

        [XmlElement("email")]
        public string Email { get; set; }
        public bool ShouldSerializeEmail()
        {
            return !String.IsNullOrEmpty(Email);
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

    }
}