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
using System.Web;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class ADMURepository : IADMURepository
    {
        Entities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public BarsSql _getAllAPPsSql;
        public BarsSql _getAllTTSSql;
        public BarsSql _getAllCHKGRPSSql;
        public BarsSql _getAllNBUREPSSql;

        public BarsSql _excUserResSql;

        public BarsSql _currentUserApps;
        public BarsSql _currentUserTTS;
        public BarsSql _currentUserChkGrps;
        public BarsSql _currentUserNBURps;

        public BarsSql _excResToUser;
        public BarsSql _excRemoveResFromUser;
        public ADMURepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IAdminModel model)
        {
            _entities = model.Entities;
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter; 
        }
        public IQueryable<STAFF_BASE> GetADMUList()
        {
            var result = _entities.STAFF_BASE;
            return result;
        }
        public IEnumerable<UserADM_AllApps> GetAPPsList(DataSourceRequest request)
        {
            InitAllAPPs();
            var a = _sqlTransformer.TransformSql(_getAllAPPsSql, request);
            var result = _entities.ExecuteStoreQuery<UserADM_AllApps>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal CountAPPsList(DataSourceRequest request)
        {
            InitAllAPPs();
            var a = _kendoSqlCounter.TransformSql(_getAllAPPsSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        public IEnumerable<V_USERADM_ALL_TTS> GetTTSList(DataSourceRequest request)
        {
            InitAllTTS();
            var a = _sqlTransformer.TransformSql(_getAllTTSSql, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_ALL_TTS>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal CountTTSList(DataSourceRequest request)
        {
            InitAllTTS();
            var a = _kendoSqlCounter.TransformSql(_getAllTTSSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        public IEnumerable<V_USERADM_ALL_CHKGRPS> GetCHKGRPSList(DataSourceRequest request)
        {
            InitAllCHKGRPS();
            var a = _sqlTransformer.TransformSql(_getAllCHKGRPSSql, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_ALL_CHKGRPS>(a.SqlText, a.SqlParams);
            return result.AsQueryable();
        }
        public decimal CountCHKGRPSList(DataSourceRequest request)
        {
            InitAllCHKGRPS();
            var a = _kendoSqlCounter.TransformSql(_getAllCHKGRPSSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result; 
        }
        public IEnumerable<V_USERADM_ALL_NBUREPS> GetNBUREPSList(DataSourceRequest request)
        {
            InitAllNBUREPS();
            var a = _sqlTransformer.TransformSql(_getAllNBUREPSSql, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_ALL_NBUREPS>(a.SqlText, a.SqlParams);
            return result.AsQueryable();
        }
        public decimal CountNBUREPSList(DataSourceRequest request)
        {       
            InitAllNBUREPS();
            var a = _kendoSqlCounter.TransformSql(_getAllNBUREPSSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        public void SetCurrentUserContext(decimal userId)
        {
            ExcUserResSql(userId);
            _entities.ExecuteStoreCommand(_excUserResSql.SqlText, _excUserResSql.SqlParams);
        }
        private void InitAllAPPs()
        {
            _getAllAPPsSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT * FROM V_USERADM_ALL_APPS
                "),
                SqlParams = new object[] { }
            };
        }
        private void InitAllTTS() 
        {
            _getAllTTSSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT * FROM V_USERADM_ALL_TTS
                "),
                SqlParams = new object[] { }
            };
        }
        private void InitAllCHKGRPS() 
        {
            _getAllCHKGRPSSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT * FROM V_USERADM_ALL_CHKGRPS
                "),
                SqlParams = new object[] { }
            };
        }
        private void InitAllNBUREPS() 
        {
            _getAllNBUREPSSql = new BarsSql() 
            { 
                SqlText = string.Format(@"
                    SELECT * FROM V_USERADM_ALL_NBUREPS
                "),
                SqlParams = new object[] { }
            };
        }
        private void ExcUserResSql(decimal userId)
        {
            _excUserResSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin bars_useradm.set_user_context(:p_userId); end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_userId", OracleDbType.Decimal) { Value = userId }  
                }
            };
        }

        public IEnumerable<V_USERADM_USER_APPS> GetCurrentUserApps(DataSourceRequest request)
        {
            InitCurrentUserAppsSql();
            var a = _sqlTransformer.TransformSql(_currentUserApps, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_USER_APPS>(a.SqlText, a.SqlParams);
            return result;
        }
        public IEnumerable<V_USERADM_USER_TTS> GetCurrentUserTTS(DataSourceRequest request)
        {
            InitCurrentUserTTSSql();
            var a = _sqlTransformer.TransformSql(_currentUserTTS, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_USER_TTS>(a.SqlText, a.SqlParams);
            return result;
        }
        public IEnumerable<V_USERADM_USER_CHKGRPS> GetCurrentUserChkGrps(DataSourceRequest request)
        {
            InitCurrentUserChkGrpsSql();
            var a = _sqlTransformer.TransformSql(_currentUserChkGrps, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_USER_CHKGRPS>(a.SqlText, a.SqlParams);
            return result;
        }
        public IEnumerable<V_USERADM_USER_NBUREPS> GetCurrentUserNBURps(DataSourceRequest request)
        {
            InitCurrentUserNBURps();
            var a = _sqlTransformer.TransformSql(_currentUserNBURps, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_USER_NBUREPS>(a.SqlText, a.SqlParams);
            return result;
        }
        private void InitCurrentUserAppsSql() 
        {
            _currentUserApps = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_USERADM_USER_APPS"),
                SqlParams = new object[] { }
            };
        }
        private void InitCurrentUserTTSSql() 
        { 
            _currentUserTTS = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_USERADM_USER_TTS"),
                SqlParams = new object[] { }
            };
        }
        private void InitCurrentUserChkGrpsSql() 
        {
            _currentUserChkGrps = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_USERADM_USER_CHKGRPS"),
                SqlParams = new object[] { }
            };
        }
        private void InitCurrentUserNBURps() 
        {
            _currentUserNBURps = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_USERADM_USER_NBUREPS"),
                SqlParams = new object[] { }
            };
        }

        public void AddResourcetoUser(decimal userID, string resVal, int tabID, string nbuA017)
        {
            ExcAddingResToUser(userID, resVal, tabID, nbuA017);
            _entities.ExecuteStoreCommand(_excResToUser.SqlText, _excResToUser.SqlParams);
        }
        public void RemoveResourceFromUser(decimal userID, string resVal, int tabID, string nbuA017)
        {
            ExcRemovingResFromUser(userID, resVal, tabID, nbuA017);
            _entities.ExecuteStoreCommand(_excRemoveResFromUser.SqlText, _excRemoveResFromUser.SqlParams);
        }
        private void ExcAddingResToUser(decimal userID, string resVal, int tabID, string nbuA017)
        {
            var resID = 0;
            var colPKName = "";
            var colPKName2 = "";
            switch (tabID)
            {
                case 0:
                    resID = 1;
                    colPKName = "CODEAPP";
                    break;
                case 1:
                    resID = 2;
                    colPKName = "TT";
                    break;
                case 2:
                    resID = 3;
                    colPKName = "CHKID";
                    break;
                case 3:
                    resID = 5;
                    colPKName = "KODF";
                    colPKName2 = "A017";
                    break;
            }

            if (tabID == 3)
            {
                _excResToUser = new BarsSql()
                {
                    SqlText = string.Format(@"
                        begin   
                            bars_useradm.grant_user_resource(:p_userid, :p_resid, 
                            bars_useradm.t_varchar2list(:p_ColPKName,:p_ColPKName2), 
                            bars_useradm.t_varchar2list(:p_ColPKVal, :p_ColPKVal2));
                        end;
                    "),
                    SqlParams = new object[] { 
                        new OracleParameter("p_userid", OracleDbType.Varchar2) { Value = userID },
                        new OracleParameter("p_resid", OracleDbType.Decimal) { Value = resID },
                        new OracleParameter("p_ColPKName", OracleDbType.Varchar2) { Value = colPKName },
                        new OracleParameter("p_ColPKName2", OracleDbType.Varchar2) { Value = colPKName2 },
                        new OracleParameter("p_ColPKVal", OracleDbType.Varchar2) { Value = resVal },
                        new OracleParameter("p_ColPKVal2", OracleDbType.Varchar2) { Value = nbuA017 }
                    }
                };
            }
            else
            {
                _excResToUser = new BarsSql()
                {
                    SqlText = string.Format(@"
                        begin   
                            bars_useradm.grant_user_resource(:p_userid, :p_resid, bars_useradm.t_varchar2list(:p_ColPKName), bars_useradm.t_varchar2list(:p_ColPKVal));
                        end;
                    "),
                    SqlParams = new object[] { 
                        new OracleParameter("p_userid", OracleDbType.Varchar2) { Value = userID },
                        new OracleParameter("p_resid", OracleDbType.Decimal) { Value = resID },
                        new OracleParameter("p_ColPKName", OracleDbType.Varchar2) { Value = colPKName },
                        new OracleParameter("p_ColPKVal", OracleDbType.Varchar2) { Value = resVal }
                    }
                };
            } 
        }
        private void ExcRemovingResFromUser(decimal userID, string resVal, int tabID, string nbuA017)
        {
            var resID = 0;
            var colPKName = "";
            switch (tabID)
            {
                case 0:
                    resID = 1;
                    colPKName = "CODEAPP";
                    break;
                case 1:
                    resID = 2;
                    colPKName = "TT";
                    break;
                case 2:
                    resID = 3;
                    colPKName = "CHKID";
                    break;
                case 3:
                    resID = 5;
                    colPKName = "KODF";
                    break;
            }

            _excRemoveResFromUser = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin   
                        bars_useradm.revoke_user_resource(:p_userid, :p_resid, bars_useradm.t_varchar2list(:p_ColPKName), bars_useradm.t_varchar2list(:p_ColPKVal));
                    end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_userid", OracleDbType.Varchar2) { Value = userID },
                    new OracleParameter("p_resid", OracleDbType.Decimal) { Value = resID },
                    new OracleParameter("p_ColPKName", OracleDbType.Varchar2) { Value = colPKName },
                    new OracleParameter("p_ColPKVal", OracleDbType.Varchar2) { Value = resVal }
                }
            };
        }
    }
}
