using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.FinView.Models;

namespace BarsWeb.Areas.FinView.Infrastructure.DI.Abstract
{
    public interface IFinanceRepository
    {
        IQueryable<Balance> BalanceViewData(string date, decimal rowType, string branch);
        ExchangeRate CurrentExchangeRate(string dDate);
        IQueryable<Branch> Branches();
        IQueryable<Account> AccountData(string kf, string nbs, string branch, string kv, string date);
        IQueryable<Document> DocumentData(decimal acc, string date);
        IEnumerable<kvData> TabValDictionary();
    }
}