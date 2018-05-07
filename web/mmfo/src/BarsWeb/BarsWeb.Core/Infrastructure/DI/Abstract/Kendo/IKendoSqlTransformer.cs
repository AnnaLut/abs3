using BarsWeb.Core.Models.Kernel;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BarsWeb.Core.Infrastructure.DI.Abstract.Kendo
{
    interface IKendoSqlTransformer
    {
        BarsSql TransformSql(BarsSql sql, DataSourceRequest request, string[] dateFieldsNames = null);
    }
}
