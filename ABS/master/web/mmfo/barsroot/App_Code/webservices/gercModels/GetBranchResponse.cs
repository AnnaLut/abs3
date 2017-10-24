using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    /// <summary>
    /// Summary description for GetBranchResponse
    /// </summary>
    public class GetBranchResponse
    {
        public int AskBranchSet { get; set; }
        public BranchData[] BranchDataSet { get; set; }
        public string ErrorMessage { get; set; }
    }
}