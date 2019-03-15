using System;
using System.Collections.Generic;
using System.Web;

namespace Bars.WebServices.AutocasaService
{
    /// <summary>
    /// Номинал - Кількість банкнот в розрізі номіналів
    /// -Номінал
    /// -Ознака розміну
    /// -Кількість купюр даного номіналу
    /// </summary>
    //[System.Runtime.Serialization.DataContractAttribute(Name = "Nominal", Namespace = "http://www.elis.dn.ua/CashDepartment.v4/Integration/")]
    [Serializable]
    public class Nominal
    {
        public uint Count { get; set; }
        public uint CountOfDoubtful { get; set; }
        public Boolean IsChange { get; set; }
        public Double Value { get; set; }
    }

}