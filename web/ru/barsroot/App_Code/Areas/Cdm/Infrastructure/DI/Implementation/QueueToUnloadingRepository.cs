using System;
using System.Collections.Generic;
using System.Linq;
using Areas.Cdm.Models;
using BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Cdm.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Cdm.Infrastructure.Repository.DI.Implementation
{
    public class QueueToUnloadingRepository : IQueueToUnloadingRepository
    {
        private readonly CdmModel _entities;
        private BarsSql _groupSelectSql;
        private readonly IKendoSqlTransformer _kendoSqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public QueueToUnloadingRepository( IKendoSqlTransformer kendoSqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            var connectionStr = EntitiesConnection.ConnectionString("CdmModel", "Cdm");
            _entities = new CdmModel(connectionStr);
            _kendoSqlTransformer = kendoSqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }

        public IEnumerable<QueueToUnLoading> GetQueueToUnloading(DataSourceRequest request)
        {
            _groupSelectSql = new BarsSql()
            {
                SqlText = @"select * from  v_ebkc_queue_count",
                SqlParams = new object[] { }
            };
            
            var sql = _kendoSqlTransformer.TransformSql(_groupSelectSql, request);
            return _entities.ExecuteStoreQuery<QueueToUnLoading>(_groupSelectSql.SqlText, _groupSelectSql.SqlParams);
        }
    }


}
