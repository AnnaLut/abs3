using System.Data.Objects;
using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Models;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System;
using System.IO;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISepTechAccountsRepository
    {
       
        DateTime? GetBankDate();

        IQueryable<SEPTECHACCOUNT_V1> GetSEPTECHACCOUNTV1(SepTechAccountsFilterParams filterParams, DataSourceRequest request, string parameters);

        IQueryable<SEPTECHACCOUNT_V2> GetSEPTECHACCOUNTV2(SepTechAccountsFilterParams filterParams, DataSourceRequest request, string parameters);

        IQueryable<SEPTECHACCOUNT_VQF> GetSEPTECHACCOUNTVQF(SepTechAccountsFilterParams filterParams, DataSourceRequest request,string parameters);
         
        IEnumerable<SEPTECHACCOUNT_V2> GetCashFlowPeriod(SepTechAccountsFilterParams fp, DataSourceRequest request);

        List<SepHistoryAccDoc> GetGridHistoryAccList(SepTechAccountsFilterParams fp, DataSourceRequest request);

        ObjectResult<SepHistoryAccChangeParamDoc> GetGridHistoryAccChangeParamList(SepTechAccountsFilterParams fp, DataSourceRequest request);

        IQueryable<SEPTECHACCOUNT_V2> GetLinkedAcc(SepTechAccountsFilterParams fp, DataSourceRequest request);

        ObjectResult<SepFileDoc> GetSepReplyTechDocsData(SepTechAccountsFilterParams fp, DataSourceRequest request);

        ObjectResult<SepInternInitModel> GetSepInternInitDocsData(SepTechAccountsFilterParams fp, DataSourceRequest request);
        
        List<SepCurrencySum> GetCurrencySummaryList(SepTechAccountsFilterParams fp, DataSourceRequest request);

        ObjectResult<SepTechAccountsSelectItem> GetHistoryParamSelect(SepTechAccountsFilterParams fp, DataSourceRequest request);

        ObjectResult<SepTechAccountsSelectItem> GetHistoryParamSelectFromSelect1(SepTechAccountsFilterParams fp, DataSourceRequest request);

        decimal GetCashFlowPeriodCount(SepTechAccountsFilterParams fp, DataSourceRequest request);

        decimal GetSepInternInitDocsCount(SepTechAccountsFilterParams fp, DataSourceRequest request);

        // Proccessing:

        IQueryable<ProccessingModel> GetProccessingData(decimal acc, string tip, decimal? kv, string dat, string query, DataSourceRequest request);

        MemoryStream ExportExcel(IQueryable<ProccessingModel> data);
        decimal GetProccessingDataCount(decimal acc, string tip, decimal? kv, string dat, string query, DataSourceRequest request);
        ProccessingOstModel GetOstByDate(decimal acc, string dat);
        decimal? GetRefByRec(decimal rec);

        // Percent calculator
        ProcCard GetCard(decimal? acc);

    }

}