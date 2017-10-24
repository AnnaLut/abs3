using Areas.RequestsProcessing.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.RequestsProcessing.Infrastructure.DI.Abstract
{
    public interface IRequestsProcessingRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);
        List<DynamicDictResult> GetDynamicDict(DynamicRequestData obj);
        List<Dictionary<string, object>> GetDynamic(DynamicRequestData obj);
    }
}