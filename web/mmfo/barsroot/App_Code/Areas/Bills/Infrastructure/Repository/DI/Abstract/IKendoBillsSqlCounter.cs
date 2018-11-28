using BarsWeb.Areas.Bills.Model;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for IKendoBillsSqlCounter
    /// </summary>
    public interface IKendoBillsSqlCounter
    {
        BillsSql TransformSql(BillsSql sql, DataSourceRequest request, string[] dateFieldsNames = null);

        [Obsolete("Метод застарів, не вміє рахувати з урахуванням фільтру. Використовуйте TransformSql(BarsSql sql, DataSourceRequest request)")]
        BillsSql TransformSql(string sql, DataSourceRequest request);
    }
}