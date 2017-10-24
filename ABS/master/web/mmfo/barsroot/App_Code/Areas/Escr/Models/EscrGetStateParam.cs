using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Escr.Models
{
    [XmlRoot("root")]
    public class EscrGetStateParam
    {
        [XmlElement("mfo")]
        public string mfo { get; set; }
        [XmlElement("deals")]
        public EscrGetStateDeals deals { get; set; }
    }
}