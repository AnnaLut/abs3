using BarsWeb.Areas.Admin.Models.Confirm;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System.Linq;
using Areas.Admin.Models;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// IConfirmRepository - підтвердження виконання дій АРМу Адміністрування
    /// </summary>
    public interface IConfirmRepository
    {
        /// <summary>
        /// Підтвердження. Довідник табів ресурсів
        /// </summary>
        /// <returns></returns>
        IQueryable<V_APPROVABLE_RESOURCE_GROUP> ResourceConfirmTabsData();

        /// <summary>
        /// Підтердження ресурсів
        /// </summary>
        /// <returns></returns>
        IQueryable<V_APPROVABLE_RESOURCE> ResourceConfirmData();

        /// <summary>
        /// Підтвердження виконання операцій
        /// </summary>
        /// <param name="id"></param>
        /// <param name="approveList"></param>
        /// <param name="comment"></param>
        void ApproveResourceAccess(string id, string approveList, string comment);

        /// <summary>
        /// Відхилення виконання операцій
        /// </summary>
        /// <param name="id"></param>
        /// <param name="rejectList"></param>
        /// <param name="comment"></param>
        void RejectResourceAccess(string id, string rejectList, string comment);

        //IEnumerable<V_USER_RESOURCES_CONFIRM> GetUserConfirmData(DataSourceRequest request);
        //decimal CountUserConfirmData(DataSourceRequest request);
        //IEnumerable<V_APP_RESOURCES_CONFIRM> GetAppConfirmData(DataSourceRequest request);
        //decimal CountAppConfirmData(DataSourceRequest request);
        //void ConfirmUserApproving(string userId, string resId, string obj);
        //void ConfirmUserRevoking(string userId, string resId, string obj); 
        //void ConfirmAppApproving(string id, string codeapp, string obj);
        //void ConfirmAppRevoking(string id, string codeapp, string obj);
    }
}
