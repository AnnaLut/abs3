using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Ndi.Models.ViewModels
{
    /// <summary>
    /// Summary description for Fun
    /// </summary>
    public class FuncOnlyViewModel : MainOptionsViewModel
    {
        public FuncOnlyViewModel()
        {
            //
            // TODO: Add constructor logic here
            //
            this.IsFuncOnly = true;
        }
        
    }
}