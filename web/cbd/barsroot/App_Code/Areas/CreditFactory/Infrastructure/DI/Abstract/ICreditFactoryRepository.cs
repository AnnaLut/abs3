using System.Linq;
using Areas.CreditFactory.Models;
using BarsWeb.Areas.CreditFactory.ViewModels;
//using BarsWeb.Areas.CreditFactory.Models;

namespace BarsWeb.Areas.CreditFactory.Infrastructure.Repository.DI.Abstract
{
    public interface ICreditFactoryRepository
    {
        /// <summary>
        /// Журнал подій синхронізації
        /// </summary>
        /// <returns></returns>
        IQueryable<CF_REQUEST_LOG> GetReqRespLog();
        /// <summary>
        /// Журнал подій синхронізації з фільтрацією по напрямку повідомлення відносно АБС
        /// </summary>
        /// <param name="logDir"></param>
        /// <returns></returns>
        IQueryable<CF_REQUEST_LOG> GetReqRespLogDir(string logDir);
        /// <summary>
        /// Параметри синхронізації
        /// </summary>
        /// <returns></returns>
        IQueryable<CF_REQUEST_SETINGS> GetSetings();
        /// <summary>
        /// Параметри синхронізації в розрізі відділень
        /// </summary>
        /// <returns></returns>
        IQueryable<V_CF_SETINGS> GetSetingsBranch();
        /// <summary>
        /// Новий запис в параметри синхронізації
        /// </summary>
        /// <param name="syncParams"></param>
        /// <returns></returns>
        SyncParams CreateSyncParam(SyncParams syncParams);
        /// <summary>
        /// Редагування записів в параметрах синхронізації
        /// </summary>
        /// <param name="syncParams"></param>
        void UpdateSyncParams(SyncParams syncParams);
        /// <summary>
        /// Видалити запис з параметрів синхронізації
        /// </summary>
        /// <param name="mfo"></param>
        void DestroySyncParam(string mfo);
        /// <summary>
        /// Перевірка зв`язку з РУ
        /// </summary>
        void Ping();
        
    }
}
