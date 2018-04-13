using System;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.Sync;
using Areas.Cash.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center
{
    public interface IAccountRepository
    {
        /// <summary>
        /// Если задано, то репозиторий работает с данным Connection, не создавая новых и не уничтожая данный
        /// </summary>
        OracleConnection Connection { get; set; }

        /// <summary>
        /// Получить список всех кассовых счетов
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_ACC> GetAccounts();

        /// <summary>
        /// Получить архив остатков по счетам
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_ACC_ARC> GetAccountsRest();

        /// <summary>
        /// Проверить есть ли счета
        /// </summary>
        /// <param name="mfo">Фильтр на mfo</param>
        /// <returns></returns>
        bool HasAccounts(string mfo = null);

        /// <summary>
        /// Добавить счет в таблицу счетов
        /// </summary>
        /// <exception cref="Exception"></exception>
        void AddAccountData(RegionAccount regionAccount);

        /// <summary>
        /// Добавить архивный счет в таблицу архивных счетов
        /// </summary>
        /// <exception cref="Exception"></exception>
        void AddAccountRestData(RegionAccountRest accountRest);

        /// <summary>
        /// Добавить отделение (бранч)
        /// </summary>
        /// <exception cref="Exception"></exception>
        void AddBranchData(RegionBranch regionBranch);

        void AddTransactionData(RegionTransaction regionTransaction);

        DateTime GetLoadTransactionDate(string mfo);
    }
}