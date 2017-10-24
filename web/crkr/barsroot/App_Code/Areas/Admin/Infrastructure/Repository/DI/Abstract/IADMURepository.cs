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
        //IQueryable<STAFF_BASE> GetADMUList();
        IEnumerable<V_USERADM_USERS> GetADMUList(DataSourceRequest request);
        decimal CountADMUList(DataSourceRequest request);
        IEnumerable<USERADM_ALL_APPS_WEB> GetAPPsList(decimal userID, DataSourceRequest request);
        decimal CountAPPsList(decimal userID, DataSourceRequest request);
        IEnumerable<USERADM_ALL_TTS_WEB> GetTTSList(decimal userID, DataSourceRequest request);
        decimal CountTTSList(decimal userID, DataSourceRequest request);
        IEnumerable<USERADM_ALL_CHKGRPS> GetCHKGRPSList(decimal userID, DataSourceRequest request);
        decimal CountCHKGRPSList(decimal userID, DataSourceRequest request);
        IEnumerable<USERADM_ALL_NBUREPS> GetNBUREPSList(decimal userID, DataSourceRequest request);
        decimal CountNBUREPSList(decimal userID, DataSourceRequest request);
        void SetCurrentUserContext(decimal userId);
        IEnumerable<V_USERADM_USER_APPS_WEB> GetCurrentUserApps(decimal userID, DataSourceRequest request);
        IEnumerable<V_USERADM_USER_TTS_WEB> GetCurrentUserTTS(decimal userID, DataSourceRequest request);
        IEnumerable<V_USERADM_USER_CHKGRPS_WEB> GetCurrentUserChkGrps(decimal userID, DataSourceRequest request);
        IEnumerable<V_USERADM_USER_NBUREPS_WEB> GetCurrentUserNBURps(decimal userID, DataSourceRequest request);
        void AddResourcetoUser(decimal userID, string resVal, int tabID, string nbuA017);
        void RemoveResourceFromUser(decimal userID, string resVal, int tabID, string nbuA017);
        V_USERADM_USERS GetCurrentUser(decimal userId);
        IEnumerable<STAFF_CLASS> GetClassData(); 
        IEnumerable<string> GetUserRoles(string userLogin);
        string GetExpireDate(decimal userId);
        void AddUser(string usrfio, string usrtabn, decimal usrtype, decimal usraccown,
            string usrbranch, decimal? usrusearc, decimal usrusegtw, string usrwprof,
            string reclogname, string recpasswd, string recappauth, string recprof,
            string recdefrole, string recrsgrp, decimal? usrid, string gtwpasswd,
            string canselectbranch, string chgpwd, decimal? tipid);
        void EditUser(decimal p_usrid, string p_usrfio, string p_usrtabn, decimal p_usrtype,
            decimal? p_usraccown, string p_usrbranch, decimal? p_usrarc, decimal? p_usrusegtw,
            string p_usrwprof, string p_recpasswd, string p_recappauth, string p_recprof,
            string p_recdefrole, string p_recrsgrp, string p_canselectbranch, string p_chgpwd,
            decimal? p_tipid);
        void DropUser(decimal userID);
        IEnumerable<V_USERADM_BRANCHES> GetBranchList(DataSourceRequest request);
        decimal CountBranches(DataSourceRequest request);
        IEnumerable<V_USERADM_RESOURCES> GetUserResources(DataSourceRequest request);
        decimal CountUserResources(DataSourceRequest request);
        void CloneUser(string cloneUserParam);
        IEnumerable<USER> GetTransmitUserList(DataSourceRequest request);
        decimal CountTransmitUserList(DataSourceRequest request);
        void GetTransmitUserAccounts(decimal oldUserId, decimal newUserId);
        void LockUser(decimal userId, string dateStart, string dateEnd);
        void UnlockUser(decimal userId, string dateStart, string dateEnd);

        IEnumerable<USERADM_USERGRP_WEB> UserGrpData(DataSourceRequest request, decimal userId);
        decimal UserGrpCount(DataSourceRequest request, decimal userId);

        IEnumerable<USERADM_ALL_GRP_WEB> GrpData(DataSourceRequest request, decimal userId);
        decimal GrpCount(DataSourceRequest request, decimal userId);

        void ChangeStatus(decimal userId, decimal tabid, bool pr, bool deb, bool cre);
    }
}
