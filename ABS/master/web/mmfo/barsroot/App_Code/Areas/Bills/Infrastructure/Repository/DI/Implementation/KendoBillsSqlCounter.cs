using BarsWeb.Areas.Bills.Model;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace BarsWeb.Areas.Bills.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for KendoBillsSqlCounter
    /// </summary>
    public class KendoBillsSqlCounter: IKendoBillsSqlCounter
    {
        private readonly IKendoBillsSqlFilter _kendoSqlFilter;
        [Obsolete("Не викодристовувати. Добавлено для підтримки старих версій.")]
        public KendoBillsSqlCounter()
        {
        }
        public KendoBillsSqlCounter(IKendoBillsSqlFilter kendoSqlFilter)
        {
            _kendoSqlFilter = kendoSqlFilter;
        }
        public BillsSql TransformSql(BillsSql sql, DataSourceRequest request, string[] dateFieldsNames = null)
        {
            var filteredSql = _kendoSqlFilter.TransformSql(sql, request, dateFieldsNames);
            var newSql = new StringBuilder(filteredSql.SqlText);
            newSql.Insert(0, "select count(*) total from (");
            newSql.Append(") main_dataset");
            var result = new BillsSql
            {
                SqlText = newSql.ToString(),
                Parameters = filteredSql.Parameters
            };
            return result;
        }
        [Obsolete("Метод застарів, не вміє рахувати з урахуванням фільтру. Використовуйте TransformSql(BarsSql sql, DataSourceRequest request)")]
        public BillsSql TransformSql(string sql, DataSourceRequest request)
        {
            var newSql = new StringBuilder(sql);
            newSql.Insert(0, "select count(*) total from (");
            newSql.Append(") main_dataset");
            return new BillsSql
            {
                SqlText = newSql.ToString()
            };

        }
    }
}