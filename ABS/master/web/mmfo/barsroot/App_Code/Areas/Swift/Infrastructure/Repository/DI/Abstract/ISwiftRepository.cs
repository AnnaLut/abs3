using Areas.Swift.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Abstract
{
    public interface ISwiftRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);
        List<SwiftGPIStatuses> GetMTGridItems();
        IEnumerable<T> GetMTGridItemsFast<T>(DataSourceRequest request, BarsSql mtQuery);
        List<SwiftGPIStatusesMT199> GetMT199GridItems(string uetr);
    }
}