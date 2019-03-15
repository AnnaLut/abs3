using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.CurrencyRate
{

    /// <summary>
    /// Summary description for Response
    /// </summary>
    //[System.Xml.Serialization.XmlType(Namespace = "http://oshb.currency.rates.ua")]
    [Serializable]
    public class Response
    {
        public Response() { }

        public bool Result { get; set; }
        public int ErrorId { get; set; }
        public string ErrorMessage { get; set; }
    }
}