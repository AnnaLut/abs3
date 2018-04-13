using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IADMURepository
    {
        IQueryable<STAFF_BASE> GetADMUList();
        IEnumerable<UserADM_AllApps> GetAPPsList(DataSourceRequest request);
        decimal CountAPPsList(DataSourceRequest request);
        IEnumerable<V_USERADM_ALL_TTS> GetTTSList(DataSourceRequest request);
        decimal CountTTSList(DataSourceRequest request);
        IEnumerable<V_USERADM_ALL_CHKGRPS> GetCHKGRPSList(DataSourceRequest request);
        decimal CountCHKGRPSList(DataSourceRequest request);
        IEnumerable<V_USERADM_ALL_NBUREPS> GetNBUREPSList(DataSourceRequest request);
        decimal CountNBUREPSList(DataSourceRequest request);
        void SetCurrentUserContext(decimal userId);
        IEnumerable<V_USERADM_USER_APPS> GetCurrentUserApps(DataSourceRequest request);
        IEnumerable<V_USERADM_USER_TTS> GetCurrentUserTTS(DataSourceRequest request);
        IEnumerable<V_USERADM_USER_CHKGRPS> GetCurrentUserChkGrps(DataSourceRequest request);
        IEnumerable<V_USERADM_USER_NBUREPS> GetCurrentUserNBURps(DataSourceRequest request);
        void AddResourcetoUser(decimal userID, string resVal, int tabID, string nbuA017);
        void RemoveResourceFromUser(decimal userID, string resVal, int tabID, string nbuA017);
    }
}
