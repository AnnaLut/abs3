using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.Sync;
using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Region
{
    public interface IAccountRepository
    {
        /// <summary>
        /// Получить список банковских дней
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_FDAT> GetBankDates();

        /// <summary>
        /// Получить банковскую дату
        /// </summary>
        /// <exception cref="Exception"></exception>
        DateTime? GetBankDate();

        /// <summary>
        /// Получить список всех кассовых счетов
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_ACCOUNTS> GetAccounts();

        /// <summary>
        /// Получить архив кассовых остатков
        /// </summary>
        /// <param name="bankDate"></param>
        /// <returns></returns>
        IEnumerable<RegionAccountRest> GetAccountRests(DateTime bankDate);

        /// <summary>
        /// Получить список всех отделений (бранчей)
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_BRANCH> GetBranches();
        /// <summary>
        /// Получить список транзакцій
        /// </summary>
        /// <param name="bankDate"></param>
        /// <returns></returns>
        IEnumerable<RegionTransaction> GetTransactions(DateTime bankDate);
    }
}