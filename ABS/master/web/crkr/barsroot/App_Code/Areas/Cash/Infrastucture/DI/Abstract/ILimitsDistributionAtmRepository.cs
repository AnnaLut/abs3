using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Cash.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Abstract
{
    public interface ILimitsDistributionAtmRepository
    {
        List<LimitsDistributionAtm> GetAll(string date);
        DataSourceResult GetAllToDataSourceResult(string date, DataSourceRequest request);
        IQueryable<AtmLimitPlan> GetPlan(int id);
        LimitsDistributionAtm Get(int id,string date);
        LimitsDistributionAtm Add(LimitsDistributionAtm linDist,string date);
        LimitsDistributionAtm Edit(LimitsDistributionAtm limDist, string date);
        bool Delete(int id, string date);
        UpdateDbStatus UploadFile(DateTime date, byte[] file);
    }
}
