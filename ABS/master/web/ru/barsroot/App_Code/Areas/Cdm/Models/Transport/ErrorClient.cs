using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    public class ErrorClient
    {
        [XmlAttribute("kf")]
        public string Kf { get; set; }

        [XmlAttribute("rnk")]
        public string Rnk { get; set; }

        [XmlAttribute("errorCode")]
        public string ErrorCode { get; set; }

        [XmlAttribute("errorMsg")]
        public string ErrorMsg { get; set; }
    }
}