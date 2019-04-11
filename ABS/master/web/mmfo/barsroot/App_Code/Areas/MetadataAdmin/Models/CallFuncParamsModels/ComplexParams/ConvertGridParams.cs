using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ConvertGridParams
/// </summary>
namespace BarsWeb.Areas.MetaDataAdmin.Models
{
    public class ConvertGridParams : ConvertParams
    {
        public ConvertGridParams()
        {
            this.Kind = "CONVERT_GRID_PARAMS";
        }
    }
}