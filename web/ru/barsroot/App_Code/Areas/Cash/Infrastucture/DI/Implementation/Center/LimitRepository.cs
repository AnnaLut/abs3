using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;
using Bars.Classes;
using BarsWeb.Areas.Cash.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastucture.DI.Implementation.Center
{
    /// <summary>
    /// Лимиты на счета
    /// </summary>
    public class LimitRepository : ILimitRepository
    {
        readonly CashEntities _entities;

        public LimitRepository(ICashModel model)
        {
            _entities = model.CashEntities;
        }

        public IQueryable<V_CLIM_VIOLATIONS_LIM> GetAccountLimitViolations()
        {
            return _entities.V_CLIM_VIOLATIONS_LIM;
        }

        public IQueryable<V_CLIM_VIOLATIONS_TRESHOLD> GetAccountViolationsTresholds()
        {
            return _entities.V_CLIM_VIOLATIONS_TRESHOLD;
        }

        /// <summary>
        /// Получить список лимитов на счета
        /// </summary>
        public IQueryable<V_CLIM_ACCOUNT_LIMIT> GetAccountLimits()
        {
            return _entities.V_CLIM_ACCOUNT_LIMIT;
        }

        public IQueryable<AtmLimit> GetAtmLimits()
        {
            return _entities.V_CLIM_ATM_LIMIT.Select(i=> new AtmLimit
            {
                Id= i.ACC_ID,
                AtmCode = i.COD_ATM,
                Branch = i.ACC_BRANCH,
                Kf= i.KF,
                MfoName = i.NAME,
                AccNumber = i.ACC_NUMBER,
                Name = i.ACC_NAME,
                Currency = i.ACC_CURRENCY,
                Balance = i.ACC_BAL / 100,
                LimitMaxLoad = i.LIM_MAXLOAD / 100,
                CashType = i.ACC_CASHTYPE,
                ClosedDate = i.ACC_CLOSE_DATE,
                DaysShow = i.DAYS_SHOW,
                Colour = i.COLOUR,
                LimitViolated = (i.ACC_BAL > i.LIM_MAXLOAD ? 1 : 0),
                LimitViolatedName = (i.ACC_BAL > i.LIM_MAXLOAD ?"Так" : "Ні")
            });
        }

        /// <summary>
        /// Получить список лимитов на счета
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<V_CLIM_ACCOUNT_LIMIT> GetAccountLimits(string mfo)
        {
            return _entities.V_CLIM_ACCOUNT_LIMIT.Where(i => i.KF == mfo);
        }

        /// <summary>
        /// Получить список лимитов на счета
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<V_CLIM_ACCOUNT_LIMIT> GetAccountLimits(string mfo, string branch)
        {
            return _entities.V_CLIM_ACCOUNT_LIMIT.Where(i => i.KF == mfo && i.ACC_BRANCH == branch);
        }

        /// <summary>
        /// Получить список лимитов на счета
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<V_CLIM_ACCOUNT_LIMIT> GetAccountLimits(string mfo, string branch, decimal? currency)
        {
            return _entities.V_CLIM_ACCOUNT_LIMIT.Where(
                i => i.KF == mfo 
                && i.ACC_BRANCH == branch
                && i.ACC_CURRENCY == currency);
        }

        /// <summary>
        /// порушення по банкоматах
        /// </summary>
        /// <returns></returns>
        public IQueryable<V_CLIM_ATM_VIOLATION> GetAtmViolations()
        {
            return _entities.V_CLIM_ATM_VIOLATION;
        }

        /// <summary>
        /// порушення по косових рахунках
        /// </summary>
        /// <returns></returns>
        public IQueryable<V_CLIM_CASH_VIOLATION> GetCashViolations()
        {
            return _entities.V_CLIM_CASH_VIOLATION;
        }

        /// <summary>
        /// порушення по косових рахунках Бранча
        /// </summary>
        /// <returns></returns>
        public IQueryable<V_CLIM_CASHBRANCH_VIOLATION> GetCashBranchViolations()
        {
            return _entities.V_CLIM_CASHBRANCH_VIOLATION;
        }

        /// <summary>
        /// Получить список лимитов на МФО
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<V_CLIM_MFOLIM> GetMfoLimits()
        {
            return _entities.V_CLIM_MFOLIM;
        }
        public List<Models.Limits> GetLimitsOnDate(string date)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_date",OracleDbType.Varchar2,date,ParameterDirection.Input)
            };
            const string sql = @"select 
                                    t.kf as kf
                                    ,ru_name as MfoName
                                    ,t.kv as kv
                                    ,t.sum_bal /100 as SumBal
                                    ,t.lim_type as limitType
                                    ,t.lim_current / 100 as limcurrent
                                    ,t.lim_max / 100 as limmax
                                    ,t.acc_lim_current / 100 as acclimcurrent
                                    ,t.acc_lim_max / 100 as acclimmax  
                                    ,t.sum_over_lim / 100 as SumOverLimit
                                    ,t.sum_over_maxlim / 100 as SumOverMaxLimit
                                    ,t.next_lim_current / 100 as NextLimCurrent
                                    ,t.next_start_date as NextStartDate 
                                from 
                                    table(clim_lim.getmfolimit(to_date(:p_date, 'dd/mm/yyyy'))) t";
            var result = _entities.ExecuteStoreQuery<Models.Limits>(sql, parameters).ToList();
            return result;
        }

        public IQueryable<MfoLimitPlan> GetMfoLimitPlan(string kf, decimal? kv)
        {
            return _entities.CLIM_MFO_LIMIT.Where(i => i.KF == kf && i.KV == kv)
                .Select(i=> new MfoLimitPlan
            {
                Kf = i.KF,
                Kv = i.KV,
                LimCurrent = i.LIM_CURRENT / 100,
                LimMax = i.LIM_MAX / 100,

                StartDate = i.START_DATE,
                SetDate = i.SET_DATE,
                LimitType = i.LIM_TYPE
            });
        }

        public decimal? GetMaxAccLimitOnDate(string kf, decimal? kv, string date)
        {
            decimal? result = 0;
            var limit = GetLimitsOnDate(date).FirstOrDefault(i=> i.Kf == kf && i.Kv == kv);
            if (limit != null)
            {
                result = limit.SumOverLimit;
            }

            return result;
        }

        public void SetMfoLimit(Models.Limits limit, string date)
        {

            object[] parameters =        
            {                
                new OracleParameter("p_mfo",OracleDbType.Varchar2,limit.Kf,ParameterDirection.Input),
                new OracleParameter("p_kv",OracleDbType.Decimal,limit.Kv,ParameterDirection.Input),

                new OracleParameter("p_limcur",OracleDbType.Decimal,limit.LimCurrent * 100,ParameterDirection.Input),
                new OracleParameter("p_limmax",OracleDbType.Decimal, limit.LimMax * 100,ParameterDirection.Input),
                new OracleParameter("p_startdate",OracleDbType.Varchar2,date,ParameterDirection.Input)
            };
            _entities.ExecuteStoreCommand(@"begin 
                                                clim_lim.set_mfolim(
                                                    :p_mfo,
                                                    :p_kv,
                                                    :p_limcur,
                                                    :p_limmax,
                                                    to_date(:p_startdate, 'dd/mm/yyyy')); 
                                                end;", parameters);
        }

        public void DeleteMfoLimit(string mfo, decimal? kv, string date, string limitType)
        {
            object[] parameters =        
            {                
                new OracleParameter("p_mfo",OracleDbType.Varchar2,mfo,ParameterDirection.Input),
                new OracleParameter("p_kv",OracleDbType.Decimal,kv,ParameterDirection.Input),
                new OracleParameter("p_startdate",OracleDbType.Varchar2,date,ParameterDirection.Input),
                new OracleParameter("p_limtype",OracleDbType.Varchar2,limitType,ParameterDirection.Input)
            };
            _entities.ExecuteStoreCommand(@"begin 
                                                clim_lim.del_mfolim(
                                                    :p_mfo,
                                                    :p_kv,
                                                    to_date(:p_startdate, 'dd/mm/yyyy'),
                                                    :p_limtype); 
                                                end;", parameters);
        }

        /// <summary>
        /// Установить лимит на счет (если лимита нет - добавить, если есть - обновить)
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void SetAccountLimit(AccountLimit limit)
        {
            var dbModel = ModelConverter.ToDbModel(limit);
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.BindByName = true;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "clim_lim.set_acclim";
                cmd.Parameters.Add("p_acc_id", dbModel.ACC_ID);
                cmd.Parameters.Add("p_limcur", dbModel.LIM_CURRENT * 100);
                cmd.Parameters.Add("p_limmax", dbModel.LIM_MAX * 100);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Установить лимит на счет (если лимита нет - добавить, если есть - обновить)
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void SetAccountLimit(decimal accountId, decimal? currentLimit, decimal? maxLimit)
        {
            var accountLimit = new AccountLimit
            {
                AccountId = accountId,
                CurrentLimit = currentLimit,
                MaxLimit = maxLimit
            };
            SetAccountLimit(accountLimit);
        }

        /// <summary>
        /// Установить лимит на МФО (если лимита нет - добавить, если есть - обновить)
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void SetMfoLimit(MfoLimit limit)
        {
            var dbModel = ModelConverter.ToDbModel(limit);
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.BindByName = true;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "clim_lim.set_mfolim";
                cmd.Parameters.Add("p_mfo", dbModel.KF);
                cmd.Parameters.Add("p_limtype", dbModel.LIM_TYPE);
                cmd.Parameters.Add("p_kv", dbModel.KV);
                cmd.Parameters.Add("p_limcur", dbModel.LIM_CURRENT * 100);
                cmd.Parameters.Add("p_limmax", dbModel.LIM_MAX * 100);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Згруповані по валютам порушення по МФО
        /// </summary>
        /// <returns></returns>
        public IQueryable<V_CLIM_MFOLIM> GetCashViolGrpMfoKv()
        {
            return _entities.V_CLIM_MFOLIM;
        }

        /// <summary>
        /// згруповані по бранчам порушення 
        /// </summary>
        /// <returns></returns>
        public IQueryable<V_CLIM_CASHVIOL_GRPBRANCHKV> GetCashViolGrpBranchKv(string kf, decimal kv)
        {
            return _entities.V_CLIM_CASHVIOL_GRPBRANCHKV.Where(i => i.KF == kf && i.ACC_CURRENCY == kv);
        }

        public IQueryable<V_CLIM_ACCOUNT_LIMIT_ARC> GetAccountLimitArc(decimal accId)
        {
            return _entities.V_CLIM_ACCOUNT_LIMIT_ARC.Where(i=>i.ACC_ID == accId);
        }

        public IQueryable<V_CLIM_ACCOUNT_LIMIT_ARC> GetAccountLimitArc(DateTime? dateStart, DateTime? dateEnd)
        {
            return _entities.V_CLIM_ACCOUNT_LIMIT_ARC.Where(i=>i.LDAT >= dateStart && i.LDAT <= dateEnd);
        }

        public IQueryable<V_CLIM_BRANCH_LIMIT_ARC> GetBranchLimitArc(string branch)
        {
            return _entities.V_CLIM_BRANCH_LIMIT_ARC.Where(i=> i.ACC_BRANCH == branch);
        }

        public IQueryable<V_CLIM_BRANCH_LIMIT_ARC> GetBranchLimitArc(DateTime? dateStart, DateTime? dateEnd)
        {
            return _entities.V_CLIM_BRANCH_LIMIT_ARC.Where(i => i.LDAT >= dateStart && i.LDAT <= dateEnd);
        }

        public IQueryable<V_CLIM_MFO_LIMIT_ARC> GetMfoLimitArc(string mfo)
        {
            return _entities.V_CLIM_MFO_LIMIT_ARC.Where(i=> i.KF == mfo);
        }

        public IQueryable<V_CLIM_MFO_LIMIT_ARC> GetMfoLimitArc(DateTime? dateStart, DateTime? dateEnd)
        {
            return _entities.V_CLIM_MFO_LIMIT_ARC.Where(i => i.LIM_DATE >= dateStart && i.LIM_DATE <= dateEnd);
        }

        public IQueryable<V_CLIM_ATM_LIMIT_ARC> GetAtmLimitArc(string atmCode)
        {
            return _entities.V_CLIM_ATM_LIMIT_ARC.Where(i=> i.COD_ATM == atmCode);
        }

        public IQueryable<V_CLIM_ATM_LIMIT_ARC> GetAtmLimitArc(DateTime? dateStart, DateTime? dateEnd)
        {
            return _entities.V_CLIM_ATM_LIMIT_ARC.Where(i => i.FDAT >= dateStart && i.FDAT <= dateEnd);
        }
    }
}