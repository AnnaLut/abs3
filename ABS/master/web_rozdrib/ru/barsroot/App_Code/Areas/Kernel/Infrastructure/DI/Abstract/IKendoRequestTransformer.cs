using System;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract
{
    public interface IKendoRequestTransformer
    {
        DataSourceRequest MultiplyFilterValue(DataSourceRequest request, string fieldName, decimal multiplier = 100);
        DataSourceRequest MultiplyFilterValue(DataSourceRequest request, string[] fieldsName, decimal multiplier = 100);
        DataSourceRequest CenturaDateFilterValue(DataSourceRequest request, string fieldsName);
        DataSourceRequest CenturaDateFilterValue(DataSourceRequest request, string[] fieldsName);
    }
}