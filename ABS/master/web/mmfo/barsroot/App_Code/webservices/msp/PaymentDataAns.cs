using System;
using System.Xml.Serialization;

namespace Bars.WebServices.MSP.Models
{
    [Serializable]
    [XmlRoot("request")]
    public class PaymentDataAns
    {
        public string rq_st { get; set; }
        public string rq_st_detail { get; set; }
    }
}