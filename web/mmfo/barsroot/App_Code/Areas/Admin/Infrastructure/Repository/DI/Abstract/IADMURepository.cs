using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Models.ADMU;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IADMURepository
    {
        /// <summary>
        /// Список доступних користувачів
        /// </summary>
        IQueryable<V_STAFF_USER_ADM> GetADMUList(string parameters);

        /// <summary>
        /// Список відділень
        /// </summary>
        /// <returns></returns>
        IQueryable<V_USERADM_BRANCHES> GetBranchList();

        /// <summary>
        /// Список доступних відділень
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        IQueryable<V_STAFF_USER_BRANCH_LOOKUP> BranchLookups();

        /// <summary>
        /// Список доступних ролей при створенні користувача
        /// </summary>
        /// <returns></returns>
        IEnumerable<V_STAFF_USER_ROLE_LOOKUP> RoleLookups();

        /// <summary>
        /// Список ролей користувача
        /// </summary>
        /// <returns></returns>
        IQueryable<V_STAFF_USER_ROLE> UserRoles();

        /// <summary>
        /// Список доступних ролей Oracle
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns> 
        IQueryable<V_STAFF_USER_ORA_ROLE_LOOKUP> OracleRoleLookups();

        /// <summary>
        /// Функція створення нового користувача 
        /// </summary>
        /// <param name="user">користувач</param>
        /// <returns></returns> 
        decimal CreateUser(CreateUserModel user);

        /// <summary>
        /// Функція отримання даних користувача
        /// </summary>
        /// <param name="loginName"></param>
        /// <returns></returns>
        UserData GetUserData(string loginName);

        /// <summary>
        /// Функція зміни паролю користувача ABS
        /// </summary>
        /// <param name="login"></param>
        /// <param name="password"></param>
        void ChangeAbsUserPassword(string login, string password);

        /// <summary>
        /// Функція зміни паролю користувача ORA
        /// </summary>
        /// <param name="login"></param>
        /// <param name="password"></param>
        void ChangeOraUserPassword(string login, string password);

        /// <summary>
        /// Функція блокування користувача
        /// </summary>
        /// <param name="login"></param>
        /// <param name="comment"></param>
        void LockUser(string login, string comment);

        /// <summary>
        /// Функція розблокування користувача
        /// </summary>
        /// <param name="login"></param>
        void UnlockUser(string login);

        /// <summary>
        /// Функція делегування прав
        /// </summary>
        /// <param name="login"></param>
        /// <param name="delegatedUser"></param>
        /// <param name="validFrom"></param>
        /// <param name="validTo"></param>
        /// <param name="comment"></param>
        void DelegateUserRights(string login, string delegatedUser, string validFrom, string validTo, string comment);

        /// <summary>
        /// Функція відміни делегування прав
        /// </summary>
        /// <param name="login"></param>
        void CencelDelegateUserRights(string login);

        /// <summary>
        /// Редагування користувача ABS
        /// </summary>
        /// <param name="user"></param>
        void EditUser(EditUserModel user);

        /// <summary>
        /// закриття користувача
        /// </summary>
        /// <param name="login"></param>
        void CloseUser(string login);

        IEnumerable<UserBranches> GerBranchesDdlData();
        KendoDataSource<V_STAFF_USER_ADM> ADMUList(Kendo.Mvc.UI.DataSourceRequest request, string parameters, MainFilters mainFilters);
    }
}
