using Areas.Admin.Models;
using Kendo.Mvc.UI;
using System.Linq;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IADMRepository
    {
        /// <summary>
        /// список доступних армів
        /// </summary>
        /// <returns></returns>
        IQueryable<V_APPLIST_ADM> GetADMList();

        /// <summary>
        /// створення нового арму
        /// </summary>
        /// <param name="admCode"></param>
        /// <param name="admName"></param>
        /// <param name="appType"></param>
        /// <returns></returns>
        decimal CreateAdmItem(string admCode, string admName, string appType);

        /// <summary>
        /// редагування обраного арму
        /// </summary>
        /// <param name="admCode"></param>
        /// <param name="admName"></param>
        /// <param name="appType"></param>
        void EditAdmItem(string admCode, string admName, string appType);

        /// <summary>
        /// Ресурси АРМу
        /// </summary>
        /// <returns></returns>
        IQueryable<V_ARM_RESOURCE> GetAdmResources(string id, string code);

        /// <summary>
        /// Таби ресурсів АРМу
        /// </summary>
        /// <returns></returns>
        IQueryable<V_ARM_RESOURCE_TYPE_LOOKUP> GetAdmResourceTypeLookups();

        /// <summary>
        /// Ресурси АРМу (доступні)
        /// </summary>
        /// <returns></returns>
        IQueryable<V_ARM_RESOURCE_ACCESS_MODE> GetAdmAccessModes(string id, string code);

        /// <summary>
        /// встановлення і відмінa доступу до ресурсу АРМу
        /// </summary>
        /// <param name="armCode"></param>
        /// <param name="resourceTypeId"></param>
        /// <param name="resourceId"></param>
        /// <param name="accessModeId"></param>
        void SetAdmResourceAccessMode(string armCode, string resourceTypeId, string resourceId, string accessModeId);

        decimal CheckAdmHasResources(string code);
        void RemoveAdm(string code);
    }
}