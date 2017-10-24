using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BarsWeb.Areas.Admin.Infrastructure.Repository.DI.Abstract;
using Areas.Admin.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Admin.Models.ListSet;
using BarsWeb.Areas.Kernel.Models;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;

/// <summary>
/// Summary description for ListSetRepository
/// </summary>
public class ListSetRepository : IListSetRepository
{
    Entities _entities;
    private readonly IKendoSqlTransformer _sqlTransformer;
    private readonly IKendoSqlCounter _kendoSqlCounter;
    public ListSetRepository(IKendoSqlTransformer kendoSqlTransformer,
            IKendoSqlCounter kendoSqlCounter, IAdminModel model)
	{
        _entities = model.Entities;
        _sqlTransformer = kendoSqlTransformer;
        _kendoSqlCounter = kendoSqlCounter;
	}

    #region ListSet Data

    public BarsSql _listSetDataQuery;
    public IEnumerable<LIST_SET> ListSetData(DataSourceRequest request)
    {
        InitListSetDataQuery();
        var query = _sqlTransformer.TransformSql(_listSetDataQuery, request);
        var result = _entities.ExecuteStoreQuery<LIST_SET>(query.SqlText, query.SqlParams);
        return result;
    }
    public decimal CountListSetData(DataSourceRequest request)
    {
        InitListSetDataQuery();
        var query = _kendoSqlCounter.TransformSql(_listSetDataQuery, request);
        var count = _entities.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
        return count;
    }
    private void InitListSetDataQuery()
    {
        _listSetDataQuery = new BarsSql()
        {
            SqlText = string.Format(@"select * from list_set"),
            SqlParams = new object[] { }
        };
    }

    #endregion

    #region List_funcset Data

    public BarsSql _listfuncsetQuery;

    public IEnumerable<LIST_FUNCSET> ListFuncsetData(DataSourceRequest request, decimal setId)
    {
        InitListfuncsetQuery(setId);
        var query = _sqlTransformer.TransformSql(_listfuncsetQuery, request);
        var result = _entities.ExecuteStoreQuery<LIST_FUNCSET>(query.SqlText, query.SqlParams);
        return result;
    }

    public decimal CountListFuncsetData(DataSourceRequest request, decimal setId)
    {
        InitListfuncsetQuery(setId);
        var query = _kendoSqlCounter.TransformSql(_listfuncsetQuery, request);
        var count = _entities.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
        return count;
    }

    private void InitListfuncsetQuery(decimal setId)
    {
        _listfuncsetQuery = new BarsSql()
        {
            SqlText = string.Format(@"select f.FUNC_ID, (select name from operlist where codeoper = f.FUNC_ID) FUNCNAME, f.FUNC_ACTIVITY, F.FUNC_COMMENTS, F.FUNC_POSITION, F.REC_ID, F.SET_ID
                from list_funcset f, list_set s 
                where f.SET_ID = :p_set_id and s.id = f.set_id"),
            SqlParams = new object[]
            {
                new OracleParameter("p_set_id", OracleDbType.Decimal) { Value = setId } 
            }
        };
    }

    #endregion

    #region Operlist_handbook Data

    public BarsSql _operlistHBQuery;

    public IEnumerable<OPERLIST_Handbook> OperlistHandbook(DataSourceRequest request, decimal setId)
    {
        InitOperlistHBQuery(setId);
        var query = _sqlTransformer.TransformSql(_operlistHBQuery, request);
        var result = _entities.ExecuteStoreQuery<OPERLIST_Handbook>(query.SqlText, query.SqlParams);
        return result;
    }

    public decimal CountOperlistHandbook(DataSourceRequest request, decimal setId)
    {
        InitOperlistHBQuery(setId);
        var query = _kendoSqlCounter.TransformSql(_operlistHBQuery, request);
        var count = _entities.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams).Single();
        return count;
    }

    private void InitOperlistHBQuery(decimal setId)
    {
        _operlistHBQuery = new BarsSql()
        {
            SqlText = string.Format(@"SELECT O.CODEOPER, O.NAME
                FROM operlist o
                WHERE O.RUNABLE=1
                minus
                SELECT L.FUNC_ID, (select name from operlist where codeoper = l.FUNC_ID) name
                FROM list_funcset l
                WHERE L.SET_ID = :p_set_id"),
            SqlParams = new object[]
            {
                new OracleParameter("p_set_id", OracleDbType.Decimal) { Value = setId } 
            }
        };
    }

    #endregion

    #region ListSetTools

    public void CreateSet(string name, string comment)
    {
        const string command = @"
            begin
                bars_listsetadm.new_list_set(:p_name, :p_comments);
            end;";
        var parameters = new object[]
            {
                new OracleParameter("p_name", OracleDbType.Varchar2) { Value = name },
                new OracleParameter("p_comments", OracleDbType.Varchar2) { Value = comment }
            };
        _entities.ExecuteStoreCommand(command, parameters);
    }
    public void DropSet(decimal id)
    {
        const string command = @"
            begin
                bars_listsetadm.del_list_set(:p_id);
            end;";
        var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal) { Value = id }
            };
        _entities.ExecuteStoreCommand(command, parameters);
    }
    public void UpdateSet(decimal id, string name, string comm)
    {
        const string command = @"
            begin
                bars_listsetadm.upd_list_set(:p_id, :p_name, :p_comments);
            end;";
        var parameters = new object[]
            {
                new OracleParameter("p_id", OracleDbType.Decimal) { Value = id },
                new OracleParameter("p_name", OracleDbType.Varchar2) { Value = name },
                new OracleParameter("p_comments", OracleDbType.Varchar2) { Value = comm }
            };
        _entities.ExecuteStoreCommand(command, parameters);
    }

    #endregion

    #region ListFuncSerTools

    public void AddFuncToSet(decimal setId, decimal funcId)
    {
        const string command = @"
            begin
                bars_listsetadm.new_list_funcset(:p_set_id, :p_func_id,
                             :p_func_activity,
                             :p_func_comments);
            end;";
        var parameters = new object[]
            {
                new OracleParameter("p_set_id", OracleDbType.Decimal) { Value = setId },
                new OracleParameter("p_func_id", OracleDbType.Decimal) { Value = funcId },
                new OracleParameter("p_func_activity", OracleDbType.Decimal) { Value = 0 },
                new OracleParameter("p_func_comments", OracleDbType.Varchar2) { Value = "" }
            };
        _entities.ExecuteStoreCommand(command, parameters);
    }

    public void DropFuncFromSet(decimal setId, decimal funcId)
    {
        const string command = @"
            begin
                bars_listsetadm.del_list_funcset(:p_set_id, :p_func_id);
            end;";
        var parameters = new object[]
            {
                new OracleParameter("p_set_id", OracleDbType.Decimal) { Value = setId },
                new OracleParameter("p_func_id", OracleDbType.Decimal) { Value = funcId }
            };
        _entities.ExecuteStoreCommand(command, parameters);
    }

    public void UpdateFunc(decimal setId, decimal funcId, decimal activity, string comments)
    {
        const string command = @"
            begin
                bars_listsetadm.change_activity(:p_set_id,
                             :p_func_id,
                             :p_func_activity,
                             :p_func_comments);
            end;";
        var parameters = new object[]
            {
                new OracleParameter("p_set_id", OracleDbType.Decimal) { Value = setId },
                new OracleParameter("p_func_id", OracleDbType.Decimal) { Value = funcId },
                new OracleParameter("p_func_activity", OracleDbType.Decimal) { Value = activity },
                new OracleParameter("p_func_comments", OracleDbType.Varchar2) { Value = comments }
            };
        _entities.ExecuteStoreCommand(command, parameters);
    }

    public void UpdateFuncPosition(decimal setId, decimal funcId, decimal position)
    {
        const string command = @"
            begin
                bars_listsetadm.change_pos_list_funcset(:p_set_id,
                             :p_func_id,
                             :p_func_position);
            end;";
        var parameters = new object[]
            {
                new OracleParameter("p_set_id", OracleDbType.Decimal) { Value = setId },
                new OracleParameter("p_func_id", OracleDbType.Decimal) { Value = funcId },
                new OracleParameter("p_func_position", OracleDbType.Decimal) { Value = position }
            };
        _entities.ExecuteStoreCommand(command, parameters);
    }

    #endregion
}