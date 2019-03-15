using System;

namespace Bars.WebServices.AutocasaService
{
    /// <summary>
    /// Summary description for EnquiryData
    /// </summary>
    //[System.Runtime.Serialization.DataContractAttribute(Name = "EnquiryData", Namespace = "http://avtokassa.com/CashDepartment.v4/Integration/")]
    [Serializable]
    public class EnquiryData
    {
        public Nominal[] NominalBreakdown { get; set; }
        public Decimal Amount { get; set; }
        public Int32 CurrencyCode { get; set; }

    }
}