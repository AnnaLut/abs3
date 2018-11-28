using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Sto.Models
{
    /// <summary>
    /// Summary description for STOGroup
    /// </summary>
    public class STOGroup
    {
        public STOGroup() { }

        public Decimal IDG { get; set; }
        public string Name { get; set; }

        public string KF { get; set; }
    }
}