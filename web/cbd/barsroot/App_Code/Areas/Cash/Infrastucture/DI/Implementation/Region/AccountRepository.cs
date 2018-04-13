using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Region;
using BarsWeb.Areas.Cash.Infrastructure.Sync;
using Areas.Cash.Models;
using Bars.Classes;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastucture.DI.Implementation.Region
{
    /// <summary>
    /// Счета региональной БД
    /// </summary>
    public class AccountRepository : IAccountRepository
    {
        readonly CashEntities _entities;

        public AccountRepository(ICashModel model)
        {
            _entities = model.CashEntities;
        }

        /// <summary>
        /// Получить список банковских дней
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<V_CLIM_FDAT> GetBankDates()
        {
            return _entities.V_CLIM_FDAT;
        }

        /// <summary>
        /// Получить банковскую дату
        /// </summary>
        /// <exception cref="Exception"></exception>
        public DateTime? GetBankDate()
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.BindByName = true;
                cmd.CommandText = "select bankdate from dual";
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader != null)
                    {
                        if (reader.Read())
                        {
                            return reader["bankdate"] == DBNull.Value ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("bankdate"));
                        }
                    }
                }
            }
            finally
            {
                connection.Close();
            }
            return null;
        }

        /// <summary>
        /// Получить список всех кассовых счетов
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<V_CLIM_ACCOUNTS> GetAccounts()
        {
            return _entities.V_CLIM_ACCOUNTS;
        }

        /// <summary>
        /// Получить архив кассовых остатков
        /// </summary>
        /// <param name="bankDate"></param>
        /// <returns></returns>
        public IEnumerable<RegionAccountRest> GetAccountRests(DateTime bankDate)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            var accountRests = new List<RegionAccountRest>();
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.BindByName = true;
                cmd.CommandText = "select acc_id, mfo, bdate, acc_balance from table(clim_ru_pack.getaccarc(:bankDate))";
                cmd.Parameters.Add("bankDate", bankDate);
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader != null)
                    {
                        while (reader.Read())
                        {
                            var accountRest = new RegionAccountRest
                            {
                                Mfo = reader["mfo"] == DBNull.Value ? "" : reader["mfo"].ToString(),
                                BankDate = reader["bdate"] == DBNull.Value ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("bdate")),
                                Balance = reader["acc_balance"] == DBNull.Value ? 0 : reader.GetDecimal(reader.GetOrdinal("acc_balance")),
                                AccountId = reader["acc_id"] == DBNull.Value ? 0 : reader.GetDecimal(reader.GetOrdinal("acc_id")),
                            };
                            accountRests.Add(accountRest);
                        }
                    }
                }
            }
            finally
            {
                connection.Close();
            }
            return accountRests;
        }

        /// <summary>
        /// Получить список всех отделений (бранчей)
        /// </summary>
        public IQueryable<V_CLIM_BRANCH> GetBranches()
        {
            return _entities.V_CLIM_BRANCH;
        }

        /// <summary>
        /// Получить список всех отделений (бранчей)
        /// </summary>
        public IEnumerable<RegionTransaction> GetTransactions(DateTime bankDate)
        {
            object[] parameters =        
            { 
                new OracleParameter("p_mfo", OracleDbType.Date, bankDate, ParameterDirection.Input)
            };
            var sql = @"select 
                             a.kf as Mfo, 
                             a.acc_sourceid as AccSourceId,
                             a.acc_number as AccNumber,
                             a.Acc_Currency as AccCurrency,
                             a.s as Summa,
                             a.fdat as ""Date"",
                             a.ref as Reference
                         from 
                             table(clim_ru_pack.getAtmTrans(:p_date)) a";

            var transactions = _entities.ExecuteStoreQuery<RegionTransaction>(sql, parameters).ToList();

            /*OracleConnection connection = OraConnector.Handler.UserConnection;
            var transactions = new List<RegionTransaction>();
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.BindByName = true;
                cmd.CommandText = @"select 
                                        a.kf as Mfo, 
                                        a.acc_sourceid as AccSourceId,
                                        a.acc_number as AccNumber,
                                        a.Acc_Currency as AccCurrency,
                                        a.s as Summa,
                                        a.fdat as ""Date"",
                                        a.ref as Reference
                                    from 
                                        table(clim_ru_pack.getAtmTrans(:bankDate)) a";
                cmd.Parameters.Add("bankDate", bankDate);
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader != null)
                    {
                        while (reader.Read())
                        {
                            var transaction = new RegionTransaction
                            {
                                Mfo = reader["Mfo"] == DBNull.Value ? "" : reader["mfo"].ToString(),
                                AccSourceId = reader["AccSourceId"] == DBNull.Value ? 0 : reader.GetDecimal(reader.GetOrdinal("AccSourceId")),
                                AccNumber = reader["AccNumber"] == DBNull.Value ? "" : reader["AccNumber"].ToString(),
                                AccCurrency = reader["AccCurrency"] == DBNull.Value ? 0 : reader.GetDecimal(reader.GetOrdinal("AccCurrency")),
                                Summa = reader["Summa"] == DBNull.Value ? 0 : reader.GetDecimal(reader.GetOrdinal("Summa")),
                                Date = reader["Date"] == DBNull.Value ? (DateTime?)null : reader.GetDateTime(reader.GetOrdinal("Date")),
                                Reference = reader["Reference"] == DBNull.Value ? 0 : reader.GetDecimal(reader.GetOrdinal("Reference"))
                            };
                            transactions.Add(transaction);
                        }
                    }
                }
            }
            finally
            {
                connection.Close();
            }*/
            return transactions;
        }
    }
}