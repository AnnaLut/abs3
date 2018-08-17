using BarsWeb.Areas.Ndi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ConvertParams
/// </summary>
namespace BarsWeb.Areas.Ndi.Models
{
    public class ConvertParams : MultiRowsParams
    {
        public ConvertParams()
        {
            this.Kind = "FROM_UPLOAD_EXCEL";
        }

        public List<FieldProperties> ConvertParamList { get; set; }
    }
}