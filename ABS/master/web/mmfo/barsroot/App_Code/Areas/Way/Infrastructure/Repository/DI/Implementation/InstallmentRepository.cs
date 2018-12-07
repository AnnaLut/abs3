using System;
using System.Collections.Generic;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Areas.Kernel.Models;
using Areas.Way.Models;
using BarsWeb.Models;
using System.Data.Objects;

/// <summary>
/// Summary description for InstallmentRepository
/// </summary>

namespace BarsWeb.Areas.Way.Infrastructure.DI.Implementation
{
    public class InstallmentRepository : IInstallmentRepository
    {
        readonly WayModel _ways;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;

        public InstallmentRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _ways = new WayModel(EntitiesConnection.ConnectionString("WayModel", "Way"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _ways.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _ways.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _ways.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _ways.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion
    }
}