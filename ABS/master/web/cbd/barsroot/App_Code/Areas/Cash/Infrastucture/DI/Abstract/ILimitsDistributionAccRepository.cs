using System;
using System.Collections.Generic;
using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract
{
    public interface ILimitsDistributionAccRepository
    {
        List<LimitsDistributionAcc> GetAll(string date);
        DataSourceResult GetAllToDataSourceResult(string date, DataSourceRequest request);
        IQueryable<AccLimitPlan> GetPlan(int id);
        LimitsDistributionAcc Get(int id,string date);
        UpdateDbStatus Add(LimitsDistributionAcc linDist, string date);
        UpdateDbStatus Edit(LimitsDistributionAcc limDist, string date);
        bool Delete(int id, string date);
        UpdateDbStatus UploadFile(DateTime date, byte[] file);

        IQueryable<V_CLIM_LOG_LOADXLS_ACCLIM> GetAccProtocolData(decimal sessionId);

    }
}
