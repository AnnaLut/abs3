
using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.BaseRates.Models;
using Kendo.Mvc.UI;
using System;

namespace BarsWeb.Areas.BaseRates.Infrastructure.Repository.DI.Abstract 
{
    public interface IBaseRatesRepository
    {
		IQueryable<V_BRATES_KF> GetBrates();
        List<DDBranches> GetDDBranches();
        List<TbBrates> GetInterestRates(string branch, bool inarchive, int? brtype, int? brid);
        DateTime GetBankDate();
        List<DDKVs> GetKVs();
        void AddInterestBratesToBD(List<TbBrates> list, decimal br_id);
        void AddInterestBrateToBD(TbBrates model, decimal brId);
        void EditInterestBratesToBD(EditInterestBrateRequestModel request);
        void EditInterestBrateToBD(UpdatedRowInterestData rowInterest, decimal brId);
        List<RatesOptions> GetRateOptions(string branch, int brid, int kv, string bdate);
        void DeleteBrate(TbBrates model, decimal br_id);
        List<DDKVs> GetRatesTypes();
        void AddBaseRateToBD(V_BRATES_KF model);
    }
}