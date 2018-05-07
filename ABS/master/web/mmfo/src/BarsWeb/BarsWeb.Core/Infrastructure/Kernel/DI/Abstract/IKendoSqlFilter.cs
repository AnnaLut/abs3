using BarsWeb.Core.Models.Kernel;
using Kendo.Mvc.UI;

namespace BarsWeb.Core.Infrastructure.Kernel.DI.Abstract
{
    public interface IKendoSqlFilter
    {
        BarsSql TransformSql(BarsSql sql, DataSourceRequest request, string[] dateFieldsNames = null);
    }
}
