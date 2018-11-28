using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Sto.Models
{
    /// <summary>
    /// Summary description for STOGroup
    /// </summary>
    public class STOContractData
    {
        public STOContractData() { }

        public decimal IDS { get; set; }

        public decimal RNK { get; set; }

        public string NMK { get; set; }

        public string Name { get; set;}

        public DateTime? SDat { get; set; }

        public string KF { get; set; }

        public decimal IDG { get; set; }

        public string Branch { get; set; }

        public DateTime? ClosingDate { get; set; }

    }
}