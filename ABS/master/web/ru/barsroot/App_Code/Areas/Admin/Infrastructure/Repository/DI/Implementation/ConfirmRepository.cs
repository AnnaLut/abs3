using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class ConfirmRepository : IConfirmRepository
    {
        Entities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public BarsSql _userResourceQuery;
        public BarsSql _appResourceQuery;

        public BarsSql _executeUserAlterResCommand;
        public BarsSql _executeUserDropResCommand;

        public BarsSql _executeAppAlterResCommand;
        public BarsSql _executeAppDropResCommand;
        public ConfirmRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IAdminModel model)
        {
            _entities = model.Entities;
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }


        public IEnumerable<V_USER_RESOURCES_CONFIRM> GetUserConfirmData(DataSourceRequest request)
        {
            InitUserResourceQuery();
            var a = _sqlTransformer.TransformSql(_userResourceQuery, request);
            var result = _entities.ExecuteStoreQuery<V_USER_RESOURCES_CONFIRM>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal CountUserConfirmData(DataSourceRequest request)
        {
            InitUserResourceQuery();
            var a = _kendoSqlCounter.TransformSql(_userResourceQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        private void InitUserResourceQuery()
        {
            _userResourceQuery = new BarsSql()
            {
                SqlText = string.Format(@"select * from V_USER_RESOURCES_CONFIRM"),
                SqlParams = new object[] { }
            };
        }


        public IEnumerable<V_APP_RESOURCES_CONFIRM> GetAppConfirmData(DataSourceRequest request)
        {
            InitAppResourceQuery();
            var a = _sqlTransformer.TransformSql(_appResourceQuery, request);
            var result = _entities.ExecuteStoreQuery<V_APP_RESOURCES_CONFIRM>(a.SqlText, a.SqlParams);
            return result;
        }
        public decimal CountAppConfirmData(DataSourceRequest request)
        {
            InitAppResourceQuery();
            var a = _kendoSqlCounter.TransformSql(_appResourceQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(a.SqlText, a.SqlParams).Single();
            return result;
        }
        private void InitAppResourceQuery()
        {
            _appResourceQuery = new BarsSql()
            {
                SqlText = string.Format(@"select * from V_APP_RESOURCES_CONFIRM"),
                SqlParams = new object[] { }
            };
        }

        public void ConfirmUserApproving(string userId, string resId, string obj)
        {
            InitUserApproving(userId, resId, obj);
            _entities.ExecuteStoreCommand(_executeUserAlterResCommand.SqlText, _executeUserAlterResCommand.SqlParams);
        }
        private void InitUserApproving(string userId, string resId, string obj)
        {
            var pkcolname = "";
            var pkcolname2 = "";
            // id_res - це p_resid in sec_resources.res_id (type = number)
            // а resId - це значення(p_pkcolval) відповідно до obj.
            var id_res = 0;

            switch (obj)
            {
                case "APPLIST_STAFF":
                    pkcolname = "ID";
                    pkcolname2 = "CODEAPP";
                    id_res = 1;
                    break;
                case "STAFF_CHK":
                    pkcolname = "ID";
                    pkcolname2 = "CHKID";
                    id_res = 3;
                    break;
                case "STAFF_KLF00":
                    pkcolname = "ID";
                    pkcolname2 = "KODF";
                    id_res = 5;
                    break;
                case "STAFF_TTS":
                    pkcolname = "ID";
                    pkcolname2 = "TT";
                    id_res = 2;
                    break;
            }
            // Description : Процедура изменения параметров ресурса у пользователя
            _executeUserAlterResCommand = new BarsSql()
            {
                SqlText = string.Format(@"
                        begin
                            bars_useradm.alter_user_resource(
                                p_userid => :p_userid, 
                                p_resid => :p_resid, 
                                p_pkcolnames =>  bars_useradm.t_varchar2list(:p_pkcolname, :p_pkcolname2), 
                                p_pkcolvals =>  bars_useradm.t_varchar2list(:p_pkcolval, :p_pkcolval2), 
                                p_colnames => bars_useradm.t_varchar2list('APPROVE'), 
                                p_colvals => bars_useradm.t_varchar2list('1'));
                        end;"),
                SqlParams = new object[] { 
                        new OracleParameter("p_userid", OracleDbType.Decimal) { Value = userId },
                        new OracleParameter("p_resid", OracleDbType.Decimal) { Value = id_res },
                        new OracleParameter("p_pkcolname", OracleDbType.Varchar2) { Value = pkcolname },
                        new OracleParameter("p_pkcolname2", OracleDbType.Varchar2) { Value = pkcolname2 },
                        new OracleParameter("p_pkcolval", OracleDbType.Varchar2) { Value = userId },
                        new OracleParameter("p_pkcolval2", OracleDbType.Varchar2) { Value = resId }
                    }
            };
        }
        public void ConfirmUserRevoking(string userId, string resId, string obj)
        {
            InitUserRevoking(userId, resId, obj);
            _entities.ExecuteStoreCommand(_executeUserDropResCommand.SqlText, _executeUserDropResCommand.SqlParams);
        }
        private void InitUserRevoking(string userId, string resId, string obj)
        {
            var pkcolname = "";
            var pkcolname2 = "";
            // id_res - це p_resid in sec_resources.res_id (type = number)
            // а resId - це значення(p_pkcolval) відповідно до obj.
            var id_res = 0;

            switch (obj)
            {
                case "APPLIST_STAFF":
                    pkcolname = "ID";
                    pkcolname2 = "CODEAPP";
                    id_res = 1;
                    break;
                case "STAFF_CHK":
                    pkcolname = "ID";
                    pkcolname2 = "CHKID";
                    id_res = 3;
                    break;
                case "STAFF_KLF00":
                    pkcolname = "ID";
                    pkcolname2 = "KODF";
                    id_res = 5;
                    break;
                case "STAFF_TTS":
                    pkcolname = "ID";
                    pkcolname2 = "TT";
                    id_res = 2;
                    break;
            }
            // Description : Процедура изъятия ресурса
            _executeUserDropResCommand = new BarsSql() 
            {
                SqlText = string.Format(@"
                    begin
                    bars_useradm.drop_user_resource(
                        p_userid => :p_userid, 
                        p_resid => :p_resid, 
                        p_pkcolnames =>  bars_useradm.t_varchar2list(:p_pkcolname, :p_pkcolname2), 
                        p_pkcolvals =>  bars_useradm.t_varchar2list(:p_pkcolval, :p_pkcolval2)); 
                    end;"),
                SqlParams = new object[] { 
                    new OracleParameter("p_userid", OracleDbType.Decimal) { Value = userId },
                    new OracleParameter("p_resid", OracleDbType.Decimal) { Value = id_res },
                    new OracleParameter("p_pkcolname", OracleDbType.Varchar2) { Value = pkcolname },
                    new OracleParameter("p_pkcolname2", OracleDbType.Varchar2) { Value = pkcolname2 },
                    new OracleParameter("p_pkcolval", OracleDbType.Varchar2) { Value = userId },
                    new OracleParameter("p_pkcolval2", OracleDbType.Varchar2) { Value = resId }
                }
            };
        }

        public void ConfirmAppApproving(string id, string codeapp, string obj)
        {
            InitAppConfirming(id, codeapp, obj);
            _entities.ExecuteStoreCommand(_executeAppAlterResCommand.SqlText, _executeAppAlterResCommand.SqlParams);
        }
        private void InitAppConfirming(string id, string codeapp, string obj)
        {
            var pkcolname = "";
            var pkcolname2 = "";

            var resId = 0;
            switch(obj) {
                case "OPERAPP":
                        pkcolname = "CODEAPP";
                        pkcolname2 = "CODEOPER";
                        resId = 7;
                    break;
                case "APP_REP":
                        pkcolname = "CODEAPP";
                        pkcolname2 = "CODEREP";
                        resId = 9;
                    break;
                case "REFAPP":
                        pkcolname = "CODEAPP";
                        pkcolname2 = "TABID";
                        resId = 8;
                    break;
            }
            _executeAppAlterResCommand = new BarsSql()
            {
                SqlText = string.Format(@"
                        begin
                        bars_useradm.alter_app_resource(
                            p_appid => :p_appid, 
                            p_resid => :p_resid, 
                            p_pkcolnames =>  bars_useradm.t_varchar2list(:p_pkcolname, :p_pkcolname2), 
                            p_pkcolvals =>  bars_useradm.t_varchar2list(:p_pkcolval, :p_pkcolval2), 
                            p_colnames => bars_useradm.t_varchar2list('APPROVE'), 
                            p_colvals => bars_useradm.t_varchar2list('1'));
                        end;"),
                SqlParams = new object[] {
                    new OracleParameter("p_appid", OracleDbType.Varchar2) { Value = codeapp },
                    new OracleParameter("p_resid", OracleDbType.Varchar2) { Value = resId },
                    new OracleParameter("p_pkcolname", OracleDbType.Varchar2) { Value = pkcolname },
                    new OracleParameter("p_pkcolname2", OracleDbType.Varchar2) { Value = pkcolname2 },
                    new OracleParameter("p_pkcolval", OracleDbType.Varchar2) { Value = codeapp },
                    new OracleParameter("p_pkcolval2", OracleDbType.Varchar2) { Value = id }
                }
            };
        }
        public void ConfirmAppRevoking(string id, string codeapp, string obj)
        {
            InitAppRevoking(id, codeapp, obj);
            _entities.ExecuteStoreCommand(_executeAppDropResCommand.SqlText, _executeAppDropResCommand.SqlParams);
        }
        private void InitAppRevoking(string id, string codeapp, string obj)
        {
            var pkcolname = "";
            var pkcolname2 = "";

            var resId = 0;
            switch (obj)
            {
                case "OPERAPP":
                    pkcolname = "CODEAPP";
                    pkcolname2 = "CODEOPER";
                    resId = 7;
                    break;
                case "APP_REP":
                    pkcolname = "CODEAPP";
                    pkcolname2 = "CODEREP";
                    resId = 9;
                    break;
                case "REFAPP":
                    pkcolname = "CODEAPP";
                    pkcolname2 = "TABID";
                    resId = 8;
                    break;
            }
            _executeAppDropResCommand = new BarsSql()
            {
                SqlText = string.Format(@"
                        begin
                        bars_useradm.drop_app_resource(
                            p_appid => :p_appid, 
                            p_resid => :p_resid, 
                            p_pkcolnames =>  bars_useradm.t_varchar2list(:p_pkcolname, :p_pkcolname2), 
                            p_pkcolvals =>  bars_useradm.t_varchar2list(:p_pkcolval, :p_pkcolval2));
                        end;"),
                SqlParams = new object[] {
                    new OracleParameter("p_appid", OracleDbType.Varchar2) { Value = codeapp },
                    new OracleParameter("p_resid", OracleDbType.Varchar2) { Value = resId },
                    new OracleParameter("p_pkcolname", OracleDbType.Varchar2) { Value = pkcolname },
                    new OracleParameter("p_pkcolname2", OracleDbType.Varchar2) { Value = pkcolname2 },
                    new OracleParameter("p_pkcolval", OracleDbType.Varchar2) { Value = codeapp },
                    new OracleParameter("p_pkcolval2", OracleDbType.Varchar2) { Value = id }
                }
            };
        }
    }
}