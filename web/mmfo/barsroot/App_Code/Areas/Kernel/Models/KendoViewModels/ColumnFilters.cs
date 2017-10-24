using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ColumnFilters
/// </summary>
namespace BarsWeb.Areas.Kernel.Models.KendoViewModels
{
    public class ColumnFilters
    {
        public ColumnFilters()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public string logic { get; set; }
        public IList<Filter> filters { get; set; }
    }
}