using Areas.BpkW4.Models;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ActivationReservedAccountsRepository
/// </summary>
public class ActivationReservedAccountsRepository: IActivationReservedAccountsRepository
{
    readonly W4Model _entities;
    readonly IKendoSqlTransformer _sqlTransformer;
    readonly IKendoSqlCounter _kendoSqlCounter;

    public ActivationReservedAccountsRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
    {
        var connectionStr = EntitiesConnection.ConnectionString("BpkW4", "BpkW4");
        _entities = new W4Model(connectionStr);

        _sqlTransformer = sqlTransformer;
        _kendoSqlCounter = kendoSqlCounter;
    }

    #region Global search & Count
    public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
    {
        BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
        var item = _entities.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
        return item;
    }
    public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
    {
        BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
        ObjectResult<decimal> res = _entities.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
        decimal count = res.Single();
        return count;
    }
    public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
    {
        return _entities.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
    }

    public int ExecuteStoreCommand(string commandText, params object[] parameters)
    {
        return _entities.ExecuteStoreCommand(commandText, parameters);
    }

    #endregion
}