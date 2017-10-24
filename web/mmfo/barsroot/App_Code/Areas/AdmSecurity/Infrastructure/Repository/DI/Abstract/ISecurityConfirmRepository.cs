using System.Linq;
using Areas.AdmSecurity.Models;

namespace BarsWeb.Areas.AdmSecurity.Infrastructure.Repository.DI.Abstract
{
    /// <summary>
    /// ISecurityConfirmRepository
    /// </summary>
    public interface ISecurityConfirmRepository
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
    }
}
