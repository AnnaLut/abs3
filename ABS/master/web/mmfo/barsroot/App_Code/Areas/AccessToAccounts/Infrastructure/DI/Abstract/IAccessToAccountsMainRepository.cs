using System.Linq;
using System.Collections.Generic;
using Areas.AccessToAccounts.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract
{
    public interface IAccessToAccountsMainRepository
    {
        IQueryable<Accounts> GetAccounts(DataSourceRequest request);
        IQueryable<ServingGroups> GetGroupServingAccount(decimal ID, DataSourceRequest request);
        IQueryable<ServingGroups> GetGroupUsers(decimal ID, DataSourceRequest request);
        IQueryable<TheGroup> GetTheGroups(decimal ID, DataSourceRequest request);
        decimal AccountsDataCount(DataSourceRequest request);
        decimal GroupServingAccountDataCount(decimal ID, DataSourceRequest request); 
        decimal GroupUsersDataCount(decimal ID, DataSourceRequest request);
        decimal TheGroupsDataCount(decimal ID, DataSourceRequest request);
        IQueryable<ServingGroups> GetDropDownAccountGroup(decimal ID);
        IQueryable<ServingGroups> GetDropDownGroupUsers(decimal ID);
        IQueryable<ServingGroups> GetDropDownUsers(decimal ID);
        void AddAccountGroup(decimal AccID, decimal ID);
        void AddGroupUsers(decimal AccGroupID, decimal ID);
        void AddUser(decimal UserGroupID, decimal ID);
        void DeleteGroupAccount(decimal IDAcc, decimal IDAccGroup);
        void DeleteGroupUser(decimal IDAccGroup, decimal IDUserGroup);
        void DeleteUser(decimal IDUserGroup, decimal IDUser);
        void UpdateUser(List<UserUpdate> userUpdate);
    }
}
