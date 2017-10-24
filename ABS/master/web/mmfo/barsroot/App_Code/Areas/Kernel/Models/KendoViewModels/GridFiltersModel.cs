using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GridFiltersModel
/// </summary>
namespace BarsWeb.Areas.Kernel.Models.KendoViewModels
{
    public class GridFiltersModel : GridFiltersModelBaseModel
    {
        public GridFiltersModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public IList<Filter> filters { get; set; }
        public string logic { get; set; }

    }

    public class GridFiltersModelBaseModel
    {
        public IList<ColumnFilters> filters { get; set; }
        public string logic { get; set; }
    }
}