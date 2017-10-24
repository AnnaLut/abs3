using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OurFileNameParInfo
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class OutFileNameParInfo : OutParamsInfo
    {
        public OutFileNameParInfo()
        {
            this.Kind = "OUT_FILE_NAME";
            this.ColType = "S";
            this.IsInput = false;
        }

    }
}