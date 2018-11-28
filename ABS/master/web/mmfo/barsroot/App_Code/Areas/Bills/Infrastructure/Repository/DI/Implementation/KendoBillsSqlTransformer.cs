using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Web;
using BarsWeb.Areas.Bills.Model;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Bills.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for KendoBillsSqlTransformer
    /// </summary>
    public class KendoBillsSqlTransformer : IKendoBillsSqlTransformer
    {
        private readonly IKendoBillsSqlFilter _kendoSqlFilter;
        [Obsolete("Не викодристовувати. Добавлено для підтримки старих версій.")]
        public KendoBillsSqlTransformer()
        {
        }
        public KendoBillsSqlTransformer(IKendoBillsSqlFilter kendoSqlFilter)
        {
            _kendoSqlFilter = kendoSqlFilter;
        }

        public BillsSql TransformSql(BillsSql sql, DataSourceRequest request, string[] dateFieldsNames = null, string extraСonditions = "")
        {
            if (request != null)
            {
                var filteredSql = request.Filters != null && request.Filters.Any() ? _kendoSqlFilter.TransformSql(sql, request, dateFieldsNames, extraСonditions) : sql;
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
                    var newSqlParams = new List<OracleParameter>
                    {
                        new OracleParameter("p_startNumRow", OracleDbType.Int32){Value = startNumRow},
                        new OracleParameter("p_endNumRow", OracleDbType.Int32){Value = endNumRow}
                    };
                    var result = new BillsSql
                    {
                        SqlText = newSql.ToString(),
                        Parameters =
                            filteredSql.Parameters == null ? newSqlParams : filteredSql.Parameters.Concat(newSqlParams).ToList()
                    };
                    return result;
                }
                return filteredSql;
            }
            return sql;
        }
    }
}