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
    public class AccessToAccountsRepository : IAccessToAccountsRepository
    {
        public BarsSql _getSql;
        readonly AccessToAccountsEntities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;

        public AccessToAccountsRepository(IKendoSqlTransformer sqlTransformer)
        {
            var connectionStr = EntitiesConnection.ConnectionString("AccessToAccounts", "AccessToAccounts");
            _entities = new AccessToAccountsEntities(connectionStr);
            _sqlTransformer = sqlTransformer;
        }

        public IQueryable<Groups> GetAccounts([DataSourceRequest] DataSourceRequest request)
        {
            InitGetAccounts();
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<Groups>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<Groups> GetLeftUsers(decimal ID, DataSourceRequest request)
        {
            InitGetLeftUser(ID);
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<Groups>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public IQueryable<Groups> GetRightUsers(decimal ID, DataSourceRequest request)
        {
            InitGetRightUser(ID);
            var sql = _sqlTransformer.TransformSql(_getSql, request);
            var result = _entities.ExecuteStoreQuery<Groups>(sql.SqlText, sql.SqlParams).AsQueryable();
            return result;
        }

        public void ChangeLeftUser(decimal AccountID, decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin sec.revUAgrp(:nUserGrp, :nAccGrp); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("nUserGrp", OracleDbType.Decimal) { Value = ID },
                    new OracleParameter("nAccGrp", OracleDbType.Decimal) { Value = AccountID }
                }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }

        public void ChangeRightUser(decimal AccountID, decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"begin sec.givUAgrp(:nUserGrp, :nAccGrp); end;"),
                SqlParams = new object[]
                {
                    new OracleParameter("nUserGrp", OracleDbType.Decimal) { Value = ID },
                    new OracleParameter("nAccGrp", OracleDbType.Decimal) { Value = AccountID }
                }

            };
            _entities.ExecuteStoreCommand(_getSql.SqlText, _getSql.SqlParams);
        }


        private void InitGetAccounts()
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@"SELECT ID, NAME FROM GROUPS_ACC ORDER BY ID ASC"),
                SqlParams = new object[] { }
            };
        }

        private void InitGetLeftUser(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" SELECT g.id, g.name FROM groups g, groups_staff_acc s WHERE g.id=s.idg AND s.ida=:nId ORDER BY id "),
                SqlParams = new object[] { new OracleParameter("nId", OracleDbType.Decimal) { Value = ID } }
            };

        }

        private void InitGetRightUser(decimal ID)
        {
            _getSql = new BarsSql()
            {
                SqlText = string.Format(@" SELECT g.id, g.name FROM groups g WHERE g.id not in (SELECT s.idg FROM groups_staff_acc s WHERE s.ida=:nId) ORDER BY id "),
                SqlParams = new object[] { new OracleParameter("nId", OracleDbType.Decimal) { Value = ID } }
            };

        }
    }
}