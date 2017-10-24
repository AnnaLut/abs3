using System;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using System.Data;
using System.Data.Objects;
using System.IO;
using System.Text;
using System.Drawing;
using BarsWeb.Models;
using Kendo.Mvc.UI;
using BarsWeb.Areas.BaseRates.Infrastructure.Repository.DI.Abstract;
using System.Linq;
using BarsWeb.Areas.Kernel.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Kernel.Models;
using Bars.Classes;
using Dapper;
using BarsWeb.Areas.BaseRates.Models;

namespace BarsWeb.Areas.BaseRates.Infrastructure.Repository.DI.Implementation
{
    public class BaseRatesRepository : IBaseRatesRepository
    {
        public BarsSql _getSql;
        private readonly IKendoSqlTransformer _sqlTransformer;
        private readonly IKendoSqlCounter _kendoSqlCounter;
        public BaseRatesRepository(IKendoSqlTransformer sqlTransformer, IKendoSqlCounter kendoSqlCounter)
        {
            _sqlTransformer = sqlTransformer;
            _kendoSqlCounter = kendoSqlCounter;
        }
        public IQueryable<V_BRATES_KF> GetBrates()
        {
            List<V_BRATES_KF> rates = new List<V_BRATES_KF>();
            OracleConnection con = OraConnector.Handler.UserConnection;
            OracleCommand cmd = con.CreateCommand();
            cmd.CommandType = System.Data.CommandType.Text;
            string sql = string.Empty;
            try
            {
                sql = @"select br_id, 
                                        br_name, 
                                        type_id, 
                                        type_name, 
                                        inuse
                                        from bars.v_brates_kf
                        order by 1";
                cmd.CommandText = sql;
                OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    V_BRATES_KF b_rate = new V_BRATES_KF();
                    b_rate.BR_ID = String.IsNullOrEmpty(reader.GetValue(0).ToString()) ? (decimal?)null : reader.GetDecimal(0);
                    b_rate.BR_NAME = String.IsNullOrEmpty(reader.GetValue(1).ToString()) ? String.Empty : reader.GetString(1);
                    b_rate.TYPE_ID = String.IsNullOrEmpty(reader.GetValue(2).ToString()) ? (decimal?)null : reader.GetDecimal(2);
                    b_rate.TYPE_NAME = String.IsNullOrEmpty(reader.GetValue(3).ToString()) ? String.Empty : reader.GetString(3);
                    b_rate.INUSE = String.IsNullOrEmpty(reader.GetValue(4).ToString()) ? (decimal?)null : reader.GetDecimal(4);
                    rates.Add(b_rate);
                }

            }
            finally
            {
                cmd.Dispose();
                con.Dispose();
                con.Close();

            }
            return rates.AsQueryable();
        }

        public List<DDBranches> GetDDBranches()
        {
            List<DDBranches> list = new List<DDBranches>();
            string sql_query = @"SELECT BRANCH as VALUE, BRANCH || ' ' || NAME as TEXT FROM OUR_BRANCH ORDER BY BRANCH";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<DDBranches>(sql_query).ToList();
            }
            DDBranches allbranches = new DDBranches();
            allbranches.TEXT = "Усі відділення";
            allbranches.VALUE = "-";
            list.Add(allbranches);
            return list;
        }

        public List<TbBrates> GetInterestRates(string branch, bool inarchive, int? brtype, int? brid)
        {
            string dopTbl = "";
            string sql_query = "";
            string bd = GetBankDate().ToString("dd/MM/yyyy");
            List<TbBrates> list = new List<TbBrates>();
            if (brtype == 2 || brtype == 3 || brtype == 5 || brtype == 6 || brtype == 7 || brtype == 8)//ступенчатая
            {
                if (branch == "-")
                    dopTbl = "br_tier_edit";
                else
                    dopTbl = String.Format(@"(SELECT  b.br_id, b.bdate, b.kv, b.rate, b.s, b.branch                  
                                        FROM br_tier_edit b                                                    
                                       WHERE b.branch = '{0}'                                                    
                                                        union                                                  
                                                        SELECT b.br_id, b.bdate, b.kv, b.rate, b.s, '{0}'      
                                                        FROM br_tier_edit b, branch_mfo m                      
                                                        WHERE b.branch = '/' || m.mfo || '/'                         
                                                        and '{0}' like '/' || m.mfo || '/%'                         
                                                        and(b.br_id, b.bdate, b.kv) not in                    
                                                            (SELECT b.br_id, b.bdate, b.kv                     
                                                        FROM br_tier_edit b                                    
                                                        WHERE b.branch = '{0}')                                 
                                                            union                                                  
                                                            SELECT b.br_id, b.bdate, b.kv, b.rate, b.s, '{0}'      
                                                            FROM br_tier_edit b                                    
                                                            WHERE b.branch = '/'                                     
                                                            and(b.br_id, b.bdate, b.kv) not in                    
                                                                (SELECT b.br_id, b.bdate, b.kv                     
                                                            FROM br_tier_edit b  , branch_mfo m                    
                                                            WHERE b.branch in ('/' || m.mfo || '/', '{0}')             
                                                            and '{0}' like '/' || m.mfo || '/%' ) )", branch);

                if (!inarchive)
                    sql_query = String.Format(@"SELECT  a.bdate as DATB, a.kv as KV, b.rate as IR, b.s/100 as S, b.branch as BRANCH, r.name as BRANCH_NAME
                               FROM (SELECT br_id, max(bdate) bdate, kv, branch
                                        FROM {1}
                                        WHERE br_id = {2} and bdate <= to_date('{3}', 'dd/MM/yyyy')
                                        GROUP BY br_id, kv, branch) a, {1} b, branch r
                               WHERE a.br_id = b.br_id AND a.bdate = b.bdate AND a.kv = b.kv
                                    AND a.branch = b.branch AND a.branch like '{4}%'" + (branch == "-" ? "" : " AND b.branch ='{0}' ") +
                                      @"AND a.branch = r.branch
                                    ORDER BY a.bdate DESC, a.kv, b.s", branch, dopTbl, brid, bd, GetCurrTOBO());
                else
                    sql_query = String.Format(@"SELECT  a.bdate as DATB, a.kv as KV, a.rate as IR, a.s/100 as S, a.branch as BRANCH, r.name as BRANCH_NAME
                                               FROM {1} a, branch r
                                              WHERE a.br_id ={3} AND a.branch like '{2}%'" + (branch == "-" ? "" : " AND a.branch ='{0}'") +
                                              @"AND a.branch = r.branch
                                              ORDER BY a.bdate DESC, a.kv, a.s", branch, dopTbl, GetCurrTOBO(), brid);
            }
            else //нормальная
            {
                if (branch == "-")
                    dopTbl = "br_normal_edit";
                else
                    dopTbl = String.Format(@"(SELECT  b.br_id, b.bdate, b.kv, b.rate, b.branch
                                             FROM br_normal_edit b  
                                             WHERE b.branch='{0}' 
                                             union 
                                             SELECT b.br_id, b.bdate, b.kv, b.rate, '{0}'
                                             FROM br_normal_edit b, branch_mfo m
                                             WHERE b.branch='/'||m.mfo||'/' 
                                               and '{0}' like '/'||m.mfo||'/%' 
                                               and (b.br_id, b.bdate, b.kv) not in 
                                                   (SELECT b.br_id, b.bdate, b.kv
                                                    FROM br_normal_edit b  
                                                    WHERE b.branch='{0}' )
                                             union 
                                             SELECT b.br_id, b.bdate, b.kv, b.rate, '{0}'
                                             FROM br_normal_edit b  
                                             WHERE b.branch='/' 
                                               and (b.br_id, b.bdate, b.kv) not in 
                                                   (SELECT b.br_id, b.bdate, b.kv
                                                    FROM br_normal_edit b  , branch_mfo m
                                                    WHERE b.branch in ('/'||m.mfo||'/', '{0}')
                                                      and '{0}' like '/'||m.mfo||'/%' ) )", branch);

                if (!inarchive)
                    sql_query = String.Format(@"SELECT  a.bdate as DATB, a.kv as KV, b.rate as IR, b.branch as BRANCH, r.name as BRANCH_NAME 
                                               FROM (SELECT br_id, max(bdate) bdate, kv, branch
                                                       FROM {0}
                                                      WHERE br_id ={1} and bdate <= to_date('{2}', 'dd/MM/yyyy')
                                                      GROUP BY br_id, kv, branch) a, {0} b, branch r
                                              WHERE a.br_id = b.br_id AND a.bdate = b.bdate AND a.kv = b.kv
                                                AND a.branch = b.branch AND a.branch like '{3}%'
                                                AND a.branch = r.branch
                                              ORDER BY a.bdate, a.kv DESC, b.branch", dopTbl, brid, bd, GetCurrTOBO());
                else
                    sql_query = String.Format(@"SELECT  a.bdate as DATB, a.kv as KV, a.rate as IR, a.branch as BRANCH, r.name as BRANCH_NAME 
                                                FROM {1} a, branch r
                                                WHERE a.br_id ={3} AND a.branch like '{2}%'" + (branch == "-" ? "" : " AND a.branch ='{0}'") +
                                                @"AND a.branch = r.branch
                                                ORDER BY a.bdate, a.kv DESC, a.branch", branch, dopTbl, GetCurrTOBO(), brid);
            }
            string tmp = sql_query;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<TbBrates>(sql_query).ToList();
            }
            return list;
        }

        public DateTime GetBankDate()
        {
            string sql = @"select GetGlobalOption('BANKDATE') from dual";
            DateTime bdate = new DateTime();

            using (var connection = OraConnector.Handler.UserConnection)
            {
                bdate = connection.Query<DateTime>(sql).SingleOrDefault();
            }
            return bdate;
        }

        public string GetCurrTOBO()
        {
            string sql = @"SELECT substr(tobopack.GetTOBO, 1, 30) FROM dual";
            string tobo = "";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                tobo = connection.Query<string>(sql).SingleOrDefault();
            }
            return tobo;
        }

        public List<DDKVs> GetKVs()
        {
            string sql = @"select KV as VALUE, NAME as TEXT from tabval order by skv";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<DDKVs>(sql).ToList();
            }
        }

        public void AddInterestBratesToBD(List<TbBrates> list, decimal br_id)
        {

            try
            {
                foreach (TbBrates model in list)
                {
                    AddInterestBrateToBD(model, br_id);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
           
            

        }

        public void AddInterestBrateToBD(TbBrates model,decimal brId)
        {
            string sql = @"begin
                        BARS.ACRN.SET_BRATE_VAL(:p_br_id, :p_ccy_id, to_date(:p_eff_dt, 'dd/MM/yyyy'), :p_amnt, :p_rate, :p_err_msg);
                    end;";

            var p = new DynamicParameters();
            p = new DynamicParameters();
            p.Add("p_br_id", dbType: DbType.Decimal, value: brId, direction: ParameterDirection.Input);
            p.Add("p_eff_dt", dbType: DbType.String, value: model.DATB.ToString("dd/MM/yyyy"), direction: ParameterDirection.Input);
            p.Add("p_ccy_id", dbType: DbType.Decimal, value: model.KV, direction: ParameterDirection.Input);
            p.Add("p_amnt", dbType: DbType.Decimal, value: model.S * 100, direction: ParameterDirection.Input);
            p.Add("p_rate", dbType: DbType.Decimal, value: model.IR, direction: ParameterDirection.Input);
            p.Add("p_err_msg", dbType: DbType.String, direction: ParameterDirection.Output);

            OracleConnection conn = Bars.Classes.OraConnector.Handler.UserConnection;
            OracleTransaction trans = conn.BeginTransaction();
            try
            {
                conn.Execute(sql, p);
                var error = p.Get<string>("p_err_msg");
                if (error == "" || error == null)
                {
                    trans.Commit();
                    conn.Close();
                }
                else
                {
                    trans.Rollback();
                    conn.Close();
                    throw new Exception(error);
                }
            }
            catch (Exception ex)
            {
                if (trans != null)
                    trans.Rollback();
                if (conn != null && conn.State == ConnectionState.Open)
                    conn.Close();
                throw ex;
            }
        }

        public void EditInterestBratesToBD(EditInterestBrateRequestModel request)
        {
            foreach (var item in request.InterestList)
            {
                EditInterestBrateToBD(item, request.br_id);
            }
        }

        public void EditInterestBrateToBD(UpdatedRowInterestData rowInterest,decimal brId)
        {
            DeleteBrate(rowInterest.OldRowInterestData, brId);
            AddInterestBrateToBD(rowInterest.NewRowInterestData, brId);
        }

        public List<RatesOptions> GetRateOptions(string branch, int brid, int kv, string bdate)
        {
            string sql = @"SELECT count(*) 
                            FROM br_tier_edit 
                            WHERE br_id=:nBrId AND bdate=to_date(:dBDate, 'dd.MM.yyyy') AND kv=:nKv AND branch=:sBranch";
            decimal count = 0;
            string tmp_branch = branch;
            List<RatesOptions> list = new List<RatesOptions>();

            var p = new DynamicParameters();
            p.Add("nBrId", dbType: DbType.Decimal, value: brid, direction: ParameterDirection.Input);
            p.Add("dBDate", dbType: DbType.String, value: bdate, direction: ParameterDirection.Input);
            p.Add("nKv", dbType: DbType.Int16, value: kv, direction: ParameterDirection.Input);
            p.Add("sBranch", dbType: DbType.String, value: tmp_branch, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                count = connection.Query<decimal>(sql, p).SingleOrDefault();
            }
            if (count > 0)
            {
                tmp_branch = branch;
            }
            else
                tmp_branch = GetCurrTOBO();

            p = new DynamicParameters();
            p.Add("nBrId", dbType: DbType.Decimal, value: brid, direction: ParameterDirection.Input);
            p.Add("dBDate", dbType: DbType.String, value: bdate, direction: ParameterDirection.Input);
            p.Add("nKv", dbType: DbType.Int16, value: kv, direction: ParameterDirection.Input);
            p.Add("sTmpBranch", dbType: DbType.String, value: tmp_branch, direction: ParameterDirection.Input);
            sql = @"SELECT s/100 as S, rate as IR
                     FROM br_tier_edit 
                     WHERE br_id=:nBrId AND bdate=to_date(:dBDate, 'dd/MM/yyyy') AND kv=:nKv AND branch=:sTmpBranch";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                list = connection.Query<RatesOptions>(sql, p).ToList();
            }
            return list;
        }

        public void DeleteBrate(TbBrates model, decimal br_id)
        {
            string sql = @"begin
                        BARS.ACRN.DEL_BRATE_VAL(:p_br_id, :p_ccy_id, to_date(:p_eff_dt, 'dd/MM/yyyy'), :p_amnt, :p_err_msg);
                    end;";

            var p = new DynamicParameters();
            OracleConnection conn = OraConnector.Handler.UserConnection;
            var trans = conn.BeginTransaction();
            p = new DynamicParameters();
            p.Add("p_br_id", dbType: DbType.Decimal, value: br_id, direction: ParameterDirection.Input);
            p.Add("p_ccy_id", dbType: DbType.Decimal, value: model.KV, direction: ParameterDirection.Input);
            p.Add("p_eff_dt", dbType: DbType.String, value: model.DATB.ToString("dd/MM/yyyy"), direction: ParameterDirection.Input);
            p.Add("p_amnt", dbType: DbType.Decimal, value: model.S*100, direction: ParameterDirection.Input);
            p.Add("p_err_msg", dbType: DbType.String, direction: ParameterDirection.Output);
            try
            {
                int res =  conn.Execute(sql, p);
                var error = p.Get<string>("p_err_msg");
                    if ((error == "" || error == null) && res <= 1)
                        trans.Commit();
                else
                {
                    trans.Rollback();
                    if (error != "" && error != null)
                        throw new Exception(error);
                    if (res > 1)
                        throw new Exception(string.Format("не вдалося виконати операцію для радка за кодом ставки  {0}  " +
                            " виконується більше одного видалення", br_id));
                }
            }
            catch (Exception ex)
            {
                if(trans != null && trans.Connection != null)
                trans.Rollback();
                throw ex;
            }
            finally
            {
                if (conn != null && conn.State == ConnectionState.Open)
                {
                    conn.Close();
                    conn.Dispose();
                }
            }
        }

        public List<DDKVs> GetRatesTypes()
        {
            string sql = @"select br_type as VALUE, name as TEXT from br_types order by 1";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<DDKVs>(sql).ToList();
            }
        }

        public void AddBaseRateToBD(V_BRATES_KF model)
        {
            string sql = @"begin
                        BARS.ACRN.SET_BRATES(:p_br_id, :p_br_tp, :p_br_nm, :p_br_frml, :p_actv, :p_cmnt, :p_err_msg);
                    end;";
            var p = new DynamicParameters();
            OracleConnection conn = Bars.Classes.OraConnector.Handler.UserConnection;
            var trans = conn.BeginTransaction();
            p = new DynamicParameters();
            p.Add("p_br_id", dbType: DbType.Decimal, value: model.BR_ID, direction: ParameterDirection.InputOutput);
            p.Add("p_br_tp", dbType: DbType.Decimal, value: model.TYPE_ID, direction: ParameterDirection.Input);
            p.Add("p_br_nm", dbType: DbType.String, size: 400, value: model.BR_NAME, direction: ParameterDirection.Input);
            p.Add("p_br_frml", dbType: DbType.Decimal, value: null, direction: ParameterDirection.Input);
            p.Add("p_actv", dbType: DbType.Decimal, value: model.INUSE, direction: ParameterDirection.Input);
            p.Add("p_cmnt", dbType: DbType.String, size: 400, value: null, direction: ParameterDirection.Input);
            p.Add("p_err_msg", dbType: DbType.String, size: 400, direction: ParameterDirection.Output);
            try
            {
                conn.Execute(sql, p);
                var error = p.Get<string>("p_err_msg");
                if (error == "" || error == null)
                    trans.Commit();
                else
                {
                    throw new Exception(error);
                }
            }
            catch (Exception ex)
            {
                trans.Rollback();
                conn.Close();
                throw ex;
            }
            conn.Close();
        }
    }
}
