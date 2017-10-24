using System;
using System.Collections.Generic;
using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center
{
    public interface ILimitRepository
    {
        /// <summary>
        /// Получить список нарушений лимитов по счетам
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_VIOLATIONS_LIM> GetAccountLimitViolations();

        IQueryable<V_CLIM_VIOLATIONS_TRESHOLD> GetAccountViolationsTresholds();
        /// <summary>
        /// получить список лімітів на банкомати
        /// </summary>
        /// <returns></returns>
        IQueryable<AtmLimit> GetAtmLimits();
        /// <summary>
        /// Получить список лимитов на счета
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_ACCOUNT_LIMIT> GetAccountLimits();
        /// <summary>
        /// Получить список лимитов на счета
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_ACCOUNT_LIMIT> GetAccountLimits(string mfo);
        /// <summary>
        /// Получить список лимитов на счета
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_ACCOUNT_LIMIT> GetAccountLimits(string mfo, string branch);
        /// <summary>
        /// Получить список лимитов на счета
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_ACCOUNT_LIMIT> GetAccountLimits(string mfo, string branch, decimal? currency);
        /// <summary>
        /// порушення по банкоматах
        /// </summary>
        /// <returns></returns>
        IQueryable<V_CLIM_ATM_VIOLATION> GetAtmViolations();
        /// <summary>
        /// порушення по косових рахунках
        /// </summary>
        /// <returns></returns>
        IQueryable<V_CLIM_CASH_VIOLATION> GetCashViolations();
        /// <summary>
        /// порушення по косових рахунках Бранч
        /// </summary>
        /// <returns></returns>
        IQueryable<V_CLIM_CASHBRANCH_VIOLATION> GetCashBranchViolations();
        /// <summary>
        /// Получить список лимитов на МФО
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<V_CLIM_MFOLIM> GetMfoLimits();
        /// <summary>
        /// Получить список лимитов на МФО на дату
        /// </summary>
        /// <param name="date">дата</param>
        /// <returns></returns>
        List<Limits> GetLimitsOnDate(string date);

        IQueryable<MfoLimitPlan> GetMfoLimitPlan(string kf, decimal? kv);
        void SetMfoLimit(Limits limit, string date);
        void DeleteMfoLimit(string mfo, decimal? kv, string date,string limitType);

        /// <summary>
        /// Установить лимит на счет (если лимита нет - добавить, если есть - обновить)
        /// </summary>
        /// <exception cref="Exception"></exception>
        void SetAccountLimit(AccountLimit limit);

        /// <summary>
        /// Установить лимит на счет (если лимита нет - добавить, если есть - обновить)
        /// </summary>
        /// <exception cref="Exception"></exception>
        void SetAccountLimit(decimal accountId, decimal? currentLimit, decimal? maxLimit);

        /// <summary>
        /// Установить лимит на МФО (если лимита нет - добавить, если есть - обновить)
        /// </summary>
        /// <exception cref="Exception"></exception>
        void SetMfoLimit(MfoLimit limit);

        /// <summary>
        /// Згруповані по валютам порушення по МФО
        /// </summary>
        /// <returns></returns>
        IQueryable<V_CLIM_MFOLIM> GetCashViolGrpMfoKv();
        /// <summary>
        /// згруповані по бранчам порушення 
        /// </summary>
        /// <returns></returns>
        IQueryable<V_CLIM_CASHVIOL_GRPBRANCHKV> GetCashViolGrpBranchKv(string kf, decimal kv);


        /// <summary>
        /// history of the account
        /// </summary>
        /// <param name="accId">account id</param>
        /// <returns></returns>
        IQueryable<V_CLIM_ACCOUNT_LIMIT_ARC> GetAccountLimitArc(decimal accId);
        /// <summary>
        /// history of accounts by dates
        /// </summary>
        /// <param name="dateStart">Date start</param>
        /// <param name="dateEnd">Date end</param>
        /// <returns></returns>
        IQueryable<V_CLIM_ACCOUNT_LIMIT_ARC> GetAccountLimitArc(DateTime? dateStart, DateTime? dateEnd);
        /// <summary>
        /// history of the branch
        /// </summary>
        /// <param name="branch">Branch code</param>
        /// <returns></returns>
        IQueryable<V_CLIM_BRANCH_LIMIT_ARC> GetBranchLimitArc(string branch);
        /// <summary>
        /// history of branches by dates
        /// </summary>
        /// <param name="dateStart">Date start</param>
        /// <param name="dateEnd">Date end</param>
        /// <returns></returns>
        IQueryable<V_CLIM_BRANCH_LIMIT_ARC> GetBranchLimitArc(DateTime? dateStart, DateTime? dateEnd);
        /// <summary>
        /// history of the bank
        /// </summary>
        /// <param name="mfo">Bank code</param>
        /// <returns></returns>
        IQueryable<V_CLIM_MFO_LIMIT_ARC> GetMfoLimitArc(string mfo);
        /// <summary>
        /// history of banks by dates
        /// </summary>
        /// <param name="dateStart">Date start</param>
        /// <param name="dateEnd">Date end</param>
        /// <returns></returns>
        IQueryable<V_CLIM_MFO_LIMIT_ARC> GetMfoLimitArc(DateTime? dateStart, DateTime? dateEnd);
        /// <summary>
        /// histori of the atm
        /// </summary>
        /// <param name="mfo">Atm code</param>
        /// <returns></returns>
        IQueryable<V_CLIM_ATM_LIMIT_ARC> GetAtmLimitArc(string mfo);
        /// <summary>
        /// history of atms by dates
        /// </summary>
        /// <param name="dateStart">Date start</param>
        /// <param name="dateEnd">Date end</param>
        /// <returns></returns>
        IQueryable<V_CLIM_ATM_LIMIT_ARC> GetAtmLimitArc(DateTime? dateStart, DateTime? dateEnd);
    }
}