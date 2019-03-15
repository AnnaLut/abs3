using System;
using System.Collections.Generic;
using System.Web;

namespace Bars.WebServices.AutocasaService
{
    /// <summary>
    /// Summary description for OutcashEnquiry
    /// </summary>
    /// [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    //[System.Runtime.Serialization.DataContractAttribute(Name = "OutcashEnquiry", Namespace = "http://avtokassa.com/CashDepartment.v4/Integration/")]
    //[System.Runtime.Serialization.KnownTypeAttribute(typeof(Bars.WebServices.AutocasaService.ClientOutcashEnquiry))]
    [Serializable]
    public class OutcashEnquiry
    {
        public EnquiryData[] Data { get; set; }
        public DateTime ExpectedDate { get; set; }
        public String ExternalId { get; set; }
        public String Notes { get; set; }
        public EnquiryPriority Priority { get; set; }
        public String Source { get; set; }
    }
}