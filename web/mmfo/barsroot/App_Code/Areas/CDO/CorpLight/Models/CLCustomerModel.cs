using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.CDO.CorpLight.Models
{
    /// <summary>
    /// Summary description for CorpLight CustomerModel
    /// </summary>
    public class CLCustomerModel
    {
        public CLCustomerModel()
        {

        }
        /// <summary>
        /// RNK
        /// </summary>
        public string CustId { get; set; }
        /// <summary>
        /// OKPO/INN code 
        /// </summary>
        public string OKPO { get; set; }
        /// <summary>
        /// Cust type (1=БН, 2=Юридическое лицо, 3=Физическое лицо)
        /// </summary>
        public decimal? CustType { get; set; }
        /// <summary>
        /// OKPO for transfering to CorpLight in foramt F
        /// </summary>
        public string CL_OKPO { get; set; }
    }
}