using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.WebServices.GercPayModels
{
    // Для синхронизации справочников бранчей
    public struct BranchData
    {
        public string BranchCode { get; set; }
        public string BranchName { get; set; }
        public string BranchAddress { get; set; }
    }
}