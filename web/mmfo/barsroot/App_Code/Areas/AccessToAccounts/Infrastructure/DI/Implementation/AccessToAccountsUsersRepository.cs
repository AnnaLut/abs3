using System;
using System.Data;
using System.Linq;
using AttributeRouting.Helpers;
using Oracle.DataAccess.Client;
using ibank.core;
using BarsWeb.Areas.Kernel.Models;
using System.Collections.Generic;
using BarsWeb.Areas.AccessToAccounts.Infrastructure.DI.Abstract;
using Bars.Classes;
using Areas.AccessToAccounts.Models;
using BarsWeb.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.AccessToAccounts.Infrastucture.DI.Implementation
{
    public class AccessToAccountsUsersRepository : IAccessToAccountsUsersRepository
    {
        public BarsSql _getSql;
        readonly AccessToAccountsEntities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        public AccessToAccountsUsersRepository(IKendoSqlTransformer sqlTransformer)
        {
            var connectionStr = EntitiesConnection.ConnectionString("AccessToAccounts", "AccessToAccounts");
            _entities = new AccessToAccountsEntities(connectionStr);
            _sqlTransformer = sqlTransformer;
        }

        public IQueryable<Groups> GetGroups([DataSourceRequest] DataSourceRequest request)
        {
            InitGetGroups();
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<Groups>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<Groups> GetUserGroups(decimal ID, [DataSourceRequest] DataSourceRequest request)
        {
            InitGetUserGroups(ID);
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<Groups>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<Groups> GetAccountsGroups(decimal ID, [DataSourceRequest] DataSourceRequest request)
        {
            InitGetAccountsGroups(ID);
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<Groups>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public void ChangeUserGroup(decimal GroupID, decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin sec.revUAgrp(:nUserGrp, :nAccGrp); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("nUserGrp", OracleDbType.Decimal) { Value = GroupID },
                    new OracleParameter("nAccGrp", OracleDbType.Decimal) { Value = ID }
                }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }


        public void ChangeAccountsGroup(decimal GroupID, decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin sec.givUAgrp(:nUserGrp, :nAccGrp); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("nUserGrp", OracleDbType.Decimal) { Value = GroupID },
                    new OracleParameter("nAccGrp", OracleDbType.Decimal) { Value = ID }
                }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }
        private void InitGetGroups()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT * FROM GROUPS ORDER BY ID ASC "),
                SqlParams = new object[] { }
            };
        }

        private void InitGetUserGroups(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT g.id, g.name FROM groups_acc g, groups_staff_acc s WHERE g.id=s.ida AND s.idg=:nId ORDER BY id"),
                SqlParams = new object[] { new OracleParameter("nId", OracleDbType.Decimal) { Value = ID } }
            };
        }

        private void InitGetAccountsGroups(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT g.id, g.name FROM v_groups_acc g WHERE g.id not in (SELECT s.ida FROM groups_staff_acc s WHERE s.idg=:nId) ORDER BY id"),
                SqlParams = new object[] { new OracleParameter("nId", OracleDbType.Decimal) { Value = ID } }
            };
        }
    }
}
