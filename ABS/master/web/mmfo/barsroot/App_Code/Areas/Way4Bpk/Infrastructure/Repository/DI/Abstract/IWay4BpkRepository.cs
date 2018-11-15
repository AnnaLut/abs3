using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Way4Bpk.Infrastructure.DI.Abstract
{
    public interface IWay4BpkRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);

        bool GetDocumentVerifiedState(decimal rnk);
        void SetDocumentVerifiedState(decimal rnk, decimal state);
        string GetKf();
        List<Bars.EAD.Structs.Result.DocumentData> CheckDocs(List<Bars.EAD.Structs.Result.DocumentData> val);
    }
}