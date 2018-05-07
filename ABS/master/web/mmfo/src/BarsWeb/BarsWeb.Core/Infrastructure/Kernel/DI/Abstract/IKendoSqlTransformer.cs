using BarsWeb.Core.Models.Kernel;
using Kendo.Mvc.UI;

namespace BarsWeb.Core.Infrastructure.Kernel.DI.Abstract
{
    public interface IKendoSqlTransformer
    {
        BarsSql TransformSql(BarsSql sql, DataSourceRequest request, string[] dateFieldsNames = null);
        ///<summary>
        ///Трансформация sql запроса не учитывая регистр букв.
        ///</summary>
        BarsSql TransformSqlForSearchAddress(string columnName, BarsSql sql, DataSourceRequest request);
    }
}
