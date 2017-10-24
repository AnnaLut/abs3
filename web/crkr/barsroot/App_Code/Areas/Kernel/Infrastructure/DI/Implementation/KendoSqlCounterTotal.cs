using System;
using System.Linq;
using System.Text;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public class KendoSqlCounterTotal : IKendoSqlCounter
    {
        private readonly IKendoSqlFilter _kendoSqlFilter;
        [Obsolete("Не викодристовувати. Добавлено для підтримки старих версій.")]
        public KendoSqlCounterTotal()
        {
        }
        public KendoSqlCounterTotal(IKendoSqlFilter kendoSqlFilter)
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
        [Obsolete("Метод застарів, не вміє рахувати з урахуванням фільтру. Використовуйте TransformSql(BarsSql sql, DataSourceRequest request)")]
        public BarsSql TransformSql(string sql, DataSourceRequest request)
        {
            var newSql = new StringBuilder(sql);
            newSql.Insert(0, "select count(*) total from (");
            newSql.Append(") main_dataset");
            return new BarsSql
            {
                SqlText = newSql.ToString()
            };
                
        }
    }
    
}
