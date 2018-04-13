using System.Collections.Generic;
using System.Linq;
using Areas.Acct.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Acct.Infrastructure.Repository.DI.Abstract
{
    public interface IAccountsRepository
    {
        /// <summary>
        ///отримати список рахунків
        /// </summary>
        /// <returns></returns>
        IQueryable<V_TOBO_ACCOUNTS_LITE> GetAccounts();
        /// <summary>
        ///отримати список рахунків
        /// </summary>
        /// <param name="branch">бранч</param>
        /// <returns></returns>
        IQueryable<V_TOBO_ACCOUNTS_LITE> GetAccounts(string branch);
        /// <summary>
        /// інформація про рахунок
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        ACCOUNT GetAccount(int id);
        /// <summary>
        /// Групи доступу рахунку
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        List<GROUPS_ACC> GetGroupsAcc(int id);
        /// <summary>
        /// групи доступу які не видані в рахунок 
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <returns></returns>
        IQueryable<GROUPS_ACC> GetGroupsAccNotInGroupsAccs(int id);
        /// <summary>
        /// Довідник груп доступу рахунків
        /// </summary>
        /// <returns></returns>
        IQueryable<GROUPS_ACC> GetHandbookGroupsAcc();

        /// <summary>
        /// Тарифи по рахунку
        /// </summary>
        /// <param name="id">acc рахунку</param>
        /// <param name="request">Пареметри веб запиту </param>
        /// <returns></returns>
        IQueryable<V_SH_TARIF> GetAccountTarif(int id, DataSourceRequest request);
    }
}
