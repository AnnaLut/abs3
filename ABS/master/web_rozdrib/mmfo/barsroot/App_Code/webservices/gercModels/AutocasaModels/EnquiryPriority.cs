using System;
using System.Collections.Generic;
using System.Web;
using System.Runtime.Serialization;

namespace Bars.WebServices.AutocasaService
{
    /// <summary>
    /// Пріорітет заявки
    /// </summary>
    [System.Runtime.Serialization.DataContractAttribute(Name = "EnquiryPriority", Namespace = "http://elis.dn.ua/CashDepartment.v4/Enumerations/")]
    public enum EnquiryPriority
    {
        Normal = 0,
        Medium = 1
    }

}