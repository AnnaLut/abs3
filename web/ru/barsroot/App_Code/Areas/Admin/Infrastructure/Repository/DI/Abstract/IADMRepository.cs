using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract
{
    public interface IADMRepository
    {
        IEnumerable<APPADM_ALL_APPS> GetADMList(DataSourceRequest request);
        decimal CountAllAPPS(DataSourceRequest request);
        IEnumerable<APPADM_ALL_OPER> GetADMOperList(string codeApp, DataSourceRequest request);
        decimal GetADMOperCount(string codeApp, DataSourceRequest request);
        IEnumerable<APPADM_ALL_REF> GetADMRefList(string codeApp, DataSourceRequest request);
        decimal GetADMRefCount(string codeApp, DataSourceRequest request);
        IEnumerable<APPADM_ALL_REP> GetADMRepList(string codeApp, DataSourceRequest request);
        decimal GetADMRepCount(string codeApp, DataSourceRequest request);
        void SetCurrentAppContext(string codeApp);
        IEnumerable<V_APPADM_APP_OPER_WEB> GetADMAppOperList(string codeApp, DataSourceRequest request);
        IEnumerable<V_APPADM_APP_REF_WEB> GetADMAppRefList(string codeApp, DataSourceRequest request);
        IEnumerable<V_APPADM_APP_REP_WEB> GetADMAppRepList(string codeApp, DataSourceRequest request);
        void AddResourceToADM(string admId, decimal resVal, int tabId);
        void RemoveResourceFromADM(string admId, decimal resVal, int tabId);
        int CreateADM(string appCode, string appName, decimal frontID);
        int DropADM(string appCode);
        int EditADM(string appCode, string appName, decimal frontID);
        void ChangeRefMode(bool mode, string codeapp, decimal tabid);
    }
}