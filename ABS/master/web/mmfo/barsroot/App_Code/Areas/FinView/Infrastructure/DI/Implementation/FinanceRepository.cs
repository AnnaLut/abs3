using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using Areas.FinView.Models;
using Bars.Classes;
using BarsWeb.Areas.FinView.Infrastructure.DI.Abstract;
using BarsWeb.Areas.FinView.Models;
using BarsWeb.Areas.Ndi.Infrastructure;
using BarsWeb.Models;
using Microsoft.Ajax.Utilities;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.FinView.Infrastructure.DI.Implementation
{
    public class FinanceRepository : IFinanceRepository
    {
        private readonly FinanceEntities _entities;
        public FinanceRepository()
        {
            var connectionStr = EntitiesConnection.ConnectionString("FinanceModel", "FinView");
            _entities = new FinanceEntities(connectionStr);
        }

        public ExchangeRate CurrentExchangeRate(string dDate)
        {
            CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
            ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            ci.DateTimeFormat.DateSeparator = ".";

            const string queryDayClose = @"SELECT d_close FROM tabval WHERE kv=810";
            var dayClose = _entities.ExecuteStoreQuery<DateTime>(queryDayClose).SingleOrDefault();

            const string queryCurrencyCode = @"select kv from tabval where kv=960";
            var currencyCode = _entities.ExecuteStoreQuery<decimal>(queryCurrencyCode).SingleOrDefault();

            var val643 = DateTime.Parse(dDate, ci) < dayClose ? 810 : 643;

            const string query = @"
                SELECT 
                    gl.p_icurval(840,10000,:p_dDAT)/10000 USD, 
                    gl.p_icurval(978,10000,:p_dDAT1)/10000 EUR, 
                    gl.p_icurval(:p_val643,10000,:p_dDAT2)/10000 RUB,
                    Decode(:p_val960,0, null, gl.p_icurval(960,10000,:p_dDAT3)/10000) XDR        
                FROM dual";

            var parameters = new object[]
            {
                new OracleParameter("p_dDAT", OracleDbType.Date, DateTime.Parse(dDate, ci), ParameterDirection.Input),
                new OracleParameter("p_dDAT1", OracleDbType.Date, DateTime.Parse(dDate, ci), ParameterDirection.Input),
                new OracleParameter("p_val643", OracleDbType.Decimal, val643, ParameterDirection.Input),
                new OracleParameter("p_dDAT2", OracleDbType.Date, DateTime.Parse(dDate, ci), ParameterDirection.Input),
                new OracleParameter("p_val960", OracleDbType.Decimal, currencyCode, ParameterDirection.Input),
                new OracleParameter("p_dDAT3", OracleDbType.Date, DateTime.Parse(dDate, ci), ParameterDirection.Input)
            };

            var rate = _entities.ExecuteStoreQuery<ExchangeRate>(query, parameters).SingleOrDefault();
            return rate;
        }
        public IQueryable<Balance> BalanceViewData(string date, decimal rowType, string branch)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            //List<Balance> data = new List<Balance>();
            try
            {
                CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
                ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
                ci.DateTimeFormat.DateSeparator = ".";

                OracleCommand command = new OracleCommand("bars.p_show_balance", connection);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("p_date", OracleDbType.Date, DateTime.Parse(date, ci), ParameterDirection.Input);
                command.Parameters.Add("p_refresh", OracleDbType.Decimal, null, ParameterDirection.Input);
                command.Parameters.Add("p_eqviv", OracleDbType.Decimal, null, ParameterDirection.Input);
                command.Parameters.Add("p_kv", OracleDbType.Varchar2, null, ParameterDirection.Input);
                command.Parameters.Add("p_kv_grp", OracleDbType.Decimal, null, ParameterDirection.Input);
                command.Parameters.Add("p_nbs", OracleDbType.Varchar2, null, ParameterDirection.Input);
                command.Parameters.Add("p_nbs_grp", OracleDbType.Decimal, null, ParameterDirection.Input);
                command.Parameters.Add("p_branch", OracleDbType.Varchar2, null, ParameterDirection.Input);

                command.ExecuteNonQuery();
                /*
                OracleCommand queryCmd = connection.CreateCommand();
                queryCmd.CommandType = CommandType.Text;
                queryCmd.CommandText = @"
                    select show_date, kf, row_type, branch, nbs, kv, dos, dosq, kos, kosq, ostd, ostdq, ostk, ostkq, kf_name
                    from TMP_SHOW_BALANCE_DATA
                    where show_date = :p_date and ROW_TYPE = 10
                ";
                queryCmd.Parameters.Add("p_date", OracleDbType.Date, DateTime.Parse(date), ParameterDirection.Input);

                var reader = queryCmd.ExecuteReader();
                
                while (reader.Read())
                {
                    Balance bal = new Balance();
                    bal.show_date = reader.GetDateTime(0);
                    bal.kf = Convert.ToString(reader["kf"]); // reader.GetString(1);
                    bal.row_type = reader.GetDecimal(2);
                    bal.branch = reader.GetString(3);
                    bal.nbs = reader.GetString(4);

                    bal.kv = reader["kv"] == null ? (decimal?)null : Convert.ToDecimal(reader["kv"]); //reader.GetDecimal(5); 
                    bal.dos = reader["dos"] == null ? (decimal?)null : Convert.ToDecimal(reader["dos"]);  //reader.GetDecimal(6);
                    bal.dosq = reader["dosq"] == null ? (decimal?)null : Convert.ToDecimal(reader["dosq"]);  //reader.GetDecimal(7);
                    bal.kos = reader["kos"] == null ? (decimal?)null : Convert.ToDecimal(reader["kos"]);  //reader.GetDecimal(8);
                    bal.kosq = reader["kosq"] == null ? (decimal?)null : Convert.ToDecimal(reader["kosq"]);  //reader.GetDecimal(9);
                    bal.ostd = reader["ostd"] == null ? (decimal?)null : Convert.ToDecimal(reader["ostd"]);  //reader.GetDecimal(10);
                    bal.ostdq = reader["ostdq"] == null ? (decimal?)null : Convert.ToDecimal(reader["ostdq"]);  //reader.GetDecimal(11);
                    bal.ostk = reader["ostk"] == null ? (decimal?)null : Convert.ToDecimal(reader["ostk"]); //reader.GetDecimal(12);
                    bal.ostkq = reader["ostkq"] == null ? (decimal?)null : Convert.ToDecimal(reader["ostkq"]); //reader.GetDecimal(13);

                    bal.kf_name = reader.GetString(14);
                    data.Add(bal);
                }*/

                string query = string.Format(@"
                    select show_date, kf, row_type, branch, nbs, kv, dos, dosq, kos, kosq, ostd, ostdq, ostk, ostkq, kf_name
                    from TMP_SHOW_BALANCE_DATA
                    where show_date = :p_date and ROW_TYPE = :p_row_type {0}", 
                        branch == null ? "" : " and BRANCH = :p_brnch");

                var param1 = new object[]
                {
                    new OracleParameter("p_date", OracleDbType.Date, DateTime.Parse(date, ci), ParameterDirection.Input),
                    new OracleParameter("p_row_type", OracleDbType.Decimal, rowType, ParameterDirection.Input)
                };

                var param2 = new object[]
                {
                    new OracleParameter("p_date", OracleDbType.Date, DateTime.Parse(date, ci), ParameterDirection.Input),
                    new OracleParameter("p_row_type", OracleDbType.Decimal, rowType, ParameterDirection.Input),
                    new OracleParameter("p_brnch", OracleDbType.Varchar2, branch, ParameterDirection.Input)
                };

                var result = _entities.ExecuteStoreQuery<Balance>(query, branch == null ? param1 : param2).AsQueryable();
                return result;
            }
            finally
            {
                connection.Close();
            }
            //return data.AsQueryable();
        }
        public IQueryable<Branch> Branches()
        {
            const string query = @"Select NAME, BRANCH from branch";
            return _entities.ExecuteStoreQuery<Branch>(query).AsQueryable();
        }
        public IQueryable<Account> AccountData(string kf, string nbs, string branch, string kv, string date)
        {
            CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
            ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            ci.DateTimeFormat.DateSeparator = ".";

            var fDate = DateTime.Parse(date, ci);

            string query = string.Format(@"
                select KF, ACC, NLS, KV, OST OSTC, DOS, KOS, NMS, DAZS, BRANCH
                from BARS.SAL 
                where fdat = :p_fdate and KF = :p_kf {0} {1} {2}",
                nbs == null ? "" : " and nbs = :p_nbs", branch == null ? "" : " and BRANCH = :p_branch", kv == null ? "" : " and kv = :p_kv");

            List<object> list = new List<object>();

            list.Add(new OracleParameter("p_fdate", OracleDbType.Date, fDate, ParameterDirection.Input));
            list.Add(new OracleParameter("p_kf", OracleDbType.Varchar2, kf, ParameterDirection.Input));

            if (!nbs.IsNullOrEmpty())
            {
                list.Add(new OracleParameter("p_nbs", OracleDbType.Varchar2, nbs, 
                    ParameterDirection.Input));
            } 
            if (!branch.IsNullOrEmpty())
            {
                list.Add(new OracleParameter("p_branch", OracleDbType.Varchar2, branch,
                    ParameterDirection.Input));
            }
            if (!kv.IsNullOrEmpty())
            {
                list.Add(new OracleParameter("p_kv", OracleDbType.Decimal, kv,
                    ParameterDirection.Input));
            }

            object[] arrayParams = list.ToArray();

            return _entities.ExecuteStoreQuery<Account>(query, arrayParams).AsQueryable();
        }
        public IQueryable<Document> DocumentData(decimal acc, string date)
        {
            CultureInfo ci = CultureInfo.CreateSpecificCulture("en-GB");
            ci.DateTimeFormat.ShortDatePattern = "dd.MM.yyyy";
            ci.DateTimeFormat.DateSeparator = ".";

            string query = string.Format(@"select decode(dk, 0, tt, null) OperDB, decode(dk, 0, ref, null) RefDB, decode(dk, 1, tt, null) OperKR, decode(dk, 1, ref, null) RefKR
                from opl 
                where fdat = :p_date and acc = :p_acc
                order by dk, s");

            var param = new object[]
                {
                    new OracleParameter("p_date", OracleDbType.Date, DateTime.Parse(date, ci), ParameterDirection.Input),
                    new OracleParameter("p_acc", OracleDbType.Decimal, acc, ParameterDirection.Input)
                };

            return _entities.ExecuteStoreQuery<Document>(query, param).AsQueryable();
        }


        public IEnumerable<kvData> TabValDictionary()
        {
            const string query = @"
                select kv, name 
                  from ( select case when kv =980 then 1 when kv = 978 then 3 when kv=840 then 2 when kv = 643 then 4 else rownum + 5 end rn, t.* from tabval t) 
                order by rn";
            return _entities.ExecuteStoreQuery<kvData>(query);
        }
    }
}