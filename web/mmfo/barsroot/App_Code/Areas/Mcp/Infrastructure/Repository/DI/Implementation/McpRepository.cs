using Areas.Mcp.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Mcp.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;

namespace BarsWeb.Areas.Mcp.Infrastructure.DI.Implementation
{
    public class McpRepository : IMcpRepository
    {
        readonly McpModel _Mcp;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public McpRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _Mcp = new McpModel(EntitiesConnection.ConnectionString("McpModel", "Mcp"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _Mcp.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _Mcp.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _Mcp.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _Mcp.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }

        public IEnumerable<string> GetPaymentTypes()
        {
            var data = ExecuteStoreQuery<string>(new BarsSql
            {
                SqlText = "SELECT payment_type from msp.v_msp_payment_type"
            });
            return data;
        }
        public IEnumerable<string> GetPaymentPeriods()
        {
            var data = ExecuteStoreQuery<string>(new BarsSql
            {
                SqlText = "SELECT payment_period from msp.v_msp_payment_period"
            });
            return data;
        }
        #endregion
    }
}
