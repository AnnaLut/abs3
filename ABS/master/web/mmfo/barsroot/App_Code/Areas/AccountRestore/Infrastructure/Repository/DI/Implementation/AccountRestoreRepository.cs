using Areas.AccountRestore.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.AccountRestore.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using BarsWeb.Areas.AccountRestore.Models;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.Data;

namespace BarsWeb.Areas.AccountRestore.Infrastructure.DI.Implementation
{
    public class AccountRestoreRepository : IAccountRestoreRepository
    {
        readonly AccountRestoreModel _AccountRestore;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public AccountRestoreRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _AccountRestore = new AccountRestoreModel(EntitiesConnection.ConnectionString("AccountRestoreModel", "AccountRestore"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        public RestoreAccount GetRestoreAccount(String Nls, Int16 Kv)
        {
            RestoreAccount restoreAccount = new RestoreAccount();
            using (OracleConnection con = OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                String sql = @"select acc, kv, nls,daos,dazs,nms from saldo where dazs is not null and nls = :p_nls and kv = :p_kv";
                using (OracleCommand cmd = con.CreateCommand())
                {
                    cmd.CommandText = sql;
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Clear();
                    cmd.BindByName = true;

                    cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, Nls, ParameterDirection.Input);
                    cmd.Parameters.Add("p_kv", OracleDbType.Int16, Kv, ParameterDirection.Input);

                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        if (!reader.HasRows)
                            throw new Exception("Рахунок не знайдений або відкритий");

                        Int32 acc = reader.GetOrdinal("ACC");
                        Int32 nls = reader.GetOrdinal("NLS");
                        Int32 kv = reader.GetOrdinal("KV");
                        Int32 nms = reader.GetOrdinal("NMS");
                        Int32 daos = reader.GetOrdinal("DAOS");
                        Int32 dazs = reader.GetOrdinal("DAZS");

                        if (reader.Read())
                        {
                            restoreAccount.ACC = (Decimal)reader.GetValue(acc);
                            restoreAccount.NLS = (String)reader.GetValue(nls);
                            restoreAccount.KV = (Int16?)reader.GetValue(kv);
                            restoreAccount.NMS = (String)reader.GetValue(nms);
                            restoreAccount.DAOS = (DateTime?)reader.GetValue(daos);
                            restoreAccount.DAZS = (DateTime)reader.GetValue(dazs);
                        }
                    }
                }
            }
            return restoreAccount;
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _AccountRestore.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _AccountRestore.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _AccountRestore.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _AccountRestore.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion
    }
}
