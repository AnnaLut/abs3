using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IADMRepository
    {
        IQueryable<APPLIST> GetADMList();
        IQueryable<V_APPADM_ALL_OPER> GetADMOperList();
        decimal GetADMOperCount();
        IQueryable<V_APPADM_ALL_REF> GetADMRefList();
        decimal GetADMRefCount();
        IEnumerable<V_APPADM_ALL_REP> GetADMRepList();
        decimal GetADMRepCount();
        void SetCurrentAppContext(string codeApp);
        IEnumerable<V_APPADM_APP_OPER> GetADMAppOperList();
        IEnumerable<V_APPADM_APP_REF> GetADMAppRefList();
        IEnumerable<V_APPADM_APP_REP> GetADMAppRepList();
        void AddResourceToADM(string admId, decimal resVal, int tabId);
        void RemoveResourceFromADM(string admId, decimal resVal, int tabId);
        int CreateADM(string appCode, string appName, decimal frontID);
        int DropADM(string appCode);
        int EditADM(string appCode, string appName, decimal frontID);
    }
}