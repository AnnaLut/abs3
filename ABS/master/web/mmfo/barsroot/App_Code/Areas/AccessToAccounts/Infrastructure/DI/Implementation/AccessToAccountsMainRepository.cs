using BarsWeb.Areas.Kernel.Models;
using System.Collections.Generic;
using BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract;
using Bars.Classes;
using Areas.AccessToAccounts.Models;
using BarsWeb.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.UI;
using System.Linq;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.AccessToAccounts.Infrastucture.DI.Implementation
{
    public class AccessToAccountsMainRepository : IAccessToAccountsMainRepository
    {
        public BarsSql _getSql;
        readonly AccessToAccountsEntities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public AccessToAccountsMainRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("AccessToAccounts", "AccessToAccounts");
            _entities = new AccessToAccountsEntities(connectionStr);
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }

        public IQueryable<Accounts> GetAccounts(DataSourceRequest request)
        {
            InitGetAccounts();
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<Accounts>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<ServingGroups> GetGroupServingAccount(decimal ID, DataSourceRequest request)
        {
            InitGroupServingAccount(ID);
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<ServingGroups>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<ServingGroups> GetGroupUsers(decimal ID, DataSourceRequest request)
        {
            InitGroupUsers(ID);
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<ServingGroups>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<TheGroup> GetTheGroups(decimal ID, DataSourceRequest request)
        {
            InitTheGroups(ID);
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<TheGroup>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public decimal TheGroupsDataCount(decimal ID, DataSourceRequest request)
        {
            InitTheGroups(ID);
            var count = _kendoSqlCounter.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }
        public decimal GroupUsersDataCount(decimal ID, DataSourceRequest request)
        {
            InitGroupUsers(ID);
            var count = _kendoSqlCounter.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        public decimal GroupServingAccountDataCount(decimal ID, DataSourceRequest request)
        {
            InitGroupServingAccount(ID);
            var count = _kendoSqlCounter.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        public decimal AccountsDataCount(DataSourceRequest request)
        {
            InitGetAccounts();
            var count = _kendoSqlCounter.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
        }

        public IQueryable<ServingGroups> GetDropDownAccountGroup(decimal ID)
        {
            InitDropDownAccountGroup(ID);
            var result = _entities.ExecuteStoreQuery<ServingGroups>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<ServingGroups> GetDropDownGroupUsers(decimal ID)
        {
            InitDropDownGroupUsers(ID);
            var result = _entities.ExecuteStoreQuery<ServingGroups>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<ServingGroups> GetDropDownUsers(decimal ID)
        {
            InitDropDownUsers(ID);
            var result = _entities.ExecuteStoreQuery<ServingGroups>(_getSql.SqlText, _getSql.SqlParams).AsQueryable();
            return result;
        }

        private void InitDropDownUsers(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select ID, FIO as NAME from STAFF where ID Not In ( select IDU from GROUPS_STAFF where IDG = :nCurrStaffGrp ) order by FIO"),
                SqlParams = new object[] { new OracleParameter("nCurrStaffGrp", OracleDbType.Decimal) { Value = ID } }
            };
        }

        private void InitDropDownGroupUsers(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"select ID, NAME from GROUPS where ID Not In ( select IDG from GROUPS_STAFF_ACC where IDA = :nCurrAccGrp )order by NAME"),
                SqlParams = new object[] { new OracleParameter("nCurrAccGrp", OracleDbType.Decimal) { Value = ID } }
            };
        }

        private void InitDropDownAccountGroup(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT id, name FROM v_groups_acc where id Not IN ( select COLUMN_VALUE from table( sec.getAgrp(:nAcc) ) ) ORDER BY name"),
                SqlParams = new object[] { new OracleParameter("nAcc", OracleDbType.Decimal) { Value = ID } }
            };
        }

        private void InitGetAccounts()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT v.lcv, a.nls, a.nms, a.acc FROM accounts a, tabval v WHERE a.kv=v.kv AND a.dazs IS NULL ORDER BY a.nls,a.kv"),
                SqlParams = new object[] { }
            };
        }

        private void InitGroupServingAccount(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT g.id, g.name FROM groups_acc g, table(sec.getAgrp(:nCurrAcc)) b WHERE g.id=b.column_value ORDER BY g.id "),
                SqlParams = new object[] { new OracleParameter("nCurrAcc", OracleDbType.Decimal) { Value = ID } }
            };
        }

        private void InitGroupUsers(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT g.id, g.name FROM groups_staff_acc c, groups g WHERE c.idg = g.id AND c.ida=:nCurrAccGrp ORDER BY g.id  "),
                SqlParams = new object[] { new OracleParameter("nCurrAccGrp", OracleDbType.Decimal) { Value = ID } }
            };
        }

        private void InitTheGroups(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT a.id, a.FIO, DECODE(bitand(SECG, 4), 0, 0, 1) as canView, DECODE(bitand(SECG, 2), 0, 0, 1) as canDebit, DECODE(bitand(SECG, 1), 0, 0, 1) as canCredit, decode( b.revoked, 1, '-', decode(b.approve,1,'','+') ) as mark
                                          FROM groups_staff b, staff a WHERE b.idg=:nCurrStaffGrp AND a.id=b.idu ORDER BY a.id"),
                SqlParams = new object[] { new OracleParameter("nCurrStaffGrp", OracleDbType.Decimal) { Value = ID } }
            };
        }

        public void AddAccountGroup(decimal AccID, decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin bars.sec.addAgrp(:nCurrAcc, :nNewGroupId);end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("nCurrAcc", OracleDbType.Decimal) { Value = AccID },
                    new OracleParameter("nNewGroupId", OracleDbType.Decimal) { Value = ID }
                }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }

        public void AddGroupUsers(decimal AccGroupID, decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin BARS.ADM_USR_RIGHTS.LINK_GROUPS(:p_acc_grp_id, :p_usr_grp_id); end; "),
                SqlParams = new object[]
                    {
                    new OracleParameter("p_acc_grp_id", OracleDbType.Decimal) { Value = AccGroupID },
                    new OracleParameter("p_usr_grp_id", OracleDbType.Decimal) { Value = ID }
                    }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }

        public void AddUser(decimal UserGroupID, decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" begin BARS.ADM_USR_RIGHTS.ADD_USER(:p_grp_id, :p_usr_id); end; "),
                SqlParams = new object[]
                    {
                    new OracleParameter("p_grp_id", OracleDbType.Decimal) { Value = UserGroupID },
                    new OracleParameter("p_usr_id", OracleDbType.Decimal) { Value = ID }
                    }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }

        public void DeleteGroupAccount(decimal IDAcc, decimal IDAccGroup)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin bars.sec.delAgrp(:nCurrAcc, :nCurrAccGrp); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("nCurrAcc", OracleDbType.Decimal) { Value = IDAcc },
                    new OracleParameter("nCurrAccGrp", OracleDbType.Decimal) { Value = IDAccGroup }
                }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }
        public void DeleteGroupUser(decimal IDAccGroup, decimal IDUserGroup)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin bars.ADM_USR_RIGHTS.UNLINK_GROUPS(:p_acc_grp_id, :p_usr_grp_id); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("p_acc_grp_id", OracleDbType.Decimal) { Value = IDAccGroup },
                    new OracleParameter("p_usr_grp_id", OracleDbType.Decimal) { Value = IDUserGroup }
                }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);

        }

        public void DeleteUser(decimal IDUserGroup, decimal IDUser)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" begin BARS.ADM_USR_RIGHTS.EXCLUDE_USER(:p_grp_id, :p_usr_id); end; "),
                SqlParams = new object[]
                {
                    new OracleParameter("p_grp_id", OracleDbType.Decimal) { Value = IDUserGroup },
                    new OracleParameter("p_usr_id", OracleDbType.Decimal) { Value = IDUser }
                }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }

        public void UpdateUser(List<UserUpdate> userUpdate)
        {
            _getSql = new BarsSql(); 
            _getSql.SqlText = string.Format(@" begin ADM_USR_RIGHTS.CHANGES_USER_RIGHTS( :p_grp_id, :p_usr_id, :p_view, :p_credit, :p_debit ); end;");

            for (int i = 0; i < userUpdate.Count; i++)
            {

                _getSql.SqlParams = new object[]
                {
                    new OracleParameter("_grp_id", OracleDbType.Decimal) { Value = userUpdate[i].GroupID },
                    new OracleParameter("_usr_id", OracleDbType.Decimal) { Value = userUpdate[i].UserID },
                    new OracleParameter("_view", OracleDbType.Decimal) { Value = userUpdate[i].canView },
                    new OracleParameter("_credit", OracleDbType.Decimal) { Value = userUpdate[i].canCredit },
                    new OracleParameter("_debit", OracleDbType.Decimal) { Value = userUpdate[i].canDebit }
                };
                _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
            }

        }
    }
}
