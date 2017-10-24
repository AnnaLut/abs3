using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for WebDatasourceModel
/// </summary>
namespace BarsWeb.Areas.Kernel.Models.KendoViewModels
{
    public class WebDatasourceModel
    {
        public WebDatasourceModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }


        public GridFiltersModel filters;
        public IList<SortRequestModel> sort;
        public List<Column> columns;
        public int page;
        public int pageSize;

    }

}