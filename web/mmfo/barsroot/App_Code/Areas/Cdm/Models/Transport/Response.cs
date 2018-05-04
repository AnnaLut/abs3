using System;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "response")]
    public partial class Response:BaseResponse
    {
        [XmlElement("msg")]
        public string Msg { get; set; }
    }
}