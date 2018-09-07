using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using BarsWeb.Areas.CDO.Common.Models;

namespace BarsWeb.Areas.CDO.Corp2.Models
{
    /// <summary>
    /// Summary description for UserConnParamModel
    /// </summary>
    public class UserConnParamModel
    {
        public RelatedCustomer User { get; set; }
        public LimitViewModel UserLimit { get; set; }
        public List<ModuleViewModel> UserModules { get; set; }
        //public List<FunctionViewModel> UserFuncs { get; set; }
        public List<UserAccountPermissionViewModel> UserAccs { get; set; }
    }
}