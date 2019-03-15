using System;
using System.Runtime.Remoting.Metadata;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Web.Services;

namespace Bars.WebServices.AutocasaService
{
    /// <summary>
    /// Summary description for ClientOutcashEnquiry
    /// </summary>
    [System.Runtime.Serialization.DataContractAttribute(Name = "enquiry", Namespace = "http://avtokassa.com/CashDepartment.v4/Integration/")]
    [Serializable]
    //[SoapAttribute(XmlNamespace = "SaveClientOutcashEnquiry")]
    [WebServiceBindingAttribute(name: "enquiry", Namespace = "SaveClientOutcashEnquiry")]
    public class ClientOutcashEnquiry : OutcashEnquiry
    {
        public String ClientAccountMfo { get; set; }
        public String ClientAccountNum { get; set; }
        public String ClientRegisterCode { get; set; }
        public String CollectionPointCode { get; set; }
        public String Document { get; set; }
    }
}