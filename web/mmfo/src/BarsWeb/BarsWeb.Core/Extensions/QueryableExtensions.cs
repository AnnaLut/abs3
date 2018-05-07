using System.Collections;
using System.Data;
using System.Linq;
using Kendo.Mvc.Extensions;
using BarsWeb.Core.Models;
//using Kendo.Mvc.UI;

namespace BarsWeb.Core.Extensions
{
    public static class QueryableExtensions 
    {
        public static DataSourceResult ToDataSource(this IEnumerable enumerable, DataSourceRequest request)
        {
            var result = enumerable.ToDataSourceResult(request);
            return new DataSourceResult
            {
                Total = result.Total,
                AggregateResults = result.AggregateResults,
                Data = result.Data,
                Errors = result.Errors
            };
        }

        public static DataSourceResult ToDataSource(this IQueryable enumerable, DataSourceRequest request)
        {
            var result = enumerable.ToDataSourceResult(request);
            return new DataSourceResult
            {
                Total = result.Total,
                AggregateResults = result.AggregateResults,
                Data = result.Data,
                Errors = result.Errors
            };
        }

        public static DataSourceResult ToDataSource(this DataTable dataTable, DataSourceRequest request)
        {
            var result = dataTable.ToDataSourceResult(request);
            return new DataSourceResult
            {
                Total = result.Total,
                AggregateResults = result.AggregateResults,
                Data = result.Data,
                Errors = result.Errors
            };
        }
    }
}
