using Areas.Way4Bpk.Models;
using Bars.Classes;
using Bars.Oracle;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Way4Bpk.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects;
using System.Linq;

namespace BarsWeb.Areas.Way4Bpk.Infrastructure.DI.Implementation
{
    public class Way4BpkRepository : IWay4BpkRepository
    {
        readonly Way4BpkModel _Way4Bpk;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public Way4BpkRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _Way4Bpk = new Way4BpkModel(EntitiesConnection.ConnectionString("Way4BpkModel", "Way4Bpk"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        public bool GetDocumentVerifiedState(decimal rnk)
        {
            using (OracleConnection conn = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "select EBP.get_verified_state( :p_rnk ) from dual";
                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);

                    return Convert.ToInt32(cmd.ExecuteScalar()) == 1;
                }
            }
        }

        public string GetKf()
        {
            string Kf = string.Empty;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.Parameters.Clear();
                    cmd.CommandText = "SELECT sys_context('bars_context', 'user_mfo') FROM dual";
                    cmd.CommandType = CommandType.Text;
                    return Convert.ToString(cmd.ExecuteScalar());
                }
            }
        }

        public List<Bars.EAD.Structs.Result.DocumentData> CheckDocs(List<Bars.EAD.Structs.Result.DocumentData> val)
        {
            List<Bars.EAD.Structs.Result.DocumentData> res = new List<Bars.EAD.Structs.Result.DocumentData>();
            if (val.Count <= 0) return res;
            for (int i = 0; i < val.Count; i++)
            {
                if (!string.IsNullOrWhiteSpace(val[i].DocLink) && !string.IsNullOrWhiteSpace(val[i].Struct_Name))
                    res.Add(val[i]);
            }
            return res;
        }

        public void SetDocumentVerifiedState(decimal rnk, decimal state)
        {
            using (OracleConnection conn = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = @"begin EBP.set_verified_state( :p_rnk, :p_state ); end;";

                    cmd.Parameters.Add("p_rnk", OracleDbType.Decimal, rnk, ParameterDirection.Input);
                    cmd.Parameters.Add("p_state", OracleDbType.Decimal, state, ParameterDirection.Input);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _Way4Bpk.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _Way4Bpk.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _Way4Bpk.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _Way4Bpk.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion
    }
}
