using System;
using System.Data;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using BarsWeb.Areas.Cash.Infrastructure.Sync;
using Areas.Cash.Models;
using Bars.Classes;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastucture.DI.Implementation.Center
{
    /// <summary>
    /// Счета центральной БД
    /// </summary>
    public class AccountRepository : IAccountRepository
    {
        readonly CashEntities _entities;

        /// <summary>
        /// Если задано, то репозиторий работает с данным Connection, не создавая новых и не уничтожая данный
        /// </summary>
        public OracleConnection Connection { get; set; }

        public AccountRepository(ICashModel model)
        {
            _entities = model.CashEntities;
        }

        /// <summary>
        /// Получить список всех кассовых счетов
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<V_CLIM_ACC> GetAccounts()
        {
            return _entities.V_CLIM_ACC;
        }

        /// <summary>
        /// Получить архив остатков по счетам
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<V_CLIM_ACC_ARC> GetAccountsRest()
        {
            return _entities.V_CLIM_ACC_ARC;
        }

        /// <summary>
        /// Проверить есть ли счета
        /// </summary>
        /// <param name="mfo">Фильтр на mfo</param>
        /// <returns></returns>
        public bool HasAccounts(string mfo = null)
        {
            IQueryable<V_CLIM_ACC> accounts = GetAccounts();
            if (!string.IsNullOrEmpty(mfo))
            {
                accounts = accounts.Where(f => f.KF == mfo);
            }
            return accounts.Any();
        }

        /// <summary>
        /// Добавить счет в таблицу счетов
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void AddAccountData(RegionAccount regionAccount)
        {
            OracleConnection connection = Connection ?? OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "clim_sync_acc.set_acc_data";

                cmd.Parameters.Add("p_mfo", regionAccount.Mfo);
                cmd.Parameters.Add("p_branch", regionAccount.Branch);
                cmd.Parameters.Add("p_acccashtype", regionAccount.CashType);
                cmd.Parameters.Add("p_acc_id", regionAccount.AccountId);
                cmd.Parameters.Add("p_acc_balnumber", regionAccount.BalNumber);
                cmd.Parameters.Add("p_acc_number", regionAccount.AccountNumber);
                cmd.Parameters.Add("p_acc_ob22", regionAccount.Ob22);
                cmd.Parameters.Add("p_acc_currency", regionAccount.Currency);
                cmd.Parameters.Add("p_acc_name", regionAccount.AccountName);
                cmd.Parameters.Add("p_acc_balance", regionAccount.Balance);
                cmd.Parameters.Add("p_acc_open_date", regionAccount.OpenDate);
                cmd.Parameters.Add("p_acc_close_date", regionAccount.CloseDate);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (Connection == null)
                {
                    connection.Close();
                }
            }
        }

        /// <summary>
        /// Добавить архивный счет в таблицу архивных счетов
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void AddAccountRestData(RegionAccountRest accountRest)
        {
            OracleConnection connection = Connection ?? OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "clim_sync_acc.set_acc_arc_data";
                cmd.Parameters.Add("p_mfo", accountRest.Mfo);
                cmd.Parameters.Add("p_acc_id", accountRest.AccountId);
                cmd.Parameters.Add("p_balance_date", accountRest.BankDate);
                cmd.Parameters.Add("p_acc_balance", accountRest.Balance);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (Connection == null)
                {
                    connection.Close();
                }
            }
        }

        /// <summary>
        /// Добавить отделение (бранч)
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void AddBranchData(RegionBranch regionBranch)
        {
            OracleConnection connection = Connection ?? OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "clim_sync_acc.sync_branch_row";
                cmd.Parameters.Add("p_branch", regionBranch.Branch);
                cmd.Parameters.Add("p_branch_name", regionBranch.Name);
                cmd.Parameters.Add("p_branch_b040", regionBranch.B040);
                cmd.Parameters.Add("p_branch_desc", regionBranch.Description);
                cmd.Parameters.Add("p_branch_idpdr", regionBranch.IdPdr);
                cmd.Parameters.Add("p_branch_dateop", regionBranch.OpenDate);
                cmd.Parameters.Add("p_branch_datecl", regionBranch.CloseDate);
                cmd.Parameters.Add("p_branch_del", regionBranch.DeleteDate);
                cmd.Parameters.Add("p_branch_sab", regionBranch.Sab);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (Connection == null)
                {
                    connection.Close();
                }
            }
        }

        public void AddTransactionData(RegionTransaction regionTransaction)
        {
            OracleConnection connection = Connection ?? OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "clim_sync_acc.set_atm_transaction";
                cmd.Parameters.Add("p_mfo", regionTransaction.Mfo);
                cmd.Parameters.Add("p_acc_sourceid", regionTransaction.AccSourceId);
                cmd.Parameters.Add("p_acc_number", regionTransaction.AccNumber);
                cmd.Parameters.Add("p_acc_currency", regionTransaction.AccCurrency);
                cmd.Parameters.Add("p_s", regionTransaction.Summa);
                cmd.Parameters.Add("p_fdat", regionTransaction.Date);
                cmd.Parameters.Add("p_ref", regionTransaction.Reference);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (Connection == null)
                {
                    connection.Close();
                }
            }
        }

        public DateTime GetLoadTransactionDate(string mfo)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_mfo", OracleDbType.Varchar2, mfo, ParameterDirection.Input)
            };
            var date = _entities.ExecuteStoreQuery<DateTime>(
                                "select clim_sync_acc.date_loadtrans(:p_mfo) from dual", 
                                parameters
                ).FirstOrDefault();
            return date;
        }
    }
}