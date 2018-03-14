using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Transp.Models.ApiModels
{
    [XmlRoot("root")]
    public class DbResponce
    {
        [XmlElement("headparams")]
        public Headparams headparams { get; set; }

        [XmlElement("cont_type")]
        public string cont_type { get; set; }

        [XmlElement("conv_2_json")]
        public int conv_2_json { get; set; }

        [XmlElement("compress_type")]
        public string compress_type { get; set; }

        [XmlElement("base_64")]
        public int base_64 { get; set; }

        [XmlElement("check_sum")]
        public string check_sum { get; set; }
    }

}