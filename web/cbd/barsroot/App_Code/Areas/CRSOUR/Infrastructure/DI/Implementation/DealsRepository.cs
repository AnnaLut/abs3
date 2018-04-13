using System;
using System.Data;
using System.Linq;
using BarsWeb.Areas.CRSOUR.Infrastructure.DI.Abstract;
using BarsWeb.Areas.CRSOUR.Infrastructure.Repository.DI.Abstract;
using Areas.CRSOUR.Models;
using Bars.Classes;
using Oracle.DataAccess.Client;

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
    }
}