using System;
using System.Xml.Serialization;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.SKRN.Models
{
    /// <summary>
    /// XRM_INTEGRATION_OE.oper_dep_skrn
    /// </summary>
    public class OperDepSkrnRequest
    {
        /// <summary>
        /// p_n_sk
        /// </summary>
        public Int64? NSk { get; set; }

        /// <summary>
        /// p_nd
        /// </summary>
        public Int64? Nd { get; set; }
        /// <summary>
        /// p_ndoc
        /// </summary>
        public string NDoc { get; set; }
        /// <summary>
        /// p_dat
        /// </summary>
        public DateTime? DateFrom { get; set; }
        /// <summary>
        /// p_dat2
        /// </summary>
        public DateTime? DateTo { get; set; }
        /// <summary>
        /// p_mode
        /// </summary>
        public int? OperationCode { get; set; }
        /// <summary>
        /// p_sum
        /// </summary>
        public decimal? Sum { get; set; }
    }
}