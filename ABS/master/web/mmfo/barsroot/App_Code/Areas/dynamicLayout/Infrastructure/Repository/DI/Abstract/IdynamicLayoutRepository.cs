using Areas.dynamicLayout.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.dynamicLayout.Infrastructure.DI.Abstract
{
    public interface IdynamicLayoutRepository
    {
        IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery);
        decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery);
        IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery);
        int ExecuteStoreCommand(string commandText, params object[] parameters);
        Params GetParam(string id);

        void ClearDynamicLayout();
        void CreateDynamicLayout(decimal? pMode, decimal? pDk, string pNls, string pBs, string pOb, decimal? pGrp);
        void UpdateDynamicLayout(UpdateDynamicLayoutDataModel model);
        void CalculateDynamicLayout(decimal? pId);
        void CalculateStaticLayout();
        string ExeptionProcessing(Exception ex);
        void PayStaticLayout(decimal? pMak);
        void DeleteStaticLayout(decimal? pGrp, decimal? pId);
        void AddStaticLayout(AddStaticLayoutDataModel model);
        ResponseDL ErrorResponse(Exception ex);
        void PaySelectedStaticLayout(SLDetailA model);

        string ErrorResult { get; }
    }
}