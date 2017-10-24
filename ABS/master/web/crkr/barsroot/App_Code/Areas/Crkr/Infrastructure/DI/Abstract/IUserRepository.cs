using System.Collections.Generic;
using BarsWeb.Areas.Crkr.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Crkr.Infrastructure.DI.Abstract
{
    public interface IUserRepository
    {
        List<ActualUsersProfiles> GetProfiles(ActualUser model, [DataSourceRequest] DataSourceRequest request);
        ListUsersResponse ImportUsers(ListUsersParams param);
    }
}
