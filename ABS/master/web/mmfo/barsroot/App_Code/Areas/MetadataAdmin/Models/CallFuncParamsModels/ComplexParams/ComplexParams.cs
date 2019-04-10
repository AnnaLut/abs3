﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ComplexParams
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class ComplexParams : ParamMetaInfo
    {
        public ComplexParams()
        {
            this.IsInput = false;
        }

        public string SrcFrom { get; set; }

    }
}