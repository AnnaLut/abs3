using System.Linq;
using System.Collections.Generic;
using Areas.AccessToAccounts.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract
{
    public interface IAccessToAccountsRepository
    {        
            IQueryable<Groups> GetAccounts(DataSourceRequest request); 
            IQueryable<Groups> GetLeftUsers(decimal ID, DataSourceRequest request); 
            IQueryable<Groups> GetRightUsers(decimal ID, DataSourceRequest request); 
            void ChangeLeftUser(decimal AccountID, decimal ID); 
            void ChangeRightUser(decimal AccountID, decimal ID);

    }
}