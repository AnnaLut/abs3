using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.SWCompare.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.SWCompare.Infrastructure.DI.Abstract
{
    public interface ISWCompareRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);
        string LoadRuData(RuPostModel ruPostModel);
        string LoadZsData(ZsPostModel zsPostModel);
        string LoadNBU(NBUPostModel nbuPostModel);
    }
}