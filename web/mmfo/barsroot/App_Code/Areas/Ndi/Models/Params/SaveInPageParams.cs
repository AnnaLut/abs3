using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SaveInPageParams
/// </summary>
namespace BarsWeb.Areas.Ndi.Models.Params
{
    public class SaveInPageParams
    {
        public SaveInPageParams()
        {
            DefaultModels = new DefParamModel();
            ReplaceModels = new ReplaceModel();
        }

        public DefParamModel DefaultModels { get; set; }

        public ReplaceModel ReplaceModels { get; set; }
    }
}