using System.Linq;
using System.Collections.Generic;
using Areas.AccessToAccounts.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract
{
    public interface IAccessToAccountsUsersRepository
    {
        IQueryable<Groups> GetGroups(DataSourceRequest request);
        IQueryable<Groups> GetUserGroups(decimal ID, DataSourceRequest request);
        IQueryable<Groups> GetAccountsGroups(decimal ID, DataSourceRequest request);
        void ChangeUserGroup(decimal GroupID, decimal ID);
        void ChangeAccountsGroup(decimal GroupID, decimal ID); 
    }
}
