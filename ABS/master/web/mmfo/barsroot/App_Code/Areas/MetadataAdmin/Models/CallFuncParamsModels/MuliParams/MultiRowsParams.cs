﻿using BarsWeb.Areas.MetaDataAdmin.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MultiRowParams
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class MultiRowsParams : ParamMetaInfo
    {
        public MultiRowsParams()
        {
            this.Kind = "MULTI_ROW_PARAMS";
            this.RowColumnsParams = new List<FieldProperties>();
        }
        public string ColumnNames { get; set; }
        public List<string> ListColumnNames { get; set; }

        public List<FieldProperties> RowColumnsParams { get; set; }

    }
}