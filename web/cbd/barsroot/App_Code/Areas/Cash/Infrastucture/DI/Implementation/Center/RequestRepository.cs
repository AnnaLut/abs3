using System;
using System.Data;
using System.Linq;
using System.Web.Http;
using Bars.Classes;
using BarsWeb.Areas.Cash.Infrastructure;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.Cash.Infrastucture.DI.Implementation.Center
{
    /// <summary>
    /// Заявки на изменение лимитов
    /// </summary>
    public class RequestRepository : IRequestRepository
    {
        readonly CashEntities _entities;

        public RequestRepository(ICashModel model)
        {
            _entities = model.CashEntities;
        }

        /// <summary>
        /// Получить список заявок на изменение лимитов
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<V_CLIM_REQUEST> GetRequests()
        {
            return _entities.V_CLIM_REQUEST;
        }

        public Request GetRequestById(int id)
        {
            var insertedItem = _entities.V_CLIM_REQUEST.FirstOrDefault(x => x.REQ_ID == id);
            if (insertedItem == null)
            {
                return null;
            }
            return ModelConverter.ToViewModel(insertedItem);
        }

        public string GetAtmCode(int accId)
        {
            const string sql = @"select 
                                    cod_atm
                                from 
                                    v_clim_atm_limit
                                where 
                                    acc_id = :p_acc_id";
            var result = _entities.ExecuteStoreQuery<string>(
                    sql, 
                    new OracleParameter("p_acc_id",OracleDbType.Decimal){Value = accId}
                ).FirstOrDefault();
            return result;
        }

        /// <summary>
        /// Создать заявку на изменение лимита Atm
        /// </summary>
        /// <exception cref="Exception"></exception>
        public Request CreateRequest(decimal accId, decimal? currentLimit, decimal? maxLimit, decimal? maxLoadLimit)
        {
            OracleConnection connection = OraConnector.Handler.IOraConnection.GetUserConnection();
            decimal? id;
            OracleCommand cmd = connection.CreateCommand();
            try
            {

                cmd.BindByName = true;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "clim_lim.create_request";
                cmd.Parameters.Add("id", OracleDbType.Decimal, ParameterDirection.ReturnValue);
                cmd.Parameters.Add("p_acc_id", accId);
                cmd.Parameters.Add("p_lim_curr", currentLimit);
                cmd.Parameters.Add("p_lim_max", maxLimit);
                cmd.Parameters.Add("p_lim_maxload", maxLoadLimit);
                cmd.ExecuteNonQuery();

            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                    connection.Close();
            }
            var oraDec = (OracleDecimal)cmd.Parameters["id"].Value;
            id = oraDec.IsNull ? (decimal?)null : Convert.ToDecimal(Convert.ToString(oraDec.Value));

            connection.Dispose();
            cmd.Dispose();

            var insertedItem = _entities.V_CLIM_REQUEST.FirstOrDefault(x => x.REQ_ID == id);
            if (insertedItem == null)
            {
                return null;
            }
            return ModelConverter.ToViewModel(insertedItem);
        }
        /// <summary>
        /// Создать заявку на изменение лимита
        /// </summary>
        /// <exception cref="Exception"></exception>
        public Request CreateRequest(Request request)
        {
            OracleConnection connection = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = connection.CreateCommand();
            decimal? id;
            try
            {
                var dbModel = ModelConverter.ToDbModel(request);
                // Выполняем вставку через функцию, которая заполняет дополнительные поля и возвращает id строки
                //

                cmd.BindByName = true;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "clim_lim.create_request";
                cmd.Parameters.Add("id", OracleDbType.Decimal, ParameterDirection.ReturnValue);
                cmd.Parameters.Add("p_acc_id", dbModel.ACC_ID);
                cmd.Parameters.Add("p_lim_curr", dbModel.LIM_CURRENT);
                cmd.Parameters.Add("p_lim_max", dbModel.LIM_MAX);
                cmd.Parameters.Add("p_lim_maxload", dbModel.LIM_MAXLOAD);
                cmd.ExecuteNonQuery();
                var oraDec = (OracleDecimal)cmd.Parameters["id"].Value;
                id = oraDec.IsNull ? (decimal?)null : Convert.ToDecimal(Convert.ToString(oraDec.Value));

            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                    connection.Close();
                connection.Dispose();
                cmd.Dispose();
            }
            var insertedItem = _entities.V_CLIM_REQUEST.FirstOrDefault(x => x.REQ_ID == id);
            if (insertedItem == null)
            {
                return null;
            }
            return ModelConverter.ToViewModel(insertedItem);
        }

        public Request UpdateRequest(decimal requestId, decimal? currentLimit, decimal? maxLimit, decimal? maxLoadLimit)
        {
            var rowToUpdate = _entities.CLIM_REQUEST.FirstOrDefault(x => x.REQ_ID == requestId && x.REQ_STATUS == "NEW");
            if (rowToUpdate == null)
            {
                return null;
            }
            OracleConnection connection = OraConnector.Handler.IOraConnection.GetUserConnection();
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.BindByName = true;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "clim_lim.edit_request";
                cmd.Parameters.Add("p_req_id", requestId);
                cmd.Parameters.Add("p_limcurr", currentLimit);
                cmd.Parameters.Add("p_limmax", maxLimit);
                cmd.Parameters.Add("p_lim_maxload", maxLoadLimit);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                if (connection.State == ConnectionState.Open)
                    connection.Close();
                connection.Dispose();
                cmd.Dispose();
            }

            var insertedItem = _entities.V_CLIM_REQUEST.FirstOrDefault(x => x.REQ_ID == requestId);
            if (insertedItem == null)
            {
                return null;
            }
            return ModelConverter.ToViewModel(insertedItem);
        }
        /// <summary>
        /// Обновить заявку на изменение лимита
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void UpdateRequest(Request request)
        {
            var dbModel = ModelConverter.ToDbModel(request);

            var rowToUpdate = _entities.CLIM_REQUEST.FirstOrDefault(x => x.REQ_ID == dbModel.REQ_ID && x.REQ_STATUS == "NEW");
            if (rowToUpdate != null)
            {
                rowToUpdate.LIM_CURRENT = dbModel.LIM_CURRENT;
                rowToUpdate.LIM_MAX = dbModel.LIM_MAX;
                _entities.SaveChanges();
            }
            else
            {
                throw new Exception("Під час редагування рядок був змінений іншим користувачем");
            }
        }

        /// <summary>
        /// Удалить заявку на изменение лимита
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void DeleteRequest(decimal id)
        {
            var rowToDelete = _entities.CLIM_REQUEST.FirstOrDefault(x => x.REQ_ID == id && x.REQ_STATUS == "NEW");
            if (rowToDelete != null)
            {
                _entities.CLIM_REQUEST.DeleteObject(rowToDelete);
                _entities.SaveChanges();
            }
            else
            {
                throw new Exception("Під час редагування рядок був змінений іншим користувачем");
            }
        }

        /// <summary>
        /// Подтвердить заявку на изменение лимита
        /// <param name="requestId">ID заявки</param>
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void ApproveRequest(decimal requestId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.BindByName = true;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "clim_lim.approve_request";
                cmd.Parameters.Add("p_req_id", requestId);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }

        /// <summary>
        /// Отклонить заявку на изменение лимита
        /// <param name="requestId">ID заявки</param>
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void RejectRequest(decimal requestId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.BindByName = true;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "clim_lim.reject_request";
                cmd.Parameters.Add("p_req_id", requestId);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                connection.Close();
            }
        }
    }
}