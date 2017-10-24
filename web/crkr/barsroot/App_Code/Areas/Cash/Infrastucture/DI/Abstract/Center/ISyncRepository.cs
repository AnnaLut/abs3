using System;
using System.Linq;
using Areas.Cash.Models;
using BarsWeb.Areas.Cash.ViewModels;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cash.Infrastructure.DI.Abstract.Center
{
    public interface ISyncRepository
    {
        /// <summary>
        /// Если задано, то репозиторий работает с данным Connection, не создавая новых и не уничтожая данный
        /// </summary>
        OracleConnection Connection { get; set; }

        /// <summary>
        /// Получить список коннектов к региональным базам
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<CLIM_SYNC_PARAMS> GetConnectionOptions();

        /// <summary>
        /// Создать настройку
        /// </summary>
        /// <exception cref="Exception"></exception>
        ConnectionOption CreateConnectionOption(ConnectionOption connectionOption);

        /// <summary>
        /// Обновить настройку
        /// </summary>
        /// <exception cref="Exception"></exception>
        void UpdateConnectionOption(ConnectionOption connectionOption);

        /// <summary>
        /// Установить статус настройки "В процессе"
        /// </summary>
        /// <param name="mfo">Код МФО</param>
        /// <exception cref="Exception"></exception>
        bool MarkConnectionOptionAsInProcess(string mfo);

        /// <summary>
        /// Удалить настройку
        /// </summary>
        /// <exception cref="Exception"></exception>
        void DeleteConnectionOption(string mfoCode);

        /// <summary>
        /// Добавить запись в протокол (если передан Id, то обновляем существующую строку в протоколе)
        /// </summary>
        /// <param name="syncResult">Результат обработки одного региона</param>
        /// <param name="updateConnectionOptionStatus">Обновлять статус в таблице настроек</param>
        /// <returns>Id строки</returns>
        decimal WriteLog(SyncResult syncResult, bool updateConnectionOptionStatus);

        /// <summary>
        /// Получить список записей в журнал
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<CLIM_PROTOCOL> GetLog();

        /// <summary>
        /// Получить список параметров
        /// </summary>
        /// <exception cref="Exception"></exception>
        IQueryable<CLIM_PARAMS> GetParams();

        /// <summary>
        /// Создать параметр
        /// </summary>
        /// <exception cref="Exception"></exception>
        void CreateParam(Param param);

        /// <summary>
        /// Обновить параметр
        /// </summary>
        /// <exception cref="Exception"></exception>
        void UpdateParam(Param param);

        /// <summary>
        /// Удалить параметр
        /// </summary>
        /// <exception cref="Exception"></exception>
        void DeleteParam(string name);

    }
}