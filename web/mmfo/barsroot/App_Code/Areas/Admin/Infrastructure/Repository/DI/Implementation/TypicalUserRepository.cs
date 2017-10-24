using System;
using System.Collections.Generic;
using System.Linq;
using Areas.Admin.Models;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;

namespace BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Implementation
{
    public class TypicalUserRepository : ITypicalUserRepository
    {
        Entities _entities;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public TypicalUserRepository(IAdminModel model, IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            _entities = model.Entities;
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }

        public BarsSql _typicalUserQuery;

        private void InitTypicalUserQuery()
        {
            _typicalUserQuery = new BarsSql()
            {
                SqlText = @"Select * from STAFF_TIPS",
                SqlParams = new object[] { }
            };
        }
        public IEnumerable<STAFF_TIPS> TypicalUser(DataSourceRequest request)
        {
            InitTypicalUserQuery();
            var query = _sqlTransformer.TransformSql(_typicalUserQuery, request);
            var result = _entities.ExecuteStoreQuery<STAFF_TIPS>(query.SqlText, query.SqlParams);
            return result;
            //throw new NotImplementedException();
        }

        public decimal CountTypicalUser(DataSourceRequest request)
        {
            InitTypicalUserQuery();
            var count = _kendoSqlCounter.TransformSql(_typicalUserQuery, request);
            var result = _entities.ExecuteStoreQuery<decimal>(count.SqlText, count.SqlParams).Single();
            return result;
            //throw new NotImplementedException();
        }
    }
}
