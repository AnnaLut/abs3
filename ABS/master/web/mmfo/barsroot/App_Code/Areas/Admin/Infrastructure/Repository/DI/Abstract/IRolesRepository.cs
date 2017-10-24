using System.Linq;
using Areas.Admin.Models;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IRolesRepository
    {
        /// <summary>
        /// Доступні ролі
        /// </summary>
        /// <returns></returns>
        IQueryable<V_STAFF_ROLE_ADM> GetRoles(string parameters);
        
        /// <summary>
        /// Створення нової ролі
        /// </summary>
        /// <param name="code"></param>
        /// <param name="name"></param>
        /// <returns></returns>
        decimal CreateRole(string code, string name);

        /// <summary>
        /// Редагування існуючої ролі
        /// </summary>
        /// <param name="code"></param>
        /// <param name="name"></param>
        void EditRole(string code, string name);

        /// <summary>
        /// Деактивація ролі
        /// </summary>
        /// <param name="code"></param>
        void LockRole(string code);

        /// <summary>
        /// Видалення ролі
        /// </summary>
        /// <param name="code"></param>
        void DeleteRole(string code); 

        /// <summary>
        /// Активація ролі
        /// </summary>
        /// <param name="code"></param>
        void UnlockRole(string code);

        /// <summary>
        /// Ресурси ролі
        /// </summary>
        /// <returns></returns>
        IQueryable<V_ROLE_RESOURCE> GetRoleResources(string id, string code);

        /// <summary>
        /// Таби ресурсів ролі
        /// </summary>
        /// <returns></returns>
        IQueryable<V_ROLE_RESOURCE_TYPE_LOOKUP> GetResourceTypeLookups();

        /// <summary>
        /// Ресурси ролі
        /// </summary>
        /// <returns></returns>
        IQueryable<V_ROLE_RESOURCE_ACCESS_MODE> GetResourceAccessModes();

        /// <summary>
        /// встановлення і відмінa доступу до ресурсу ролі
        /// </summary>
        /// <param name="roleCode"></param>
        /// <param name="resourceTypeId"></param>
        /// <param name="resourceId"></param>
        /// <param name="accessModeId"></param>
        void SetResourceAccessMode(string roleCode, string resourceTypeId, string resourceId, string accessModeId);
    }
}