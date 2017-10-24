using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for OutMessageParInfo
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class OutMessageParInfo : OutParamsInfo
    {
        public OutMessageParInfo()
        {
            this.Semantic = "повідомлення";
            this.ColType = "S";
            this.Kind = "MESSAGE";
            this.IsInput = false;
            this.FileForBackend = true;
        }
    }
}