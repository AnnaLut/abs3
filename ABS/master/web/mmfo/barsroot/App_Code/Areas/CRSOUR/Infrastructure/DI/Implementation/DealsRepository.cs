using System;
using System.Data;
using System.Linq;
using System.Collections.Generic;
using BarsWeb.Areas.CRSOUR.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CRSOUR.Infrastructure.Repository.DI.Abstract;
using Areas.CRSOUR.Models;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.CRSOUR.Infrastucture.DI.Implementation
{
    public class DealsRepository : IDealsRepository
    {
        readonly DealsEntities _entities;
        public DealsRepository(IDealsModel model)
        {
            _entities = model.DealsEntities;
        }

        /// <summary>
        /// Получить простой список заявок
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<V_CDB_CLAIM_DATA_TO_ACCEPT> GetSimpleClaims()
        {
            return _entities.V_CDB_CLAIM_DATA_TO_ACCEPT;
        }

        /// <summary>
        /// Подтвердить обработку заявки
        /// </summary>
        /// <exception cref="Exception"></exception>
        public bool SubmitClaim(int claimId, out string message)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "cdb.cdb_ui.accept_claim";
                cmd.Parameters.Add("p_claim_id", claimId);

                // без повторного указания типа ошибка при вычитке (Unable to cast object of type 'Oracle.DataAccess.Types.OracleDecimal' to type 'System.IConvertible')
                cmd.Parameters.Add("p_is_success", OracleDbType.Decimal).Direction = ParameterDirection.Output;
                cmd.Parameters["p_is_success"].DbType = DbType.Decimal;

                cmd.Parameters.Add("p_message", OracleDbType.NVarchar2, 4000).Direction = ParameterDirection.Output;
                cmd.Parameters["p_message"].DbType = DbType.String;

                cmd.ExecuteNonQuery();
                message = Convert.ToString(cmd.Parameters["p_message"].Value);
                var success = Convert.ToDecimal(cmd.Parameters["p_is_success"].Value) == 1;
                return success;
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Получить список заявок
        /// </summary>
        /// <returns></returns>
        public IQueryable<V_CDB_CLAIM> GetComplexClaims()
        {
            return _entities.V_CDB_CLAIM;
        }

        /// <summary>
        /// Отменить обработку заявки
        /// </summary>
        /// <exception cref="Exception"></exception>
        public bool CancelClaim(int claimId, string comment, out string message)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "cdb.cdb_ui.cancel_claim";
                cmd.Parameters.Add("p_claim_id", claimId);
                cmd.Parameters.Add("p_comment", comment);

                // без повторного указания типа ошибка при вычитке (Unable to cast object of type 'Oracle.DataAccess.Types.OracleDecimal' to type 'System.IConvertible')
                cmd.Parameters.Add("p_is_success", OracleDbType.Decimal).Direction = ParameterDirection.Output;
                cmd.Parameters["p_is_success"].DbType = DbType.Decimal;

                cmd.Parameters.Add("p_message", OracleDbType.NVarchar2, 4000).Direction = ParameterDirection.Output;
                cmd.Parameters["p_message"].DbType = DbType.String;

                cmd.ExecuteNonQuery();
                message = Convert.ToString(cmd.Parameters["p_message"].Value);
                var success = Convert.ToDecimal(cmd.Parameters["p_is_success"].Value) == 1;
                return success;
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Повторно выполнить заявку
        /// </summary>
        /// <exception cref="Exception"></exception>
        public bool RepeatClaim(int claimId, out string message)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "cdb.cdb_ui.repeat_claim";
                cmd.Parameters.Add("p_claim_id", claimId);

                // без повторного указания типа ошибка при вычитке (Unable to cast object of type 'Oracle.DataAccess.Types.OracleDecimal' to type 'System.IConvertible')
                cmd.Parameters.Add("p_is_success", OracleDbType.Decimal).Direction = ParameterDirection.Output;
                cmd.Parameters["p_is_success"].DbType = DbType.Decimal;

                cmd.Parameters.Add("p_message", OracleDbType.NVarchar2, 4000).Direction = ParameterDirection.Output;
                cmd.Parameters["p_message"].DbType = DbType.String;

                cmd.ExecuteNonQuery();
                message = Convert.ToString(cmd.Parameters["p_message"].Value);
                var success = Convert.ToDecimal(cmd.Parameters["p_is_success"].Value) == 1;
                return success;
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Получить детали заявки типа Новая сделка
        /// </summary>
        public IQueryable<V_CDB_NEW_DEAL_CLAIM> GetClaimDetailsNewDeal()
        {
            return _entities.V_CDB_NEW_DEAL_CLAIM;
        }

        /// <summary>
        /// Получить детали заявки типа Изменение даты погашения
        /// </summary>
        public IQueryable<V_CDB_SET_EXPIRY_DATE_CLAIM> GetClaimDetailsChangeExpireDate()
        {
            return _entities.V_CDB_SET_EXPIRY_DATE_CLAIM;
        }

        /// <summary>
        /// Получить детали заявки типа Изменение процентной ставки
        /// </summary>
        public IQueryable<V_CDB_SET_INT_RATE_CLAIM> GetClaimDetailsChangeRate()
        {
            return _entities.V_CDB_SET_INT_RATE_CLAIM;
        }

        /// <summary>
        /// Получить детали заявки типа Изменение суммы
        /// </summary>
        public IQueryable<V_CDB_CHANGE_AMOUNT_CLAIM> GetClaimDetailsChangeSum()
        {
            return _entities.V_CDB_CHANGE_AMOUNT_CLAIM;
        }

        /// <summary>
        /// Получить детали заявки типа Закрытие сделки
        /// </summary>
        public IQueryable<V_CDB_CLOSE_DEAL_CLAIM> GetClaimDetailsCloseDeal()
        {
            return _entities.V_CDB_CLOSE_DEAL_CLAIM;
        }

        /// <summary>
        /// Отменить обработку транзакции
        /// </summary>
        /// <exception cref="Exception"></exception>
        public bool CancelTransaction(int transactionId, string comment, out string message)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "cdb.cdb_ui.cancel_transaction";
                cmd.Parameters.Add("p_transaction_id", transactionId);
                cmd.Parameters.Add("p_comment", comment);

                // без повторного указания типа ошибка при вычитке (Unable to cast object of type 'Oracle.DataAccess.Types.OracleDecimal' to type 'System.IConvertible')
                cmd.Parameters.Add("p_is_success", OracleDbType.Decimal).Direction = ParameterDirection.Output;
                cmd.Parameters["p_is_success"].DbType = DbType.Decimal;

                cmd.Parameters.Add("p_message", OracleDbType.NVarchar2, 4000).Direction = ParameterDirection.Output;
                cmd.Parameters["p_message"].DbType = DbType.String;

                cmd.ExecuteNonQuery();
                message = Convert.ToString(cmd.Parameters["p_message"].Value);
                var success = Convert.ToDecimal(cmd.Parameters["p_is_success"].Value) == 1;
                return success;
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Повторно отправить транзакцию в АБС
        /// </summary>
        /// <exception cref="Exception"></exception>
        public bool RepeatTransactionSending(int transactionId, out string message)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "cdb.cdb_ui.repeat_transaction";
                cmd.Parameters.Add("p_transaction_id", transactionId);

                // без повторного указания типа ошибка при вычитке (Unable to cast object of type 'Oracle.DataAccess.Types.OracleDecimal' to type 'System.IConvertible')
                cmd.Parameters.Add("p_is_success", OracleDbType.Decimal).Direction = ParameterDirection.Output;
                cmd.Parameters["p_is_success"].DbType = DbType.Decimal;

                cmd.Parameters.Add("p_message", OracleDbType.NVarchar2, 4000).Direction = ParameterDirection.Output;
                cmd.Parameters["p_message"].DbType = DbType.String;

                cmd.ExecuteNonQuery();
                message = Convert.ToString(cmd.Parameters["p_message"].Value);
                var success = Convert.ToDecimal(cmd.Parameters["p_is_success"].Value) == 1;
                return success;
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Получить историю обработки заявки
        /// </summary>
        public IQueryable<V_CDB_CLAIM_TRACK> GetClaimHistory()
        {
            return _entities.V_CDB_CLAIM_TRACK;
        }

        /// <summary>
        /// Получить историю обработки транзакции
        /// </summary>
        public IQueryable<V_CDB_TRANSACTION_TRACK> GetTransactionHistory()
        {
            return _entities.V_CDB_TRANSACTION_TRACK;
        }

        /// <summary>
        /// Получить список транзакций
        /// </summary>
        /// <returns></returns>
        public IQueryable<V_CDB_BARS_TRANSACTION> GetTransactions()
        {
            return _entities.V_CDB_BARS_TRANSACTION;
        }

        public IQueryable<ViddList> GetVidd()
        {
            List<ViddList> vidd = new List<ViddList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select * from v_crsour_product t";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    ViddList r = new ViddList();
                    r.VIDD = reader.GetInt16(0);
                    r.NAME = reader.GetString(1);
                    vidd.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return vidd.AsQueryable();
        }

        public IQueryable<CurrencyList> GetCurrency()
        {
            List<CurrencyList> curr = new List<CurrencyList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select kv, lcv||' '||name as lcv from tabval order by skv";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    CurrencyList r = new CurrencyList();
                    r.KV = reader.GetInt16(0);
                    r.LCV = reader.GetString(1);
                    curr.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return curr.AsQueryable();
        }

        public IQueryable<BaseyList> GetBasey()
        {
            List<BaseyList> basey = new List<BaseyList>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select basey, name from basey order by basey";
                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    BaseyList r = new BaseyList();
                    r.BASEY = reader.GetInt16(0);
                    r.NAME = reader.GetString(1);
                    basey.Add(r);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return basey.AsQueryable();
        }

        public DealNls GetDealNls(decimal productId, decimal currencyId)
        {
            DealNls nls = new DealNls();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "cdb_mediator.generate_account_numbers";
                cmd.Parameters.Add("p_product_id", OracleDbType.Decimal, productId, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_currency_id", OracleDbType.Decimal, currencyId, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_main_account", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output);
                cmd.Parameters.Add("p_interest_account", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output);
                cmd.ExecuteNonQuery();

                nls.mainAccount = cmd.Parameters["p_main_account"].Value.ToString();
                nls.interestAccount = cmd.Parameters["p_interest_account"].Value.ToString();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return nls;
        }

        public decimal GetRateSum(RateParams param)
        {
            decimal res = -1;
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "cdb_mediator.get_expected_interest_amount";
                cmd.Parameters.Add("p_res", OracleDbType.Decimal, System.Data.ParameterDirection.ReturnValue);
                cmd.Parameters.Add("p_product_id", OracleDbType.Decimal, param.productId, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_open_date", OracleDbType.Date, param.openDate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_expiry_date", OracleDbType.Date, param.expiryDate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_deal_amount", OracleDbType.Decimal, param.dealAmount, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_currency_id", OracleDbType.Decimal, param.currencyId, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_interest_rate", OracleDbType.Decimal, param.interestRate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_interest_base", OracleDbType.Decimal, param.interestBase, System.Data.ParameterDirection.Input);
                
                cmd.ExecuteNonQuery();

                res = ((OracleDecimal)cmd.Parameters["p_res"].Value).Value;
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return res;
        }

        public MfoName GetMfoName(string mfo)
        {
            MfoName mfoname = new MfoName();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "cdb_mediator.get_mfo_customer_name";
                cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2, mfo, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_customer_id", OracleDbType.Decimal, System.Data.ParameterDirection.Output);
                cmd.Parameters.Add("p_customer_name", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output);
                cmd.ExecuteNonQuery();

                mfoname.customerId = Convert.ToDecimal(cmd.Parameters["p_customer_id"].Value.ToString());
                mfoname.customerName = cmd.Parameters["p_customer_name"].Value.ToString();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return mfoname;
        }

        public string GetMfo(decimal rnk)
        {
            string mfo = String.Empty;
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "cdb_mediator.get_customer_mfo";
                cmd.Parameters.Add("p_res", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.ReturnValue);
                cmd.Parameters.Add("p_customer_id", OracleDbType.Decimal, rnk, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();

                mfo = cmd.Parameters["p_res"].Value.ToString();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return mfo;
        }

        public DealParams GetDeal(decimal nd)
        {
            DealParams deal = new DealParams();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select cr.contract_number,
                                           cr.product_id,
                                           cr.partner_id,
                                           cr.open_date,
                                           cr.expiry_date,
                                           cr.deal_amount,
                                           cr.currency_id,
                                           cr.interest_rate,
                                           cr.interest_base,
                                           cr.main_account,
                                           cr.interest_account,
                                           cr.partner_main_account,
                                           cr.partner_interest_account,
                                           cr.owner_name,
                                           cr.partner_name
                                      from v_crsour_deal cr 
                                     where nd = :nd";
                cmd.Parameters.Add("nd", OracleDbType.Decimal, nd, System.Data.ParameterDirection.Input);
                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    deal.contractNumber = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? String.Empty : reader.GetString(0);
                    deal.productId = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? (decimal?)null : reader.GetDecimal(1);
                    deal.partnerId = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? (decimal?)null : reader.GetDecimal(2);
                    deal.contractDate = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? (DateTime?)null : reader.GetDateTime(3);
                    deal.expiryDate = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? (DateTime?)null : reader.GetDateTime(4);
                    deal.amount = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? (decimal?)null : reader.GetDecimal(5);
                    deal.currencyCode = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? (decimal?)null : reader.GetDecimal(6);
                    deal.interestRate = String.IsNullOrEmpty(reader.GetValue(7).ToString()) ? (decimal?)null : reader.GetDecimal(7);
                    deal.interestBase = String.IsNullOrEmpty(reader.GetValue(8).ToString()) ? (decimal?)null : reader.GetDecimal(8);
                    deal.mainAccount = String.IsNullOrEmpty(reader.GetValue(9).ToString()) ? String.Empty : reader.GetString(9);
                    deal.interestAccount = String.IsNullOrEmpty(reader.GetValue(10).ToString()) ? String.Empty : reader.GetString(10);
                    deal.partyMainAccount = String.IsNullOrEmpty(reader.GetValue(11).ToString()) ? String.Empty : reader.GetString(11);
                    deal.partyInterestAccount = String.IsNullOrEmpty(reader.GetValue(12).ToString()) ? String.Empty : reader.GetString(12);
                    deal.ownerName = String.IsNullOrEmpty(reader.GetValue(13).ToString()) ? String.Empty : reader.GetString(13);
                    deal.partnerName = String.IsNullOrEmpty(reader.GetValue(14).ToString()) ? String.Empty : reader.GetString(14);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return deal;
        }

        public string SaveDeal(SaveDeal param)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "cdb_mediator.open_credit_contract";
                cmd.Parameters.Add("p_contract_number", OracleDbType.Varchar2, param.contractNumber, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_product_id", OracleDbType.Decimal, param.productId, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_partner_id", OracleDbType.Decimal, param.partnerId, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_contract_date", OracleDbType.Date, param.contractDate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_expiry_date", OracleDbType.Date, param.expiryDate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_amount", OracleDbType.Decimal, param.amount, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_currency_code", OracleDbType.Decimal, param.currencyCode, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_interest_rate", OracleDbType.Decimal, param.interestRate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_interest_base", OracleDbType.Decimal, param.interestBase, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_main_account", OracleDbType.Varchar2, param.mainAccount, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_interest_account", OracleDbType.Varchar2, param.interestAccount, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_party_main_account", OracleDbType.Varchar2, param.partyMainAccount, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_party_interest_account", OracleDbType.Varchar2, param.partyInterestAccount, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return "Ok";
        }

        public string UpdateDeal(decimal dealId, DateTime expiryDate, decimal dealAmount, decimal interestRate, string partnerMainAccount, string partnerInterestAccount)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "cdb_mediator.edit_deal";
                cmd.Parameters.Add("p_deal_id", OracleDbType.Decimal, dealId, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_expiry_date", OracleDbType.Date, expiryDate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_deal_amount", OracleDbType.Decimal, dealAmount, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_interest_rate", OracleDbType.Decimal, interestRate, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_partner_main_account", OracleDbType.Varchar2, partnerMainAccount, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_partner_interest_account", OracleDbType.Varchar2, partnerInterestAccount, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return "Ok";
        }
    }
}