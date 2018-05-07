using BarsWeb.Core.Infrastructure.Kernel.DI.Abstract;
using BarsWeb.Core.Models.Kernel;
using System.Text;
using Kendo.Mvc.UI;
using System;

namespace BarsWeb.Core.Infrastructure.Kernel.DI.Implementation
{
    public class KendoSqlCounter : IKendoSqlCounter
    {

        private readonly IKendoSqlFilter _kendoSqlFilter;

        public KendoSqlCounter()
        {
                
        }

        public KendoSqlCounter(IKendoSqlFilter kendoSqlFilter)
        {
            _kendoSqlFilter = kendoSqlFilter;
        }

        public BarsSql TransformSql(BarsSql sql, DataSourceRequest request, string[] dateFieldsNames = null)
        {
            var filteredSql = _kendoSqlFilter.TransformSql(sql, request, dateFieldsNames);
            var newSql = new StringBuilder(filteredSql.SqlText);
            newSql.Insert(0, "select count(*) total from (");
            newSql.Append(") main_dataset");
            var result = new BarsSql
            {
                SqlText = newSql.ToString(),
                SqlParams = filteredSql.SqlParams
            };
            return result;
        }
    }
}