using System.Linq;
using Areas.Sep.Models;
using BarsWeb.Areas.Sep.Models;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using Bars.Areas.Sep.Models;
using System;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract
{
    public interface ISep3720Repository
    {
        IQueryable<Sep3720> GetSep3720List(DataSourceRequest request, AccessType accessType);
        decimal GetSep3720Count(AccessType accessType, DataSourceRequest request);
        void DeleteSep3720Record(decimal reference);
        IQueryable<ACCOUNTS> GetAccount();
        IQueryable<CUSTOMER> GetCustomer();
        Sep3720AltAccount GetAltAccount(string nls, decimal? kv);
        int SetToAltAccounts(string docList);
        List<SetRequestResult> SetRequest(List<Sep3720> extAttributes);
        decimal GetSumT902();
        decimal SumT902Docs3720();
        List<Sep3720Register> GetSep3720RegisterList(Int32 register_tp, String register_dt_from, String register_dt_to);
    }
}