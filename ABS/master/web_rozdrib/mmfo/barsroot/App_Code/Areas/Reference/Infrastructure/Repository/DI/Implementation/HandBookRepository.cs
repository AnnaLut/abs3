using System.Data;
using Areas.Reference.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Reference.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Abstract;
using System.Linq;
using Kendo.Mvc.UI;
using Oracle.DataAccess.Client;
using CommandType = System.Data.CommandType;

namespace BarsWeb.Areas.Reference.Infrastructure.Repository.DI.Implementation
{
    public class HandBookRepository : IHandBookRepository
    {
        readonly ReferenceEntities _entities;
        private readonly IUtils _utils;
        private readonly IHandBookMetadataRepository _metadata;
        private readonly IKendoSqlCounter _sqlCounter;
        private readonly IKendoSqlTransformer _kendoSqlTransformer;
        public HandBookRepository(IReferenceModel model,
            IHandBookMetadataRepository metadata,
            IUtils utils,
            IKendoSqlCounter sqlCounter,
            IKendoSqlTransformer sqlTransformer)
        {
            _entities = model.ReferenceEntities;
            _metadata = metadata;
            _utils = utils;
            _sqlCounter = sqlCounter;
            _kendoSqlTransformer = sqlTransformer;
        }

        public DataSet GetHandBookData(string tableName, string clause,DataSourceRequest request)
        {
            var handBook = _metadata.GetHandBookByName(tableName);
            var sql = _utils.GetHandBookQuery(handBook,clause);

            BarsSql bSql = new BarsSql
            {
                SqlText = sql,
                SqlParams = null
            };

            var adapterSql = _kendoSqlTransformer.TransformSql(bSql, request);

            OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
            var command = con.CreateCommand();
            command.CommandType = CommandType.Text;
            try
            {
                var dataSet = new DataSet();

                command.CommandText = adapterSql.SqlText;
                if (adapterSql.SqlParams != null)
                {
                    foreach (var item in adapterSql.SqlParams)
                    {
                        command.Parameters.Add(item);
                    }
                }

                var adapter = new OracleDataAdapter(command);
                adapter.Fill(dataSet);
                return dataSet;
            }
            finally
            {
                if (command.Connection.State == ConnectionState.Open)
                {
                    command.Connection.Close();
                }
                command.Dispose();
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
                con.Dispose();
            }
        }

        public int GetHandBookDataCount(string tableName, string clause, DataSourceRequest request)
        {
            var handBook = _metadata.GetHandBookByName(tableName);
            var sql = _utils.GetHandBookQuery(handBook,clause);
            var barsSql = new BarsSql {SqlText = sql};
            var adapterSql = _sqlCounter.TransformSql(barsSql,request);
            return (int)_entities.ExecuteStoreQuery<decimal>(adapterSql.SqlText,adapterSql.SqlParams).FirstOrDefault();
        }

        /*public List<HandBookData> GetBookData(string tableName, string clause)
        {
            if (clause.ToLower() == "null")
            {
                clause = "";
            }
            string columns = " tt as id, name as name ";
            // todo: перевести на метаопис
            if (tableName.ToLower() == "v_user_branches")
            {
                columns = " branch as id, name as name ";
            }
            if (tableName.ToLower() == "v_kl_f00")
            {
                columns = " kodf as id, semantic as name ";
            }
            //clim
            if (tableName.ToLower() == "tabval")
            {
                columns = " to_char(kv) as id, name as name ";
            }
            if (tableName.ToLower() == "clim_accounts")
            {
                columns = " acc_number as id, acc_name as name ";
            }

            if (!string.IsNullOrEmpty(clause) &&  !clause.Trim().ToLower().StartsWith("where"))
            {
                clause = " where " + clause;
            }
            const string sql = @"select 
                                    {0}
                                from 
                                    {1} {2}";

            var list = _entities.ExecuteStoreQuery<HandBookData>(string.Format(sql, columns, tableName, clause)).ToList();
            return list; 
        }*/

    }
}