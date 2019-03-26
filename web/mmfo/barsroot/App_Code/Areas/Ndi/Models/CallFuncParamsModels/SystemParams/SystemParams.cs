﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SystemParams
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class SystemParams : ParamMetaInfo
    {
        public SystemParams()
        {
            this.IsInput = false;
            this.Kind = "SYSTEM_PARAMS";
        }
    }
}