using System.Linq;
using BarsWeb.Areas.KFiles.Models;
using System.Collections.Generic;
using Kendo.Mvc.UI;
//using BarsWeb.Areas.CreditFactory.Models;
using Areas.KFiles.Models;

namespace BarsWeb.Areas.KFiles.Infrastructure.Repository.DI.Abstract
{
    public interface IKFilesRepository
    {
        /// <summary>
        /// Визначаємо метод для вибірки коорпорацій у фільтр
        /// </summary>
        /// <param name="mode"></param>
        /// <returns></returns>
        IQueryable<V_OB_CORPORATION> GetCorporationsList(bool mode);

        //IQueryable<V_OB_CORPORATION> GetCorporations(bool mode);

        IQueryable<V_OB_CORPORATION> GetCorporations(bool mode, string parent_id);

        void AddCorporationOrSubCorporation(string CORPORATION_NAME, string CORPORATION_CODE, string EXTERNAL_ID, decimal PARENT_ID);

        void EditCorporation(decimal ID, string CORPORATION_CODE, string CORPORATION_NAME, string EXTERNAL_ID);

        void LockCorporation(decimal ID);

        void UnLockCorporation(decimal ID);

        void CloseCorporation(decimal ID);
        void ChangeHierarchy(decimal ID, decimal PARENT_ID);

        IQueryable<HierarchyCorporations> GetCorporationsForChangeHierarchy(decimal ID);
        IQueryable<V_OB_CORPORATION_SESSION> GetCorporationsFiles(string CorporationID);

        IEnumerable<V_SYNC_SESSION> GetSyncData(DataSourceRequest request);
        decimal GetSyncDataCount(DataSourceRequest request);
        IQueryable<V_OB_CORPORATION_DATA> GetCorporationDataFiles(decimal sessionID);
    }
}
