using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System.Collections.Generic;

namespace BarsWeb.Areas.NbuIntegration.Infrastructure.DI.Abstract
{
    public interface ISagoRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);
    }
}