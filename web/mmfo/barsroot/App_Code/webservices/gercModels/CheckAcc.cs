using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    public class CheckAcc
    {
        public string Nls { get; set; }
        public int Kv { get; set; }
    }
    public class CheckAccByBranch : CheckAcc
    {
        public string Branch { get; set; }
    }

    public class CheckAccByKf : CheckAcc
    {
        public string Kf { get; set; }
    }

    public class CheckAccResult
    {
        /// <summary>
        /// if filled then some exception occurred
        /// </summary>
        public string ErrorMessage { get; set; }
        public string Comment { get; set; }
        public int Status { get; set; }
    }
}