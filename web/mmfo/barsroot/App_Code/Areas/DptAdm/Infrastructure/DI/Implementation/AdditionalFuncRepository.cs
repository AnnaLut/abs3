using Bars.Classes;
using BarsWeb.Areas.DptAdm.Infrastructure.Repository.DI.Abstract;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AdditionalFuncRepository
/// </summary>
public class AdditionalFuncRepository: IAdditionalFuncRepository
{
    public AdditionalFuncRepository()
    {

    }

    public List<T> GetOperations<T>()
    {
        var sql = @"select tt, name from tts";
        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<T>(sql).ToList();
        }
    }
    public void SynchronizeDeposits()
    {
        var sql = @"begin SET_RATES_MIGR_DPT(null); end;";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            connection.Execute(sql);
        }
    }
    public void UpdatedDepositsFL()
    {
        var sql = @"begin DPT_START_BRATES('DPT'); end;";

        using (var connection = OraConnector.Handler.UserConnection)
        {
            connection.Execute(sql);
        }
    }
    public List<T> GetVDPT<T>()
    {
        var sql = @"SELECT * FROM V_DPT_159";
        using (var connection = OraConnector.Handler.UserConnection)
        {
            return connection.Query<T>(sql).ToList();
        }
    }
    public void TransferSrokdeposits(dynamic ID, dynamic OPERATION)
    {
        var p = new DynamicParameters();

        p.Add("DPTID", dbType: DbType.Decimal, size: 50, value: Convert.ToDecimal(ID), direction: ParameterDirection.Input);
        p.Add("Param0", dbType: DbType.String, size: 50, value: Convert.ToString(OPERATION), direction: ParameterDirection.Input);

        var sql = @"begin dpt_159(:DPTID,:Param0); end;";
        using (var connection = OraConnector.Handler.UserConnection)
        {
            connection.Execute(sql, p);
        }
    }
}