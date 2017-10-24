using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Admin.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using Areas.Admin.Models;
using Areas.Reporting.Models;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using Telerik.Web.UI;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class SecAuditRepository : ISecAuditRepository
    {
        Entities _entities;
        private BarsSql _groupSelectSql;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;

        public SecAuditRepository(IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter, IAdminModel model)
        {
            _entities = model.Entities;
            _sqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }


        public void InitSecAuditSql(string filter)
        {
            _groupSelectSql = new BarsSql()
            {
                SqlText = @"select * from sec_audit where rec_message like :filter and  rec_date >= sysdate - 2",
                SqlParams = new object[]
                {
                    new OracleParameter("filter", OracleDbType.Varchar2) { Value = filter },
                }
            };
        }

        public IEnumerable<SecAudit> GetSecAuditData(DataSourceRequest request, string filter)
        {
            InitSecAuditSql(filter);
            var sql = _sqlTransformer.TransformSql(_groupSelectSql, request);
            return _entities.ExecuteStoreQuery<SecAudit>(sql.SqlText, sql.SqlParams);
        }
        public decimal GetSecAuditCount(DataSourceRequest request, string filter)
        {
            InitSecAuditSql(filter);
            var sql = _kendoSqlCounter.TransformSql(_groupSelectSql, request);
            var result = _entities.ExecuteStoreQuery<decimal>(sql.SqlText, sql.SqlParams).Single();
            return result;
        }
    }
}