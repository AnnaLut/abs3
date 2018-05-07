using System;
using System.ComponentModel;
using System.Linq;
using System.Text;
using Kendo.Mvc.UI;
using BarsWeb.Core.Infrastructure.Kernel.DI.Abstract;
using BarsWeb.Core.Models.Kernel;
using Oracle.DataAccess.Client;
using Kendo.Mvc;

namespace BarsWeb.Core.Infrastructure.Kernel.DI.Implementation
{
    public class KendoSqlTransformer : IKendoSqlTransformer
    {
        private readonly IKendoSqlFilter _kendoSqlFilter;
        [Obsolete("Не викодристовувати. Добавлено для підтримки старих версій.")]
        public KendoSqlTransformer()
        {
        }
        public KendoSqlTransformer(IKendoSqlFilter kendoSqlFilter)
        {
            _kendoSqlFilter = kendoSqlFilter;
        }

        public BarsSql TransformSql(BarsSql sql, DataSourceRequest request, string[] dateFieldsNames = null)
        {
            if (request != null)
            {
                var filteredSql = request.Filters != null && request.Filters.Any() ? _kendoSqlFilter.TransformSql(sql, request, dateFieldsNames) : sql;
                if (request.PageSize > 0)
                {
                    var orderString = "order by " +
                        ((request.Sorts != null && request.Sorts.Any())
                        ? string.Join(",", request.Sorts.Select(a => a.Member + (a.SortDirection == ListSortDirection.Ascending ? "" : " desc")))
                        : "null");
                    var newSql = new StringBuilder(filteredSql.SqlText);
                    var startNumRow = (request.Page - 1) * request.PageSize + 1;
                    var endNumRow = startNumRow + request.PageSize - 1;
                    newSql.Insert(0, string.Format("select * from ( select row_number() over ({0}) r__n, main_dataset.* from (", orderString));

                    newSql.Append(") main_dataset ) where r__n between :p_startNumRow and :p_endNumRow");
                    var newSqlParams = new object[]
                {
                    new OracleParameter("p_startNumRow", OracleDbType.Int32){Value = startNumRow},
                    new OracleParameter("p_endNumRow", OracleDbType.Int32){Value = endNumRow}
                };
                    var result = new BarsSql
                    {
                        SqlText = newSql.ToString(),
                        SqlParams =
                            filteredSql.SqlParams == null ? newSqlParams : filteredSql.SqlParams.Concat(newSqlParams).ToArray()
                    };
                    return result;
                }
                return filteredSql;
            }
            return sql;
        }

        ///<summary>
        ///трансформация sql запроса не учитывая регистр букв.
        ///</summary>
        public BarsSql TransformSqlForSearchAddress(string columnName, BarsSql sql, DataSourceRequest request)
        {
            string newSqlText = null;
            if (request != null)
            {
                foreach (var filter in request.Filters)
                {
                    if (filter is FilterDescriptor)
                    {
                        var filterDescriptor = filter as FilterDescriptor;
                        newSqlText = "where regexp_like(to_nchar(" + columnName + "), N'^" + filterDescriptor.Value + "', 'i')";
                    }
                    return new BarsSql
                    {
                        SqlText = string.Format("SELECT * FROM ({0}) {1} ", sql.SqlText, newSqlText),
                        SqlParams = sql.SqlParams != null ? sql.SqlParams : new object[] { }
                    };
                }
            }

            return sql;
        }
    }
}