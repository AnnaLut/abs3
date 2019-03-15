using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Bars.WebServices.CurrencyRate
{
    [Serializable]
    //[System.Xml.Serialization.XmlType(AnonymousType = true, Namespace = "http://oshb.currency.rates.ua")]
    
    public enum RateTypeEnum
    {
        CUR_RATE_COMMERCIAL,
        CUR_RATE_DEALER,
        CUR_RATE_OFFICIAL,
    }

    //[System.Xml.Serialization.XmlType(Namespace = "http://oshb.currency.rates.ua")]
    [Serializable]
    //[System.Runtime.Serialization.DataContract(Namespace = "http://oshb.currency.rates.ua")]
    public class BaseRequestType
    {
        public BaseRequestType() { }
        public string MsgID { get; set; }
        public RateTypeEnum RateType { get; set; }
        public string TimeStamp { get; set; }
    }
}