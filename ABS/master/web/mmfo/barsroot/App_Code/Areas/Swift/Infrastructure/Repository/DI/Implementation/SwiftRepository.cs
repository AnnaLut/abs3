using Areas.Swift.Models;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Swift.Infrastructure.DI.Abstract;
using BarsWeb.Core.Models;
using BarsWeb.Models;
using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using Oracle.DataAccess.Client;
using Bars.Classes;

namespace BarsWeb.Areas.Swift.Infrastructure.DI.Implementation
{
    public class SwiftRepository : ISwiftRepository
    {
        readonly SwiftModel _swift;
        readonly IKendoSqlTransformer _sqlTransformer;
        readonly IKendoSqlCounter _kendoSqlCounter;
        readonly IParamsRepository _globalData;
        public SwiftRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter, IParamsRepository globalData)
        {
            _swift = new SwiftModel(EntitiesConnection.ConnectionString("SwiftModel", "Swift"));

            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
            _globalData = globalData;
        }

        #region Global search & Count
        public IEnumerable<T> SearchGlobal<T>(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _sqlTransformer.TransformSql(searchQuery, request);
            var item = _swift.ExecuteStoreQuery<T>(query.SqlText, query.SqlParams);
            return item;
        }
        public decimal CountGlobal(DataSourceRequest request, BarsSql searchQuery)
        {
            BarsSql query = _kendoSqlCounter.TransformSql(searchQuery, request);
            ObjectResult<decimal> res = _swift.ExecuteStoreQuery<decimal>(query.SqlText, query.SqlParams);
            decimal count = res.Single();
            return count;
        }
        public IEnumerable<T> ExecuteStoreQuery<T>(BarsSql searchQuery)
        {
            return _swift.ExecuteStoreQuery<T>(searchQuery.SqlText, searchQuery.SqlParams);
        }

        public int ExecuteStoreCommand(string commandText, params object[] parameters)
        {
            return _swift.ExecuteStoreCommand(commandText, parameters);
        }

        public Params GetParam(string id)
        {
            return _globalData.GetParam(id);
        }
        #endregion

        #region Individual, based on types of messages requests
        public List<SwiftGPIStatuses> GetMTGridItems()
        {
            List<SwiftGPIStatuses> dataList = new List<SwiftGPIStatuses>();
            using (OracleConnection conn = OraConnector.Handler.IOraConnection.GetUserConnection())
            {
                using (OracleCommand command = conn.CreateCommand())
                {
                    command.CommandText = @"Select 
                                Ref, 
                                MT103, 
                                io_ind_103 as InputOutputInd103,
                                swref_103 as SWRef,
                                date_input_103 as DateIn,
                                vdate_103 as VDate,
                                date_output_103 as DateOut,
                                sender_103 as SenderCode,
                                sender_account as SenderAccount,
                                receiver_103 as ReceiverCode,
                                payer_103 as Payer,
                                payee_103 as Payee,
                                amount as Summ,
                                Currency,
                                STI,
                                UETR,
                                status_code as Status,
                                status_description as StatusDescription
                                    from v_sw_gpi_statuses";
                    command.CommandType = System.Data.CommandType.Text;

                    using (OracleDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            SwiftGPIStatuses row = new SwiftGPIStatuses();
                            row.Ref = Convert.ToInt64(reader["Ref"].ToString());
                            row.MT103 = Convert.ToInt64(reader["MT103"].ToString());
                            row.InputOutputInd103 = reader["InputOutputInd103"].ToString();
                            row.SWRef = Convert.ToInt64(reader["SWRef"].ToString());
                            if (reader["DateIn"].ToString() != null)
                            {
                                row.DateIn = Convert.ToDateTime(reader["DateIn"].ToString());
                            }
                            if (reader["VDate"].ToString() != null)
                            {
                                row.VDate = Convert.ToDateTime(reader["VDate"].ToString());
                            }
                            if (reader["DateOut"].ToString() != null)
                            {
                                row.DateOut = Convert.ToDateTime(reader["DateOut"].ToString());
                            }
                            row.SenderCode = reader["SenderCode"].ToString();
                            row.SenderAccount = reader["SenderAccount"].ToString();
                            row.ReceiverCode = reader["ReceiverCode"].ToString();
                            row.Payer = reader["Payer"].ToString();
                            row.Payee = reader["Payee"].ToString();
                            row.Summ = Convert.ToDecimal(reader["Summ"].ToString());
                            row.Currency = reader["Currency"].ToString();
                            row.STI = reader["STI"].ToString();
                            row.UETR = reader["UETR"].ToString();
                            row.Status = reader["Status"].ToString();
                            row.StatusDescription = reader["StatusDescription"].ToString();

                            dataList.Add(row);
                        }
                    }
                }
            }
            return dataList;
        }
        #endregion
    }
}
