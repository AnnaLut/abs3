using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class ADMRepository : IADMRepository
    {
        Entities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public BarsSql _getAllAPPADM;
        public BarsSql _getADMOperSql;
        public BarsSql _getADMRefSql;
        public BarsSql _getADMRepSql;
        public BarsSql _getADMAppOperSql;
        public BarsSql _getADMAppRefSql;
        public BarsSql _getADMAppRepSql;
        public BarsSql _excResToADM;
        public BarsSql _excRemResFromADM;
        public BarsSql _excCreateADM;
        public BarsSql _excEditADM;
        public BarsSql _excDropADM;
        public BarsSql _changeMode;
        public ADMRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IAdminModel model)
        {
            _entities = model.Entities;
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }
        public IEnumerable<APPADM_ALL_APPS> GetADMList(DataSourceRequest request)
        {            
            //var result = _entities.APPLIST;
            InitAllAPPADM();
            var a = _sqlTransformer.TransformSql(_getAllAPPADM, request);
            var result = _entities.ExecuteStoreQuery<APPADM_ALL_APPS>(a.SqlText);
            return result;
        }
        public decimal CountAllAPPS(DataSourceRequest request)
        {
            InitAllAPPADM();
            var a = _kendoSqlCounter.TransformSql(_getAllAPPADM, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText).Single();
            return result;
        }
        private void InitAllAPPADM()
        {
            _getAllAPPADM = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM applist"),
                SqlParams = new object[] { }
            };
        }

        public IEnumerable<APPADM_ALL_OPER> GetADMOperList(string codeApp, DataSourceRequest request)
        {
            InitADMOperSql(codeApp);
            var a = _sqlTransformer.TransformSql(_getADMOperSql, request);
            var result = _entities.ExecuteStoreQuery<APPADM_ALL_OPER>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal GetADMOperCount(string codeApp, DataSourceRequest request)
        {
            InitADMOperSql(codeApp);
            var a = _kendoSqlCounter.TransformSql(_getADMOperSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        public IEnumerable<APPADM_ALL_REF> GetADMRefList(string codeApp, DataSourceRequest request)
        {
            InitADMRefSql(codeApp);
            var a = _sqlTransformer.TransformSql(_getADMRefSql, request);
            var result = _entities.ExecuteStoreQuery<APPADM_ALL_REF>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal GetADMRefCount(string codeApp, DataSourceRequest request)
        {
            InitADMRefSql(codeApp);
            var a = _kendoSqlCounter.TransformSql(_getADMRefSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        public IEnumerable<APPADM_ALL_REP> GetADMRepList(string codeApp, DataSourceRequest request)
        {
            InitADMRepSql(codeApp);
            var a = _sqlTransformer.TransformSql(_getADMRepSql, request);
            var result = _entities.ExecuteStoreQuery<APPADM_ALL_REP>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal GetADMRepCount(string codeApp, DataSourceRequest request)
        {
            InitADMRepSql(codeApp);
            var a = _kendoSqlCounter.TransformSql(_getADMRepSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        private void InitADMOperSql(string codeApp)
        {
            _getADMOperSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT a.codeoper CODEOPER, a.name NAME, a.rolename ROLENAME
                    FROM operlist a
                    MINUS
                    SELECT a.codeoper, a.name, a.rolename
                    FROM V_APPADM_APP_OPER_WEB a
                    WHERE a.codeapp = :p_codeapp
                "),
                SqlParams = new object[] { new OracleParameter("p_codeapp", OracleDbType.Varchar2) { Value = codeApp } }
            };
        }
        private void InitADMRefSql(string codeApp)
        {
            _getADMRefSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT a.tabid TABID,
                          b.semantic NAME,
                          a.role2edit ROLENAME,
                          t.name REFTYPE
                    FROM references a, meta_tables b, typeref t
                    WHERE a.tabid = b.tabid AND a.TYPE = t.TYPE
                    MINUS
                    SELECT v.tabid,
                          v.name,
                          v.rolename,
                          TO_CHAR(v.acode)
                    FROM V_APPADM_APP_REF_WEB v
                    WHERE  v.codeapp = :p_codeapp
                "),
                SqlParams = new object[] { new OracleParameter("p_codeapp", OracleDbType.Varchar2) { Value = codeApp } }
            };
        }
        private void InitADMRepSql(string codeApp)
        {
            _getADMRepSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT a.id CODEREP, a.description NAME, NULL ROLENAME
                    FROM reports a
                    MINUS
                    SELECT a.coderep, a.name, NULL
                    FROM V_APPADM_APP_REP_WEB a
                    WHERE a.codeapp = :p_codeapp
                "),
                SqlParams = new object[] { new OracleParameter("p_codeapp", OracleDbType.Varchar2) { Value = codeApp } }
            };
        }
        public void SetCurrentAppContext(string codeApp)
        { 
            _entities.BARS_USERADM_SET_APP_CONTEXT(codeApp);
        }
        public void AddResourceToADM(string admId, decimal resVal, int tabId)
        {
            ExcResourceToADMSql(admId, resVal, tabId);
            _entities.ExecuteStoreCommand(_excResToADM.SqlText, _excResToADM.SqlParams);
        }
        public void RemoveResourceFromADM(string admId, decimal resVal, int tabId)
        {
            ExcRemoveResourceFromADMSql(admId, resVal, tabId);
            _entities.ExecuteStoreCommand(_excRemResFromADM.SqlText, _excRemResFromADM.SqlParams);
        }
        public IEnumerable<V_APPADM_APP_OPER_WEB> GetADMAppOperList(string codeApp, DataSourceRequest request)
        {
            InitADMAppOperSql(codeApp);
            var a = _sqlTransformer.TransformSql(_getADMAppOperSql, request);
            var result = _entities.ExecuteStoreQuery<V_APPADM_APP_OPER_WEB>(a.SqlText, a.SqlParams);
            return result;
        }
        public IEnumerable<V_APPADM_APP_REF_WEB> GetADMAppRefList(string codeApp, DataSourceRequest request)
        {
            InitADMAppRefSql(codeApp);
            var a = _sqlTransformer.TransformSql(_getADMAppRefSql, request);
            var result = _entities.ExecuteStoreQuery<V_APPADM_APP_REF_WEB>(a.SqlText, a.SqlParams);
            return result;
        }
        public IEnumerable<V_APPADM_APP_REP_WEB> GetADMAppRepList(string codeApp, DataSourceRequest request)
        {
            InitADMAppRepSql(codeApp);
            var a = _sqlTransformer.TransformSql(_getADMAppRepSql, request);
            var result = _entities.ExecuteStoreQuery<V_APPADM_APP_REP_WEB>(a.SqlText, a.SqlParams);
            return result;
        }
        private void InitADMAppOperSql(string codeApp) 
        {
            _getADMAppOperSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_APPADM_APP_OPER_WEB where CODEAPP = :p_codeapp"),
                SqlParams = new object[] { new OracleParameter("p_codeapp", OracleDbType.Varchar2) { Value = codeApp } }
            };
        }
        private void InitADMAppRefSql(string codeApp)
        {
            _getADMAppRefSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_APPADM_APP_REF_WEB where CODEAPP = :p_codeapp"),
                SqlParams = new object[] { new OracleParameter("p_codeapp", OracleDbType.Varchar2) { Value = codeApp } }
            };
        }
        private void InitADMAppRepSql(string codeApp)
        {
            _getADMAppRepSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_APPADM_APP_REP_WEB where CODEAPP = :p_codeapp"),
                SqlParams = new object[] { new OracleParameter("p_codeapp", OracleDbType.Varchar2) { Value = codeApp } }
            };
        }
        private void ExcResourceToADMSql(string admId, decimal resVal, int tabId)
        {
            var resID = 0;
            var colPKName = "";
            switch (tabId)
            {
                case 0:
                    resID = 7;
                    colPKName = "CODEOPER";
                    break;
                case 1:
                    resID = 8;
                    colPKName = "TABID";
                    break;
                case 2:
                    resID = 9;
                    colPKName = "CODEREP";
                    break;
            }

            _excResToADM = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin   
                        bars_useradm.grant_app_resource(:p_ArmId, :p_ResId, bars_useradm.t_varchar2list(:p_ColPKNames), bars_useradm.t_varchar2list(:p_ColPKVals));
                    end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_ArmId", OracleDbType.Varchar2) { Value = admId },
                    new OracleParameter("p_ResId", OracleDbType.Decimal) { Value = resID },
                    new OracleParameter("p_ColPKNames", OracleDbType.Varchar2) { Value = colPKName },
                    new OracleParameter("p_ColPKVals", OracleDbType.Varchar2) { Value = resVal }
                }
            };
        }
        private void ExcRemoveResourceFromADMSql(string admId, decimal resVal, int tabId)
        {
            var resID = 0;
            var colPKName = "";
            switch (tabId)
            {
                case 0:
                    resID = 7;
                    colPKName = "CODEOPER";
                    break;
                case 1:
                    resID = 8;
                    colPKName = "TABID";
                    break;
                case 2:
                    resID = 9;
                    colPKName = "CODEREP";
                    break;
            }

            _excRemResFromADM = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin 
                        bars_useradm.revoke_app_resource(:p_ArmId, :p_ResId, bars_useradm.t_varchar2list(:p_ColPKNames), bars_useradm.t_varchar2list(:p_ColPKVals)); 
                    end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_ArmId", OracleDbType.Varchar2) { Value = admId },
                    new OracleParameter("p_ResId", OracleDbType.Decimal) { Value = resID },
                    new OracleParameter("p_ColPKNames", OracleDbType.Varchar2) { Value = colPKName },
                    new OracleParameter("p_ColPKVals", OracleDbType.Varchar2) { Value = resVal }
                }
            };
        }
        public int CreateADM(string appCode, string appName, decimal frontID)
        {
            var result = 0;
            try
            {
                ExcCreateADMSql(appCode, appName, frontID);
                _entities.ExecuteStoreCommand(_excCreateADM.SqlText, _excCreateADM.SqlParams);
                result = 1;
            }
            catch (Exception ex)
            {
                throw new Exception("Error creating catcher: " + ex);
            }
            return result;
        }
        private void ExcCreateADMSql(string appCode, string appName, decimal frontID)
        {
            _excCreateADM = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin
                        bars_useradm.create_app(:p_dfStCod, :p_dfStNm, :p_dfFeId);
                    end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_dfStCod", OracleDbType.Varchar2) { Value = appCode },
                    new OracleParameter("p_dfStNm", OracleDbType.Varchar2) { Value = appName },
                    new OracleParameter("p_dfFeId", OracleDbType.Decimal) { Value = frontID },
                }
            };
        }
        public int DropADM(string appCode)
        {
            var result = 0;
            try
            {
                ExcDropADMSql(appCode);
                _entities.ExecuteStoreCommand(_excDropADM.SqlText, _excDropADM.SqlParams);
                result = 1;
            }
            catch (Exception ex)
            {
                throw new Exception("Error droping catcher: " + ex);
            }
            return result;
        }
        private void ExcDropADMSql(string appCode)
        {
            _excDropADM = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin
                        bars_useradm.drop_app(:p_sCodeApp);    
                    end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_dfStCod", OracleDbType.Varchar2) { Value = appCode }
                }
            };
        }
        public int EditADM(string appCode, string appName, decimal frontID) 
        {
            var result = 0;
            try
            {
                ExcEditADMSql(appCode, appName, frontID);
                _entities.ExecuteStoreCommand(_excEditADM.SqlText, _excEditADM.SqlParams);
                result = 1;
            }
            catch (Exception ex)
            {
                throw new Exception("Error editing catcher: " + ex);
            }
            return result;
        }
        private void ExcEditADMSql(string appCode, string appName, decimal frontID)
        {
            _excEditADM = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin
                        bars_useradm.alter_app(:p_dfStCod, :p_dfStNm, :p_dfFeId);
                    end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_dfStCod", OracleDbType.Varchar2) { Value = appCode },
                    new OracleParameter("p_dfStNm", OracleDbType.Varchar2) { Value = appName },
                    new OracleParameter("p_dfFeId", OracleDbType.Decimal) { Value = frontID },
                }
            };
        }

        public void ChangeRefMode(bool mode, string codeapp, decimal tabid)
        {
            InitChangeModeQuery(mode, codeapp, tabid);
            _entities.ExecuteStoreCommand(_changeMode.SqlText, _changeMode.SqlParams);
        }

        private void InitChangeModeQuery(bool mode, string codeapp, decimal tabid)
        {
            var acode = "0";
            if (mode)
                acode = "1";

            _changeMode = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin
                      update BARS.REFAPP r set r.ACODE = :p_acode 
                      where r.tabid = :p_tabid
                        and r.codeapp = :p_codeapp
                        and r.approve = 0;
                    end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_acode", OracleDbType.Varchar2) { Value = acode },
                    new OracleParameter("p_tabid", OracleDbType.Decimal) { Value = tabid },
                    new OracleParameter("p_codeapp", OracleDbType.Varchar2) { Value = codeapp },        
                }
            };
        }
    }
}
