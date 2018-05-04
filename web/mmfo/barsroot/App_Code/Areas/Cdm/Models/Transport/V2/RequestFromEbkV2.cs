using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace BarsWeb.Areas.Cdm.Models.Transport
{
    [XmlRoot(ElementName = "request", Namespace = "")]
    public class RequestFromEbkV2
    {
        [XmlElement("batchId")]
        public string BatchId { get; set; }

        [XmlElement("batchTimestamp")]
        public DateTime BatchTimestamp { get; set; }

        [XmlElement("entry")]
        public List<ResponseV2> Entries { get; set; }
    }
}