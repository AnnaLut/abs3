using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface IKendoSqlTransformer
    {
        BarsSql TransformSql(BarsSql sql, DataSourceRequest request, string[] dateFieldsNames = null);
    }
}