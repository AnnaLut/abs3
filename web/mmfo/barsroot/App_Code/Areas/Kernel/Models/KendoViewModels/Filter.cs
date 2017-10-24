using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Filter
/// </summary>
namespace BarsWeb.Areas.Kernel.Models.KendoViewModels
{
    public class Filter : ColumnFilters
    {
        public Filter()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public string field { get; set; }
        public string @operator { get; set; }
        public string value { get; set; }
    }
}