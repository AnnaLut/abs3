using Areas.SWCompare.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.SWCompare.Infrastructure.DI.Abstract;
using BarsWeb.Areas.SWCompare.Models;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using Bars.Classes;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using Oracle.DataAccess.Client;
using System.Data;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.SWCompare.Infrastructure.DI.Implementation
{
    public class SWCompareRepository : ISWCompareRepository
    {
        readonly SWCompareModel _SWCompare;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public SWCompareRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _SWCompare = new SWCompareModel(EntitiesConnection.ConnectionString("SWCompareModel", "SWCompare"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _SWCompare.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _SWCompare.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _SWCompare.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _SWCompare.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion

        public string LoadRuData(RuPostModel ruPostModel)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleCommand cmd = new OracleCommand();
                cmd.Connection = connection;
                cmd.CommandText = "pkg_sw_compare.request_data";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("p_date", OracleDbType.Date).Value = ruPostModel.p_date;
                cmd.Parameters.Add("p_mfo", OracleDbType.Varchar2).Value = ruPostModel.p_mfo;

                OracleParameter message = new OracleParameter("p_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                cmd.Parameters.Add(message);

                cmd.ExecuteNonQuery();

                OracleString resultMessage = (OracleString)message.Value;

                return resultMessage.Value;
            }
        }

        public string LoadZsData(ZsPostModel zsPostModel)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleCommand cmd = new OracleCommand();
                cmd.Connection = connection;
                cmd.CommandText = "pkg_sw_compare.import_sw_data";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("p_date", OracleDbType.Date).Value = zsPostModel.p_date;
                cmd.Parameters.Add("p_kod_nbu", OracleDbType.Varchar2).Value = zsPostModel.p_kod_nbu;
                cmd.Parameters.Add("p_type", OracleDbType.Decimal).Value = 2;

                OracleParameter message = new OracleParameter("p_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                cmd.Parameters.Add(message);

                cmd.ExecuteNonQuery();

                OracleString resultMessage = (OracleString)message.Value;

                return resultMessage.Value;
            }
        }

        public string LoadNBU(NBUPostModel nbuPostModel)
        {
            using (var connection = OraConnector.Handler.UserConnection)
            {
                OracleCommand cmd = new OracleCommand();
                cmd.Connection = connection;
                cmd.CommandText = "pkg_sw_compare.compare_data_auto";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("p_kod_nbu", OracleDbType.Varchar2).Value = nbuPostModel.p_kod_nbu;

                OracleParameter message = new OracleParameter("p_message", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);
                cmd.Parameters.Add(message);

                cmd.ExecuteNonQuery();

                OracleString resultMessage = (OracleString)message.Value;

                return resultMessage.Value;
            }
        }

    }
}
