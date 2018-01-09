using System;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface IKendoSqlCounter
    {
        BarsSql TransformSql(BarsSql sql, DataSourceRequest request, string[] dateFieldsNames = null);
        [Obsolete("Метод застарів, не вміє рахувати з урахуванням фільтру. Використовуйте TransformSql(BarsSql sql, DataSourceRequest request)")]
        BarsSql TransformSql(string sql, DataSourceRequest request);
    }
}