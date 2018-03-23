using System;

namespace Bars.WebServices.XRM.Services.SKRN.Models
{
    public class CloseDealRequest
    {
        /// <summary>
        /// Номер договору
        /// </summary>
        public Int64? Nd { get; set; }

        /// <summary>
        /// p_n_sk
        /// </summary>
        public Int64? NSk { get; set; }
    }
}
