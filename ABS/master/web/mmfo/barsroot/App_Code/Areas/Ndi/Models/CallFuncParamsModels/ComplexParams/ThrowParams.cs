using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ThrowParams
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class ThrowParams : ParamMetaInfo
    {
        public ThrowParams()
        {
            this.IsInput = false;
            this.Kind = "THROW_PARAMS";
            this.DefParams = new List<DefParam>();
        }

      public List<DefParam> DefParams { get; set; } 
        

    }
}