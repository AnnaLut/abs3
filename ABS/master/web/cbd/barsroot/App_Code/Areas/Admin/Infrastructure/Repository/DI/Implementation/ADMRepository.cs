using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
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
        public ADMRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IAdminModel model)
        {
            _entities = model.Entities;
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }
        public IQueryable<APPLIST> GetADMList()
        {            
            var result = _entities.APPLIST;
            return result.AsQueryable();
        }
      
        public IQueryable<V_APPADM_ALL_OPER> GetADMOperList()
        {
            InitADMOperSql();
            var result = _entities.ExecuteStoreQuery<V_APPADM_ALL_OPER>(_getADMOperSql.SqlText, _getADMOperSql.SqlParams);
            return result.AsQueryable();
        }
        public decimal GetADMOperCount()
        {
            InitADMOperSql();
            var result = _entities.ExecuteStoreQuery<decimal>(_kendoSqlCounter.TransformSql(_getADMOperSql.SqlText, null).SqlText).Single();
            return result;
        }
        public IQueryable<V_APPADM_ALL_REF> GetADMRefList()
        {
            InitADMRefSql();
            var result = _entities.ExecuteStoreQuery<V_APPADM_ALL_REF>(_getADMRefSql.SqlText, _getADMRefSql.SqlParams);
            return result.AsQueryable();
        }
        public decimal GetADMRefCount()
        {
            InitADMRefSql();
            var result = _entities.ExecuteStoreQuery<decimal>(_kendoSqlCounter.TransformSql(_getADMRefSql.SqlText, null).SqlText).Single();
            return result;
        }
        public IEnumerable<V_APPADM_ALL_REP> GetADMRepList()
        {
            InitADMRepSql();
            var result = _entities.ExecuteStoreQuery<V_APPADM_ALL_REP>(_getADMRepSql.SqlText, _getADMRepSql.SqlParams);
            return result;
        }
        public decimal GetADMRepCount()
        {
            InitADMRepSql();
            var result = _entities.ExecuteStoreQuery<decimal>(_kendoSqlCounter.TransformSql(_getADMRepSql.SqlText, null).SqlText).Single();
            return result;
        }
        private void InitADMOperSql()
        {
            _getADMOperSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT *
                    FROM V_APPADM_ALL_OPER
                "),
                SqlParams = new object[] { }
            };
        }
        private void InitADMRefSql()
        {
            _getADMRefSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT *
                    FROM V_APPADM_ALL_REF
                "),
                SqlParams = new object[] { }
            };
        }
        private void InitADMRepSql()
        {
            _getADMRepSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT *
                    FROM V_APPADM_ALL_REP
                "),
                SqlParams = new object[] { }
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
        public IEnumerable<V_APPADM_APP_OPER> GetADMAppOperList()
        {
            InitADMAppOperSql();
            var result = _entities.ExecuteStoreQuery<V_APPADM_APP_OPER>(_getADMAppOperSql.SqlText, _getADMAppOperSql.SqlParams);
            return result;
        }
        public IEnumerable<V_APPADM_APP_REF> GetADMAppRefList()
        {
            InitADMAppRefSql();
            var result = _entities.ExecuteStoreQuery<V_APPADM_APP_REF>(_getADMAppRefSql.SqlText, _getADMAppRefSql.SqlParams);
            return result;
        }
        public IEnumerable<V_APPADM_APP_REP> GetADMAppRepList()
        {
            InitADMAppRepSql();
            var result = _entities.ExecuteStoreQuery<V_APPADM_APP_REP>(_getADMAppRepSql.SqlText, _getADMAppRepSql.SqlParams);
            return result;
        }
        private void InitADMAppOperSql() 
        {
            _getADMAppOperSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_APPADM_APP_OPER"),
                SqlParams = new object[] { }
            };
        }
        private void InitADMAppRefSql()
        {
            _getADMAppRefSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_APPADM_APP_REF"),
                SqlParams = new object[] { }
            };
        }
        private void InitADMAppRepSql()
        {
            _getADMAppRepSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_APPADM_APP_REP"),
                SqlParams = new object[] { }
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
    }
}
