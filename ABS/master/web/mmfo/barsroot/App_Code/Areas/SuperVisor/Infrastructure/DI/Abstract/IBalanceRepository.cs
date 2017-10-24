using System;
using System.Collections.Generic;
using BarsWeb.Areas.SuperVisor.Models;

namespace BarsWeb.Areas.SuperVisor.Infrastructure.DI.Abstract
{
    public interface IBalanceRepository
    {
        /// <summary>
        /// Run to seed v_show_balance
        /// </summary>
        /// <param name="date"></param>
        /// <param name="kv"></param>
        /// <param name="nbs"></param>
        void SeedBalanceView(DateTime date, string kv, string nbs);

        /// <summary>
        /// Get bank date
        /// </summary>
        /// <returns></returns>
        DateTime BankDate();
        IEnumerable<v_show_balance> BalanceData();
        IEnumerable<v_show_balance> BalanceData(string kf);
        IEnumerable<v_show_balance> BalanceData(string kf, string nbs);
        IEnumerable<tab_val> TabValDictionary();
    }
}