using System;
using System.Collections.Generic;
using System.Data;
using Areas.SuperVisor.Models;
using Bars.Classes;
using BarsWeb.Areas.SuperVisor.Infrastructure.DI.Abstract;
using BarsWeb.Areas.SuperVisor.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.SuperVisor.Infrastructure.DI.Infrastructure
{
    public class BalanceRepository : IBalanceRepository
    {
        private readonly SVEntities _svEntities;
        public BalanceRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("SuperVisorModel", "SuperVisor");
            _svEntities = new SVEntities(connectionStr);
        }

        public void SeedBalanceView(DateTime date, string kv, string nbs)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.p_show_balance", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_date", OracleDbType.Date, date, ParameterDirection.Input);
                command.Parameters.Add("p_refresh", OracleDbType.Decimal, null, ParameterDirection.Input);
                command.Parameters.Add("p_eqviv", OracleDbType.Decimal, null, ParameterDirection.Input);
                command.Parameters.Add("p_kv", OracleDbType.Varchar2, kv, ParameterDirection.Input);
                command.Parameters.Add("p_kv_grp", OracleDbType.Decimal, null, ParameterDirection.Input);
                command.Parameters.Add("p_nbs", OracleDbType.Varchar2, nbs, ParameterDirection.Input);
                command.Parameters.Add("p_nbs_grp", OracleDbType.Decimal, null, ParameterDirection.Input);
                command.Parameters.Add("p_branch", OracleDbType.Varchar2, null, ParameterDirection.Input);

                command.ExecuteNonQuery();
                /*
                OracleCommand query = new OracleCommand(@"
                select show_date, kf, kf_name, nbs, kv, dos,
                    dosq, kos, kosq, ostd, ostdq, ostk, ostkq, row_type
                from v_show_balance
                where row_type = 8", connection);

                query.ExecuteReader();*/
            }
            finally
            {
                connection.Close();
            }
        }

        public IEnumerable<v_show_balance> BalanceData()
        {
            const string query = @"
                select show_date, kf, kf_name, nbs, kv, dos,
                    dosq, kos, kosq, ostd, ostdq, ostk, ostkq, row_type
                from v_show_balance
                where row_type = 8";
            return _svEntities.ExecuteStoreQuery<v_show_balance>(query);
        }
        public IEnumerable<v_show_balance> BalanceData(string kf)
        {
            const string query = @"
                select show_date, kf, kf_name, nbs, kv, dos,
                    dosq, kos, kosq, ostd, ostdq, ostk, ostkq, row_type
                from v_show_balance
                where row_type = 9 and kf = :choose_kf";

            var param = new object[]
            {
                new OracleParameter("choose_kf", OracleDbType.Varchar2, kf, ParameterDirection.Input)
            };

            return _svEntities.ExecuteStoreQuery<v_show_balance>(query, param);
        }

        public IEnumerable<v_show_balance> BalanceData(string kf, string nbs)
        {
            const string query = @"
                select show_date, kf, kf_name, nbs, kv, dos,
                    dosq, kos, kosq, ostd, ostdq, ostk, ostkq, row_type
                from v_show_balance
                where row_type = 10 and kf = :choose_kf and nbs = :choose_nbs";

            var parameters = new object[]
            {
                new OracleParameter("choose_kf", OracleDbType.Varchar2, kf, ParameterDirection.Input),
                new OracleParameter("choose_nbs", OracleDbType.Varchar2, nbs, ParameterDirection.Input)
            };

            return _svEntities.ExecuteStoreQuery<v_show_balance>(query, parameters);
        }

        public DateTime BankDate()
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            try
            {
                OracleCommand command = new OracleCommand("bars.gl.bd", connection);
                command.CommandType = CommandType.StoredProcedure;

                OracleParameter bDate = new OracleParameter("bDATE", OracleDbType.Date,
                    ParameterDirection.ReturnValue);
                command.Parameters.Add(bDate);

                command.ExecuteNonQuery();

                return ((OracleDate)bDate.Value).Value;
            }
            finally
            {
                connection.Close();
            }
        }

        public IEnumerable<tab_val> TabValDictionary()
        {
            const string query = @"
                select kv, name 
                  from ( select case when kv =980 then 1 when kv = 978 then 3 when kv=840 then 2 when kv = 643 then 4 else rownum + 5 end rn, t.* from tabval t) 
                order by rn";
            return _svEntities.ExecuteStoreQuery<tab_val>(query);
        }
    }
}