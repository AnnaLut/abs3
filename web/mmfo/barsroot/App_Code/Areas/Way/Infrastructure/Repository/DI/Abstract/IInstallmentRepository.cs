using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

/// <summary>
/// Summary description for IInstallmentRepository
/// </summary>
namespace BarsWeb.Areas.Way.Infrastructure.DI.Abstract
{
    public interface IInstallmentRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);
    }
}
