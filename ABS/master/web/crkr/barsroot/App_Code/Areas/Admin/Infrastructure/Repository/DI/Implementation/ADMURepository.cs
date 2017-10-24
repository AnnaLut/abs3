using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
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

        public BarsSql _getAllUsers;

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

        public BarsSql _getCurrentUser;
        public BarsSql _getUserRoles;

        public BarsSql _addUser;
        public BarsSql _editUser;
        public BarsSql _dropUser;

        public BarsSql _getAllBranchesSql;

        public BarsSql _getUserResourcesSql;

        public BarsSql _setCloneUser;

        public BarsSql _getTransmitUsersList;
        public BarsSql _setTransmitUserAcc;

        public BarsSql _setLockUser;
        public BarsSql _setUnlockUser;
        public ADMURepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IAdminModel model)
        {
            _entities = model.Entities;
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter; 
        }
        /*public IQueryable<STAFF_BASE> GetADMUList()
        {
            var result = _entities.STAFF_BASE;
            return result;
        }*/
        public IEnumerable<V_USERADM_USERS> GetADMUList(DataSourceRequest request)
        {
            InitGetAllUsersSQL();
            var a = _sqlTransformer.TransformSql(_getAllUsers, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_USERS>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal CountADMUList(DataSourceRequest request)
        {
            InitGetAllUsersSQL();
            var a = _kendoSqlCounter.TransformSql(_getAllUsers, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        private void InitGetAllUsersSQL()
        {
            _getAllUsers = new BarsSql()
            {
                SqlText = string.Format(@"select * from V_USERADM_USERS order by USER_ID"),
                SqlParams = new object[] { }
            };
        }
        public IEnumerable<USERADM_ALL_APPS_WEB> GetAPPsList(decimal userID, DataSourceRequest request)
        {
            InitAllAPPs(userID);
            var a = _sqlTransformer.TransformSql(_getAllAPPsSql, request);
            var result = _entities.ExecuteStoreQuery<USERADM_ALL_APPS_WEB>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal CountAPPsList(decimal userID, DataSourceRequest request)
        {
            InitAllAPPs(userID);
            var a = _kendoSqlCounter.TransformSql(_getAllAPPsSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        public IEnumerable<USERADM_ALL_TTS_WEB> GetTTSList(decimal userID, DataSourceRequest request)
        {
            InitAllTTS(userID);
            var a = _sqlTransformer.TransformSql(_getAllTTSSql, request);
            var result = _entities.ExecuteStoreQuery<USERADM_ALL_TTS_WEB>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal CountTTSList(decimal userID, DataSourceRequest request)
        {
            InitAllTTS(userID);
            var a = _kendoSqlCounter.TransformSql(_getAllTTSSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        public IEnumerable<USERADM_ALL_CHKGRPS> GetCHKGRPSList(decimal userID, DataSourceRequest request)
        {
            InitAllCHKGRPS(userID);
            var a = _sqlTransformer.TransformSql(_getAllCHKGRPSSql, request);
            var result = _entities.ExecuteStoreQuery<USERADM_ALL_CHKGRPS>(a.SqlText, a.SqlParams);
            return result.AsQueryable();
        }
        public decimal CountCHKGRPSList(decimal userID, DataSourceRequest request)
        {
            InitAllCHKGRPS(userID);
            var a = _kendoSqlCounter.TransformSql(_getAllCHKGRPSSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result; 
        }
        public IEnumerable<USERADM_ALL_NBUREPS> GetNBUREPSList(decimal userID, DataSourceRequest request)
        {
            InitAllNBUREPS(userID);
            var a = _sqlTransformer.TransformSql(_getAllNBUREPSSql, request);
            var result = _entities.ExecuteStoreQuery<USERADM_ALL_NBUREPS>(a.SqlText, a.SqlParams);
            return result.AsQueryable();
        }
        public decimal CountNBUREPSList(decimal userID, DataSourceRequest request)
        {
            InitAllNBUREPS(userID);
            var a = _kendoSqlCounter.TransformSql(_getAllNBUREPSSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        public void SetCurrentUserContext(decimal userId)
        {
            ExcUserResSql(userId);
            _entities.ExecuteStoreCommand(_excUserResSql.SqlText, _excUserResSql.SqlParams);
        }
        private void InitAllAPPs(decimal userID)
        {
            _getAllAPPsSql = new BarsSql()
            {
                SqlText = string.Format(@"
                       SELECT a.codeapp, a.name
                       FROM applist a
                       minus
                       SELECT a.codeapp, a.name
                       FROM V_USERADM_USER_APPS_WEB a
                       WHERE a.userID = :p_userID
                "),
                SqlParams = new object[] { new OracleParameter("p_userID", OracleDbType.Decimal) { Value = userID } }
            };
        }
        private void InitAllTTS(decimal userID) 
        {
            _getAllTTSSql = new BarsSql()
            {
                SqlText = string.Format(@"
                     SELECT a.tt, a.name
                     FROM tts a
                         minus
                     SELECT a.tt, a.name
                     FROM V_USERADM_USER_TTS_WEB a
                     WHERE a.userID = :p_userID
                "),
                SqlParams = new object[] { new OracleParameter("p_userID", OracleDbType.Decimal) { Value = userID } }
            };
        }
        private void InitAllCHKGRPS(decimal userID) 
        {
            _getAllCHKGRPSSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT a.IDCHK CHKID, a.name
                     FROM chklist a
                         minus
                     SELECT a.CHKID, a.name
                     FROM V_USERADM_USER_CHKGRPS_WEB a
                     WHERE a.userID = :p_userID
                "),
                SqlParams = new object[] { new OracleParameter("p_userID", OracleDbType.Decimal) { Value = userID } }
            };
        }
        private void InitAllNBUREPS(decimal userID) 
        {
            _getAllNBUREPSSql = new BarsSql() 
            { 
                SqlText = string.Format(@"
                    SELECT a.KODF, a.a017, a.semantic NAME
                     FROM kl_f00 a
                         minus
                     SELECT a.KODF, a.a017, a.name
                     FROM V_USERADM_USER_NBUREPS_WEB a
                     WHERE a.userID = :p_userID
                "),
                SqlParams = new object[] { new OracleParameter("p_userID", OracleDbType.Decimal) { Value = userID } }
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

        public IEnumerable<V_USERADM_USER_APPS_WEB> GetCurrentUserApps(decimal userID, DataSourceRequest request)
        {
            InitCurrentUserAppsSql(userID);
            var a = _sqlTransformer.TransformSql(_currentUserApps, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_USER_APPS_WEB>(a.SqlText, a.SqlParams);
            return result;
        }
        public IEnumerable<V_USERADM_USER_TTS_WEB> GetCurrentUserTTS(decimal userID, DataSourceRequest request)
        {
            InitCurrentUserTTSSql(userID);
            var a = _sqlTransformer.TransformSql(_currentUserTTS, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_USER_TTS_WEB>(a.SqlText, a.SqlParams);
            return result;
        }
        public IEnumerable<V_USERADM_USER_CHKGRPS_WEB> GetCurrentUserChkGrps(decimal userID, DataSourceRequest request)
        {
            InitCurrentUserChkGrpsSql(userID);
            var a = _sqlTransformer.TransformSql(_currentUserChkGrps, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_USER_CHKGRPS_WEB>(a.SqlText, a.SqlParams);
            return result;
        }
        public IEnumerable<V_USERADM_USER_NBUREPS_WEB> GetCurrentUserNBURps(decimal userID, DataSourceRequest request)
        {
            InitCurrentUserNBURps(userID);
            var a = _sqlTransformer.TransformSql(_currentUserNBURps, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_USER_NBUREPS_WEB>(a.SqlText, a.SqlParams);
            return result;
        }
        private void InitCurrentUserAppsSql(decimal userID) 
        {
            _currentUserApps = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_USERADM_USER_APPS_WEB where USERID = :p_userID"),
                SqlParams = new object[] { new OracleParameter("p_userID", OracleDbType.Decimal) { Value = userID } }
            };
        }
        private void InitCurrentUserTTSSql(decimal userID) 
        { 
            _currentUserTTS = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_USERADM_USER_TTS_WEB where USERID = :p_userID"),
                SqlParams = new object[] { new OracleParameter("p_userID", OracleDbType.Decimal) { Value = userID } }
            };
        }
        private void InitCurrentUserChkGrpsSql(decimal userID) 
        {
            _currentUserChkGrps = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_USERADM_USER_CHKGRPS_WEB where USERID = :p_userID"),
                SqlParams = new object[] { new OracleParameter("p_userID", OracleDbType.Decimal) { Value = userID } }
            };
        }
        private void InitCurrentUserNBURps(decimal userID) 
        {
            _currentUserNBURps = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_USERADM_USER_NBUREPS_WEB where USERID = :p_userID"),
                SqlParams = new object[] { new OracleParameter("p_userID", OracleDbType.Decimal) { Value = userID } }
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
            var colPKName3 = "";
            var colPKName4 = "";
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
                case 4:
                    resID = 4;
                    colPKName = "IDG";
                    colPKName2 = "SEC_SEL";
                    colPKName3 = "SEC_DEB";
                    colPKName4 = "SEC_CRE";
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
            else if (tabID == 4)
            {
                _excResToUser = new BarsSql()
                {
                    SqlText = string.Format(@"
                        begin   
                            bars_useradm.grant_user_resource(:p_userid, :p_resid, 
                            bars_useradm.t_varchar2list(:p_ColPKName,:p_ColPKName2, :p_ColPKName3, :p_ColPKName4), 
                            bars_useradm.t_varchar2list(:p_ColPKVal, :p_ColPKVal2, :p_ColPKVal3, :p_ColPKVal4));
                        end;
                    "),
                    SqlParams = new object[] { 
                        new OracleParameter("p_userid", OracleDbType.Varchar2) { Value = userID },
                        new OracleParameter("p_resid", OracleDbType.Decimal) { Value = resID },
                        new OracleParameter("p_ColPKName", OracleDbType.Varchar2) { Value = colPKName },
                        new OracleParameter("p_ColPKName2", OracleDbType.Varchar2) { Value = colPKName2 },
                        new OracleParameter("p_ColPKName3", OracleDbType.Varchar2) { Value = colPKName3 },
                        new OracleParameter("p_ColPKName4", OracleDbType.Varchar2) { Value = colPKName4 },
                        new OracleParameter("p_ColPKVal", OracleDbType.Decimal) { Value = resVal },
                        new OracleParameter("p_ColPKVal2", OracleDbType.Decimal) { Value = 0 },
                        new OracleParameter("p_ColPKVal3", OracleDbType.Decimal) { Value = 0 },
                        new OracleParameter("p_ColPKVal4", OracleDbType.Decimal) { Value = 0 }
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
                case 4:
                    resID = 4;
                    colPKName = "IDG";
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
        public V_USERADM_USERS GetCurrentUser(decimal userId)
        {
            //var user = _entities.STAFF_BASE.Where(id => id.ID == userId).SingleOrDefault();
            InitCurrentUserSQL(userId);
            var user = _entities.ExecuteStoreQuery<V_USERADM_USERS>(_getCurrentUser.SqlText, _getCurrentUser.SqlParams).SingleOrDefault();
            return user;
        }
        public void InitCurrentUserSQL(decimal userId)
        {
            _getCurrentUser = new BarsSql() {
                SqlText = string.Format(@"
                    select *
                    from v_useradm_users
                    where USER_ID = :p_userID "),
                SqlParams = new object[] 
                { 
                    new OracleParameter("p_userID", OracleDbType.Decimal) { Value = userId }
                }
            };
        }
        public IEnumerable<STAFF_CLASS> GetClassData()
        {
            var clsList = _entities.STAFF_CLASS;
            return clsList;
        }
        public IEnumerable<string> GetUserRoles(string userLogin) 
        {
            InitUserRolesSQL(userLogin);
            var result = _entities.ExecuteStoreQuery<string>(_getUserRoles.SqlText, _getUserRoles.SqlParams);
            return result;
        }
        private void InitUserRolesSQL(string userLogin)
        {
            _getUserRoles = new BarsSql()
            {
                SqlText = "SELECT granted_role FROM sys.dba_role_privs WHERE UPPER(default_role)='YES' and UPPER(grantee)=UPPER(:dfLogin)",
                SqlParams = new object[] {
                    new OracleParameter("dfLogin", OracleDbType.Varchar2) { Value = userLogin }
                }
            };
        }
        public string GetExpireDate(decimal userId)
        {
            var result = _entities.ExecuteStoreQuery<DateTime?>("select UREC_EXPIREDATE from v_useradm_users where user_id=:p_userID",
                new OracleParameter("p_userID", OracleDbType.Decimal) { Value = userId }).SingleOrDefault();
            return result.ToString();
        }
        public void AddUser(
            string usrfio,
            string usrtabn,
            decimal usrtype,    // -2
            decimal usraccown,
            string usrbranch,
            decimal? usrusearc,
            decimal usrusegtw,
            string usrwprof,
            string reclogname,
            string recpasswd,
            string recappauth,
            string recprof,
            string recdefrole,
            string recrsgrp,
            decimal? usrid,
            string gtwpasswd,
            string canselectbranch,
            string chgpwd,
            decimal? tipid)
        {
            InitAddUserSQL(usrfio, usrtabn, usrtype, usraccown, usrbranch, usrusearc, usrusegtw, usrwprof,
            reclogname, recpasswd, recappauth, recprof, recdefrole, recrsgrp, usrid, gtwpasswd,
            canselectbranch, chgpwd, tipid);
            _entities.ExecuteStoreCommand(_addUser.SqlText, _addUser.SqlParams);
        }
        private void InitAddUserSQL(string usrfio, string usrtabn, decimal usrtype, decimal usraccown,
            string usrbranch, decimal? usrusearc, decimal usrusegtw, string usrwprof,
            string reclogname, string recpasswd, string recappauth, string recprof,
            string recdefrole, string recrsgrp, decimal? usrid, string gtwpasswd,
            string canselectbranch, string chgpwd, decimal? tipid)
        {
            var can_select_branch = canselectbranch != null ? "Y" : "";
            var chg_Pwd = chgpwd == null ? "N" : "Y";
            var userArc = 0;

            // визначити умови відображення чекБоксу!!!
            if (usrusearc != null)
            {
                userArc = 1;
            }

            _addUser = new BarsSql() {
                SqlText = string.Format(@"
                    begin   
                         BARS_ROLE_AUTH.set_role('ABS_ADMIN');
                         bars_useradm.create_user(
                            :p_usrfio, :p_usrtabn, :p_usrtype, :p_usraccown, :p_usrbranch, :p_usrusearc, :p_usrusegtw, :p_usrwprof,
                            upper(:p_reclogname), :p_recpasswd, :p_recappauth, :p_recprof, :p_recdefrole, :p_recrsgrp, :p_usrid, :p_gtwpasswd,
                            :p_canselectbranch, :p_chgpwd, :p_tipid
                         );
                    end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_usrfio", OracleDbType.Varchar2) { Value = usrfio },
                    new OracleParameter("p_usrtabn", OracleDbType.Varchar2) { Value = usrtabn },
                    new OracleParameter("p_usrtype", OracleDbType.Decimal) { Value = usrtype },
                    new OracleParameter("p_usraccown", OracleDbType.Decimal) { Value = usraccown },
                    new OracleParameter("p_usrbranch", OracleDbType.Varchar2) { Value = usrbranch },
                    new OracleParameter("p_usrusearc", OracleDbType.Decimal) { Value = userArc }, // set
                    new OracleParameter("p_usrusegtw", OracleDbType.Decimal) { Value = usrusegtw },
                    new OracleParameter("p_usrwprof", OracleDbType.Varchar2) { Value = usrwprof },
                    new OracleParameter("p_reclogname", OracleDbType.Varchar2) { Value = reclogname }, 
                    new OracleParameter("p_recpasswd", OracleDbType.Varchar2) { Value = recpasswd },
                    new OracleParameter("p_recappauth", OracleDbType.Varchar2) { Value = recappauth != null ? "APPSERVER" : "" }, // set
                    new OracleParameter("p_recprof", OracleDbType.Varchar2) { Value = recprof },
                    new OracleParameter("p_recdefrole", OracleDbType.Varchar2) { Value = recdefrole },
                    new OracleParameter("p_recrsgrp", OracleDbType.Varchar2) { Value = recrsgrp },
                    new OracleParameter("p_usrid", OracleDbType.Decimal) { Value = usrid },
                    new OracleParameter("p_gtwpasswd", OracleDbType.Varchar2) { Value = gtwpasswd },
                    new OracleParameter("p_canselectbranch", OracleDbType.Varchar2) { Value = can_select_branch }, // set
                    new OracleParameter("p_chgpwd", OracleDbType.Varchar2) { Value = chg_Pwd }, // set
                    new OracleParameter("p_tipid", OracleDbType.Decimal) { Value = tipid }
                }
            };
        }
        public void EditUser(
            decimal usrid,
            string usrfio, 
            string usrtabn, 
            decimal usrtype,
            decimal? usraccown,
            string usrbranch, 
            decimal? usrarc,
            decimal? usrusegtw, 
            string usrwprof,
            string recpasswd,
            string recappauth,
            string recprof,
            string recdefrole, 
            string recrsgrp,
            string canselectbranch, 
            string chgpwd,
            decimal? tipid)
        {
            InitEditUserSQL(usrid, usrfio, usrtabn, usrtype, usraccown, usrbranch, usrarc, usrusegtw, 
                usrwprof, recpasswd, recappauth, recprof, recdefrole, recrsgrp, canselectbranch, chgpwd, tipid);
            _entities.ExecuteStoreCommand(_editUser.SqlText, _editUser.SqlParams);
        }
        private void InitEditUserSQL(
            decimal usrid, string usrfio, string usrtabn, decimal usrtype,
            decimal? usraccown, string usrbranch, decimal? usrarc, decimal? usrusegtw, 
            string usrwprof, string recpasswd, string recappauth, string recprof,
            string recdefrole, string recrsgrp, string canselectbranch, string chgpwd,
            decimal? tipid) 
        {
            var userArc = 0;
            var userUseGtw = 0;
            var userAccownFalse = 0;
            var userAccownTrue = 1;
           // var defRole = ""; - перевірити сценарій, за яким користувач має > 1 ролі

            if (usrarc != null)
                userArc = 1;

            if (usrusegtw != null)
                userUseGtw = 1;

            _editUser = new BarsSql() {
                SqlText = string.Format(@"
                    begin   
                         BARS_ROLE_AUTH.set_role('ABS_ADMIN');
                         bars_useradm.alter_user(
                            :p_usrid, :p_usrfio, :p_usrtabn, :p_usrtype,
                            :p_usraccown, :p_usrbranch, :p_usrarc, :p_usrusegtw, 
                            :p_usrwprof, :p_recpasswd, :p_recappauth, :p_recprof,
                            :p_recdefrole, :p_recrsgrp, :p_canselectbranch, :p_chgpwd,
                            :p_tipid
                         );
                    end;
                "),
                SqlParams = new object[] {
                    new OracleParameter("p_usrid", OracleDbType.Varchar2) { Value = usrid },
                    new OracleParameter("p_usrfio", OracleDbType.Varchar2) { Value = usrfio },
                    new OracleParameter("p_usrtabn", OracleDbType.Varchar2) { Value = usrtabn },
                    new OracleParameter("p_usrtype", OracleDbType.Decimal) { Value = usrtype },
                    new OracleParameter("p_usraccown", OracleDbType.Decimal) { Value = usraccown == null ? userAccownFalse : userAccownTrue },
                    new OracleParameter("p_usrtabn", OracleDbType.Varchar2) { Value = usrbranch },
                    new OracleParameter("p_usrarc", OracleDbType.Decimal) { Value = userArc },
                    new OracleParameter("p_usrusegtw", OracleDbType.Decimal) { Value = userUseGtw },
                    new OracleParameter("p_usrwprof", OracleDbType.Varchar2) { Value = usrwprof },
                    new OracleParameter("p_recpasswd", OracleDbType.Varchar2) { Value = recpasswd },
                    new OracleParameter("p_recappauth", OracleDbType.Varchar2) { Value = recappauth != null ? "APPSERVER" : "" },
                    new OracleParameter("p_recprof", OracleDbType.Varchar2) { Value = recprof },
                    new OracleParameter("p_recdefrole", OracleDbType.Varchar2) { Value = recdefrole }, //defRole
                    new OracleParameter("p_recrsgrp", OracleDbType.Varchar2) { Value = recrsgrp },
                    new OracleParameter("p_canselectbranch", OracleDbType.Varchar2) { Value = canselectbranch == null ? "" : "Y" },
                    new OracleParameter("p_chgpwd", OracleDbType.Varchar2) { Value = chgpwd },
                    new OracleParameter("p_tipid", OracleDbType.Decimal) { Value = tipid },
                }
            };
        }
        public void DropUser(decimal userID)
        {
            InitDropUserSQL(userID);
            _entities.ExecuteStoreCommand(_dropUser.SqlText, _dropUser.SqlParams);
        }
        private void InitDropUserSQL(decimal userID)
        {
            _dropUser = new BarsSql() { 
                SqlText = string.Format(@"
                    begin   
                         BARS_ROLE_AUTH.set_role('ABS_ADMIN');
                         bars_useradm.drop_user(:p_usrid);
                    end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_usrid", OracleDbType.Decimal) { Value = userID }
                }
            };
        }
        public IEnumerable<V_USERADM_BRANCHES> GetBranchList(DataSourceRequest request)
        {
            InitBranchesListSQL();
            var a = _sqlTransformer.TransformSql(_getAllBranchesSql, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_BRANCHES>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal CountBranches(DataSourceRequest request)
        {
            InitBranchesListSQL();
            var a = _kendoSqlCounter.TransformSql(_getAllBranchesSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        private void InitBranchesListSQL()
        {
            _getAllBranchesSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM V_USERADM_BRANCHES ORDER BY BRANCH"),
                SqlParams = new object[] { }
            };
        }
        public IEnumerable<V_USERADM_RESOURCES> GetUserResources(DataSourceRequest request)
        {
            InitUserResourcesSQL();
            var a = _sqlTransformer.TransformSql(_getUserResourcesSql, request);
            var result = _entities.ExecuteStoreQuery<V_USERADM_RESOURCES>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal CountUserResources(DataSourceRequest request)
        {
            InitUserResourcesSQL();
            var a = _kendoSqlCounter.TransformSql(_getUserResourcesSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        private void InitUserResourcesSQL()
        {
            _getUserResourcesSql = new BarsSql()
            {
                SqlText = string.Format(@"
                    select s.res_id, s.res_name
                    from v_useradm_resources s
                    where s.res_id != 4
                    order by s.res_id"),
                SqlParams = new object[] { }
            };
        }
        public void CloneUser(string cloneUserParam)
        {
            List<CloneParams> extAttributes = JsonConvert.DeserializeObject<List<CloneParams>>(cloneUserParam);
            for (int i = 0; i < extAttributes.Count; i++) {
                InitCloneUserSQL(extAttributes[i]);
                _entities.ExecuteStoreCommand(_setCloneUser.SqlText, _setCloneUser.SqlParams);
            }
        }
        private void InitCloneUserSQL(CloneParams cloneParam) 
        {
            _setCloneUser = new BarsSql() 
            {
                SqlText = string.Format(@"
                    begin   
                         BARS_ROLE_AUTH.set_role('ABS_ADMIN');
                         bars_useradm.clone_user_web(:p_srcUserId, :p_dstUserId, bars_useradm.t_numberlist(:p_reslist), bars_useradm.t_numberlist(:p_resclone), bars_useradm.t_numberlist(:p_resclean));
                    end;
                "),
                SqlParams = new object[] {
                    new OracleParameter("p_srcUserId", OracleDbType.Decimal) { Value = cloneParam.ClonedID },
                    new OracleParameter("p_dstUserId", OracleDbType.Decimal) { Value = cloneParam.CloneID },
                    new OracleParameter("p_reslist", OracleDbType.Decimal) { Value = cloneParam.ResourceID },
                    new OracleParameter("p_resclone", OracleDbType.Decimal) { Value = cloneParam.Clone },
                    new OracleParameter("p_resclean", OracleDbType.Decimal) { Value = cloneParam.Clear }
                }
            };
        }
        public IEnumerable<USER> GetTransmitUserList(DataSourceRequest request)
        {
            InitTransmitReqSQL();
            var a = _sqlTransformer.TransformSql(_getTransmitUsersList, request);
            var result = _entities.ExecuteStoreQuery<USER>(a.SqlText, a.SqlParams);
            return result.AsQueryable();
        }
        public decimal CountTransmitUserList(DataSourceRequest request)
        {
            InitTransmitReqSQL();
            var a = _kendoSqlCounter.TransformSql(_getTransmitUsersList, request);
            var total = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return total;
        }
        private void InitTransmitReqSQL()
        {
            _getTransmitUsersList = new BarsSql()
            {
                SqlText = string.Format(@"
                    SELECT id, fio 
                    FROM staff 
                    WHERE nvl(active,0)=1 AND type=1
                    ORDER by 1
                "),
                SqlParams = new object[] { 
                    /*new OracleParameter("p_currentUserId", OracleDbType.Decimal) { Value = userId }*/
                }
            };
        }
        public void GetTransmitUserAccounts(decimal oldUserId, decimal newUserId)
        {
            InitTransmitUserAcc(oldUserId, newUserId);
            _entities.ExecuteStoreCommand(_setTransmitUserAcc.SqlText, _setTransmitUserAcc.SqlParams);
        }
        private void InitTransmitUserAcc(decimal oldUserId, decimal newUserId)
        {
            _setTransmitUserAcc = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin   
                         BARS_ROLE_AUTH.set_role('ABS_ADMIN');
                         bars_useradm.transmit_user_accounts(:p_srcUserId, :p_dstUserId);
                    end;
                "),
                SqlParams = new object[] {
                    new OracleParameter("p_srcUserId", OracleDbType.Decimal) { Value = oldUserId },
                    new OracleParameter("p_dstUserId", OracleDbType.Decimal) { Value = newUserId }
                }
            };
        }
        public void LockUser(decimal userId, string dateStart, string dateEnd)
        {
            InitLockUserCommand(userId, dateStart, dateEnd);
            _entities.ExecuteStoreCommand(_setLockUser.SqlText, _setLockUser.SqlParams);
        }
        private void InitLockUserCommand(decimal userId, string dateStart, string dateEnd)
        {
            DateTime beginDate = DateTime.Parse(dateStart);
            DateTime finishDate = DateTime.Parse(dateEnd);
            _setLockUser = new BarsSql() { 
                SqlText = string.Format(@"
                    begin   
                         BARS_ROLE_AUTH.set_role('ABS_ADMIN');
                         bars_useradm.lock_user(:p_userid, :p_begindate, :p_enddate);
                    end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_userid", OracleDbType.Decimal) { Value = userId },
                    new OracleParameter("p_begindate", OracleDbType.Date) { Value = beginDate },
                    new OracleParameter("p_enddate", OracleDbType.Date) { Value = finishDate }
                }
            };
        }
        public void UnlockUser(decimal userId, string dateStart, string dateEnd)
        {
            InitUnlockUserCommand(userId, dateStart, dateEnd);
            _entities.ExecuteStoreCommand(_setUnlockUser.SqlText, _setUnlockUser.SqlParams);
        }
        private void InitUnlockUserCommand(decimal userId, string dateStart, string dateEnd)
        {
            DateTime beginDate = DateTime.Parse(dateStart);
            DateTime finishDate = DateTime.Parse(dateEnd);
            _setUnlockUser = new BarsSql()
            {
                SqlText = string.Format(@"
                    begin   
                         BARS_ROLE_AUTH.set_role('ABS_ADMIN');
                         bars_useradm.unlock_user(:p_userid, :p_begindate, :p_enddate);
                    end;
                "),
                SqlParams = new object[] { 
                    new OracleParameter("p_userid", OracleDbType.Decimal) { Value = userId },
                    new OracleParameter("p_begindate", OracleDbType.Date) { Value = beginDate },
                    new OracleParameter("p_enddate", OracleDbType.Date) { Value = finishDate }
                }
            };
        }

        public BarsSql _userGrpQuery;
        public IEnumerable<USERADM_USERGRP_WEB> UserGrpData(DataSourceRequest request, decimal userId)
        {
            InitUserGrpQuery(userId);
            var query = _sqlTransformer.TransformSql(_userGrpQuery, request);
            var result = _entities.ExecuteStoreQuery<USERADM_USERGRP_WEB>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal UserGrpCount(DataSourceRequest request, decimal userId)
        {
            InitUserGrpQuery(userId);
            var count = _kendoSqlCounter.TransformSql(_userGrpQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitUserGrpQuery(decimal userId)
        {
            _userGrpQuery = new BarsSql()
            {
                SqlText = string.Format(@"
                     select decode(s.idu,null,:p_userid,s.idu) id, nvl(A.id,0) idg, a.name name,
                      decode(s.revoked,1,'Чекає безпеку') revoked,
                      decode(s.approve,null,3,s.approve) approve, nvl(s.sec_sel,0) pr, nvl(s.sec_deb,0) deb, nvl(s.sec_cre,0) cre
                      from
                      GROUPS_staff s,
                      GROUPS a
                      where s.idg = a.id
                      and s.idu = :p_userid_1
                      order by s.approve nulls last, IDG
                "),
                SqlParams = new object[]
                {
                    new OracleParameter("p_userid", OracleDbType.Decimal) { Value = userId },
                    new OracleParameter("p_userid_1", OracleDbType.Decimal) { Value = userId }
                }
            };
        }

        public BarsSql _grpsData;

        public IEnumerable<USERADM_ALL_GRP_WEB> GrpData(DataSourceRequest request, decimal userId)
        {
            InitGrpsQuery(userId);
            var query = _sqlTransformer.TransformSql(_grpsData, request);
            var result = _entities.ExecuteStoreQuery<USERADM_ALL_GRP_WEB>(query.SqlText, query.SqlParams);
            return result;
        }

        public decimal GrpCount(DataSourceRequest request, decimal userId)
        {
            InitGrpsQuery(userId);
            var count = _kendoSqlCounter.TransformSql(_grpsData, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        private void InitGrpsQuery(decimal userId)
        {
            _grpsData = new BarsSql()
            {
                SqlText = string.Format(@"select id, name from groups minus
                        select nvl(A.id,0) id, a.name name
                          from
                          GROUPS_staff s,
                          GROUPS a
                          where s.idg = a.id
                          and s.idu = :p_userid"),
                SqlParams = new object[] { new OracleParameter("p_userid", OracleDbType.Decimal) { Value = userId } }
            };
        }


        // alter_user_resource
        public BarsSql _alterUserResCommand;

        public void ChangeStatus(decimal userId, decimal tabid, bool pr, bool deb, bool cre)
        {
            InitAlterUserRes(userId,tabid,pr,deb,cre);
            _entities.ExecuteStoreCommand(_alterUserResCommand.SqlText, _alterUserResCommand.SqlParams);
        }
        private void InitAlterUserRes(decimal userID, decimal idg, bool pr, bool deb, bool cre)
        {
            var sec_sel = 0;
            if (pr)
                sec_sel = 1;
            var sec_deb = 0;
            if (deb)
                sec_deb = 1;
            var sec_cre = 0;
            if (cre)
                sec_cre = 1;
            _alterUserResCommand = new BarsSql()
            {
                SqlText = string.Format(@"begin
                bars_useradm.alter_user_resource(
                     :p_idu,
                     4,
                     bars_useradm.t_varchar2list('IDG'),
                     bars_useradm.t_varchar2list(:p_idg),
                     bars_useradm.t_varchar2list('SEC_SEL', 'SEC_DEB', 'SEC_CRE'),
                     bars_useradm.t_varchar2list(:p_sec_sel, :p_sec_deb, :p_sec_cre));
                end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_idu", OracleDbType.Decimal) { Value = userID },
                    new OracleParameter("p_idg", OracleDbType.Decimal) { Value = idg },
                    new OracleParameter("p_sec_sel", OracleDbType.Decimal) { Value = sec_sel },
                    new OracleParameter("p_sec_deb", OracleDbType.Decimal) { Value = sec_deb },
                    new OracleParameter("p_sec_cre", OracleDbType.Decimal) { Value = sec_cre }
                }
            };
        }
    }
}

