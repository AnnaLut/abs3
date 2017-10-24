using System.Linq;
using System.Collections.Generic;
using Areas.AccessToAccounts.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract
{
    public interface IAccRoleGroupsRepository
    {
        List<AccGroups> GetAccRoleGroups();
        List<Roles> GetRoles(decimal? grpId);
        List<Users> GetUsers(decimal? grpId);
        List<GrpAccounts> GetGrpAccounts(decimal? grpId, string filter);
        List<AccGroups> GetAccounts(decimal? grpId);
        string GetFilterValue(decimal? grpId);
    }
}
