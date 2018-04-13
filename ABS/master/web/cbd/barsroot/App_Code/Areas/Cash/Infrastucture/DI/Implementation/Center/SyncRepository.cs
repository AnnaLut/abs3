using System;
using System.Data;
using System.Linq;
using BarsWeb.Areas.Cash.Infrastructure;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;
using Bars.Classes;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastucture.DI.Implementation.Center
{
    /// <summary>
    /// Репозиторий настроек синхронизации
    /// </summary>
    public class SyncRepository : ISyncRepository
    {
        readonly CashEntities _entities;

        /// <summary>
        /// Если задано, то репозиторий работает с данным Connection, не создавая новых и не уничтожая данный
        /// </summary>
        public OracleConnection Connection { get; set; }

        public SyncRepository(ICashModel model)
        {
            _entities = model.CashEntities;
        }

        /// <summary>
        /// Получить список коннектов к региональным базам
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<CLIM_SYNC_PARAMS> GetConnectionOptions()
        {
            return _entities.CLIM_SYNC_PARAMS;
        }

        /// <summary>
        /// Создать настройку
        /// </summary>
        /// <exception cref="Exception"></exception>
        public ConnectionOption CreateConnectionOption(ConnectionOption connectionOption)
        {
            var dbModel = ModelConverter.ToDbModel(connectionOption);
            // хешируем пароль
            if (!string.IsNullOrEmpty(dbModel.SYNC_PASSWORD))
            {
                dbModel.SYNC_PASSWORD = SHA1Util.SHA1HashStringForUTF8String(dbModel.SYNC_PASSWORD);
            }
            dbModel.LAST_SYNC_STATUS = SyncStatus.NoSync;
            _entities.CLIM_SYNC_PARAMS.AddObject(dbModel);
            _entities.SaveChanges();
            return ModelConverter.ToViewModel(dbModel);
        }

        /// <summary>
        /// Обновить настройку
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void UpdateConnectionOption(ConnectionOption connectionOption)
        {
            var dbModel = ModelConverter.ToDbModel(connectionOption);
            var rowToUpdate = _entities.CLIM_SYNC_PARAMS.FirstOrDefault(x => x.KF == dbModel.KF);
            if (rowToUpdate != null)
            {
                // обновляем только редактируемые поля
                rowToUpdate.NAME = dbModel.NAME;
                rowToUpdate.SYNC_ENABLED = dbModel.SYNC_ENABLED;
                rowToUpdate.SYNC_LOGIN = dbModel.SYNC_LOGIN;
                // хешируем пароль
                if (!string.IsNullOrEmpty(dbModel.SYNC_PASSWORD))
                {
                    rowToUpdate.SYNC_PASSWORD = SHA1Util.SHA1HashStringForUTF8String(dbModel.SYNC_PASSWORD);
                }
                rowToUpdate.SYNC_SERVICE_URL = dbModel.SYNC_SERVICE_URL;
                _entities.SaveChanges();
            }
        }

        /// <summary>
        /// Установить статус настройки "В процессе"
        /// </summary>
        /// <param name="mfo">Код МФО</param>
        /// <exception cref="Exception"></exception>
        public bool MarkConnectionOptionAsInProcess(string mfo)
        {
            OracleConnection connection = Connection ?? OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.BindByName = true;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "clim_sync_acc.markconn_inproc";
                cmd.Parameters.Add("p_mfo", mfo);
                const string returnParName = "countRowsUpdated";
                cmd.Parameters.Add(returnParName, OracleDbType.Decimal).Direction = ParameterDirection.ReturnValue;
                // без повторного указания типа ошибка при вычитке (Unable to cast object of type 'Oracle.DataAccess.Types.OracleDecimal' to type 'System.IConvertible')
                cmd.Parameters[returnParName].DbType = DbType.Decimal;
                cmd.ExecuteNonQuery();
                var countRowsUpdated = Convert.ToDecimal(cmd.Parameters[returnParName].Value);
                return countRowsUpdated == 1;
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
        /// Удалить настройку
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void DeleteConnectionOption(string mfoCode)
        {
            var rowToDelete = _entities.CLIM_SYNC_PARAMS.FirstOrDefault(x => x.KF == mfoCode);
            if (rowToDelete != null)
            {
                _entities.CLIM_SYNC_PARAMS.DeleteObject(rowToDelete);
                _entities.SaveChanges();
            }
        }

        /// <summary>
        /// Добавить запись в протокол (если передан Id, то обновляем существующую строку в протоколе)
        /// </summary>
        /// <param name="syncResult">Результат обработки одного региона</param>
        /// <param name="updateConnectionOptionStatus">Обновлять статус в таблице настроек</param>
        /// <returns>Id строки</returns>
        public decimal WriteLog(SyncResult syncResult, bool updateConnectionOptionStatus)
        {
            // Процедура генерирует ID, добавляет строку в протокол, возвращает сгенерированный ID
            //
            OracleConnection connection = Connection ?? OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.BindByName = true;
                cmd.CommandText = "clim_sync_acc.write_protocol";
                cmd.Parameters.Add("p_mfo", syncResult.Mfo);
                cmd.Parameters.Add("p_url", syncResult.URL);
                cmd.Parameters.Add("p_transfer_type", syncResult.TransferType);
                cmd.Parameters.Add("p_transfer_bdate", syncResult.BankDate);
                cmd.Parameters.Add("p_transfer_date_start", syncResult.DateStart);
                cmd.Parameters.Add("p_transfer_date_end", syncResult.DateEnd);
                cmd.Parameters.Add("p_transfer_rows", syncResult.RowsTotal);
                cmd.Parameters.Add("p_processed_rows", syncResult.RowsSucceed);
                var length = syncResult.Message.Length == 0 ? 0 : syncResult.Message.Length > 4000 ? 3999 :  syncResult.Message.Length - 1 ;
                var mess = syncResult.Message.Substring(0, length);
                cmd.Parameters.Add("p_comm", mess);
                cmd.Parameters.Add("p_transfer_result", syncResult.Status);
                cmd.Parameters.Add("p_parent_id", syncResult.ParentId);
                cmd.Parameters.Add("p_row_level", syncResult.RowLevel);
                cmd.Parameters.Add("p_updsyncparam", updateConnectionOptionStatus ? 1 : 0);
                cmd.Parameters.Add("p_id", OracleDbType.Decimal).Direction = ParameterDirection.InputOutput;
                // без повторного указания типа ошибка при вычитке (Unable to cast object of type 'Oracle.DataAccess.Types.OracleDecimal' to type 'System.IConvertible')
                cmd.Parameters["p_id"].DbType = DbType.Decimal;
                if (syncResult.ID != 0)
                {
                    cmd.Parameters["p_id"].Value = syncResult.ID;
                }
                cmd.ExecuteNonQuery();
                var id = Convert.ToDecimal(cmd.Parameters["p_id"].Value);
                return id;
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
        /// Получить список записей в журнал
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<CLIM_PROTOCOL> GetLog()
        {
            return _entities.CLIM_PROTOCOL;
        }

        /// <summary>
        /// Получить список параметров
        /// </summary>
        /// <exception cref="Exception"></exception>
        public IQueryable<CLIM_PARAMS> GetParams()
        {
            return _entities.CLIM_PARAMS;
        }

        /// <summary>
        /// Создать параметр
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void CreateParam(Param param)
        {
            var dbModel = ModelConverter.ToDbModel(param);
            _entities.CLIM_PARAMS.AddObject(dbModel);
            _entities.SaveChanges();
        }

        /// <summary>
        /// Обновить параметр
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void UpdateParam(Param param)
        {
            var dbModel = ModelConverter.ToDbModel(param);
            var rowToUpdate = _entities.CLIM_PARAMS.FirstOrDefault(x => x.PARAM == dbModel.PARAM);
            if (rowToUpdate != null)
            {
                rowToUpdate.VAL = dbModel.VAL;
                rowToUpdate.COMM = dbModel.COMM;
                _entities.SaveChanges();
            }
        }

        /// <summary>
        /// Удалить параметр
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void DeleteParam(string name)
        {
            var rowToDelete = _entities.CLIM_PARAMS.FirstOrDefault(x => x.PARAM == name);
            _entities.CLIM_PARAMS.DeleteObject(rowToDelete);
            _entities.SaveChanges();
        }

    }
}