using Areas.BpkW4.Models;
using Bars.Classes;
using Bars.Oracle;
using BarsWeb.Areas.BpkW4.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ActivationReservedAccountsRepository
/// </summary>
public class ActivationReservedAccountsRepository : IActivationReservedAccountsRepository
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


    public void Activate(IList<decimal> data, int confirm)
    {
        decimal[] accs = data.ToArray();
        using (var connection = OraConnector.Handler.UserConnection)
        {
            try
            {
                OracleCommand cmdInsertInfo = connection.CreateCommand();
                cmdInsertInfo.CommandText = @"begin
                                        bars_ow.confirm_acc(:p_acc, :p_confirm);
                                      end;";

                cmdInsertInfo.Parameters.Clear();
                cmdInsertInfo.BindByName = true;

                OracleParameter acc_array = new OracleParameter("p_acc", OracleDbType.Array, data.Count, (NumberList)accs, ParameterDirection.Input);
                acc_array.UdtTypeName = "BARS.NUMBER_LIST";
                cmdInsertInfo.Parameters.Add(acc_array);

                cmdInsertInfo.Parameters.Add("p_confirm", OracleDbType.Int32, confirm, ParameterDirection.Input);

                cmdInsertInfo.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}