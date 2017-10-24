using BarsWeb.Areas.Admin.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// IConfirmRepository - підтвердження виконання дій АРМу Адміністрування
/// </summary>

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IConfirmRepository
    {
        IEnumerable<V_USER_RESOURCES_CONFIRM> GetUserConfirmData(DataSourceRequest request);
        decimal CountUserConfirmData(DataSourceRequest request);
        IEnumerable<V_APP_RESOURCES_CONFIRM> GetAppConfirmData(DataSourceRequest request);
        decimal CountAppConfirmData(DataSourceRequest request);
        void ConfirmUserApproving(string userId, string resId, string obj);
        void ConfirmUserRevoking(string userId, string resId, string obj); 
        void ConfirmAppApproving(string id, string codeapp, string obj);
        void ConfirmAppRevoking(string id, string codeapp, string obj);
    }
}
