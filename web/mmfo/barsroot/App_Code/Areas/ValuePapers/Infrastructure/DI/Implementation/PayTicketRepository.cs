using Bars.Classes;
using BarsWeb.Areas.ValuePapers.Infrastructure.DI.Abstract;
using Dapper;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using BarsWeb.Areas.ValuePapers.Models;
using System;

namespace BarsWeb.Areas.ValuePapers.Infrastructure.DI.Implementation
{
    public class PayTicketRepository : IPayTicketRepository
    {
        public PayTicketRepository()
        {
        }

        public PayTicketInputs GetModel(string strPar01, string strPar02, decimal? nGrp, decimal? nMode)
        {
            string sql = @"select * from table(value_paper.prepare_cpr_wnd(:strPar01, :strPar02, :nGrp, :nMode))";
            var p = new DynamicParameters();
            p.Add("strPar01", dbType: DbType.String, size: 200, value: strPar01, direction: ParameterDirection.Input);
            p.Add("strPar02", dbType: DbType.String, size: 200, value: strPar02, direction: ParameterDirection.Input);
            p.Add("nGrp", dbType: DbType.Decimal, value: nGrp, direction: ParameterDirection.Input);
            p.Add("nMode", dbType: DbType.Decimal, value: nMode, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<PayTicketInputs>(sql, p).ToList()[0];
            }

        }
        public List<PayTicketGrid> GetGridData(string strPar01, string strPar02, decimal? nGrp, decimal? nMode, decimal? p_nRyn, decimal? p_nPf)
        {
            string sql = @"select * from table(value_paper.populate_cpr_wnd(:strPar01,:strPar02, :nGrp, :nMode, :p_nRyn, :p_nPf))";
            var p = new DynamicParameters();
            p.Add("strPar01", dbType: DbType.String, size: 200, value: strPar01, direction: ParameterDirection.Input);
            p.Add("strPar02", dbType: DbType.String, size: 200, value: strPar02, direction: ParameterDirection.Input);
            p.Add("nGrp", dbType: DbType.Decimal, value: nGrp, direction: ParameterDirection.Input);
            p.Add("nMode", dbType: DbType.Decimal, value: nMode, direction: ParameterDirection.Input);
            p.Add("p_nRyn", dbType: DbType.Decimal, value: p_nRyn, direction: ParameterDirection.Input);
            p.Add("p_nPf", dbType: DbType.Decimal, value: p_nPf, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                var data = connection.Query<PayTicketGrid>(sql, p).ToList();
                return data;
            }
        }
        
        public AfterSaveParams SaveCP(int p_nTipD, int p_cb_Zo, int p_nGrp, int p_nID, int p_nRYN, string p_nVidd, decimal p_SUMK)
        {
            var data = new AfterSaveParams();
            string sql = @"begin
                            value_paper.saveCPR(:p_nTipD, :p_cb_Zo, :p_nGrp, :p_nID, :p_nRYN, :p_nVidd, :p_SUMK, :p_sREF, :p_sErr, :p_REF_MAIN);
                           end;";
            var p = new DynamicParameters();
            p.Add("p_nTipD", dbType: DbType.Int32, value: p_nTipD, direction: ParameterDirection.Input);
            p.Add("p_cb_Zo", dbType: DbType.Int32, value: p_cb_Zo, direction: ParameterDirection.Input);
            p.Add("p_nGrp", dbType: DbType.Int32, value: p_nGrp, direction: ParameterDirection.Input);
            p.Add("p_nID", dbType: DbType.Int32, value: p_nID, direction: ParameterDirection.Input);
            p.Add("p_nRYN", dbType: DbType.Int32, value: p_nRYN, direction: ParameterDirection.Input);
            p.Add("p_nVidd", dbType: DbType.String, size: 50, value: p_nVidd, direction: ParameterDirection.Input);
            p.Add("p_SUMK", dbType: DbType.Decimal, value: p_SUMK, direction: ParameterDirection.Input);
            p.Add("p_sREF", dbType: DbType.String, size: 50, direction: ParameterDirection.Output);
            p.Add("p_sErr", dbType: DbType.String, size: 200, direction: ParameterDirection.Output);
            p.Add("p_REF_MAIN", dbType: DbType.String, size: 50, direction: ParameterDirection.Output);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }

            data.p_sREF = p.Get<string>("p_sREF");
            data.p_sErr = p.Get<string>("p_sErr");
            data.p_REF_MAIN = p.Get<string>("p_REF_MAIN");

            return data;
        }

        public double GetSumiAll(string strPar01, int kv, int pf, int emi, string vidd, int dox, int ryn)
        {
            string sql = @"select value_paper.get_sumi_all(:strPar01, :kv, :pf, :emi, :vidd, :dox, :ryn) from dual";
            var p = new DynamicParameters();
            p.Add("strPar01", dbType: DbType.String, value: strPar01, direction: ParameterDirection.Input);
            p.Add("kv", dbType: DbType.Int32, value: kv, direction: ParameterDirection.Input);
            p.Add("pf", dbType: DbType.Int32, value: pf, direction: ParameterDirection.Input);
            p.Add("emi", dbType: DbType.Int32, value: emi, direction: ParameterDirection.Input);
            p.Add("vidd", dbType: DbType.String, value: vidd, direction: ParameterDirection.Input);
            p.Add("dox", dbType: DbType.Int32, value: dox, direction: ParameterDirection.Input);
            p.Add("ryn", dbType: DbType.Int32, value: ryn, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                var sumi_all = connection.Query<double>(sql, p).SingleOrDefault();
                return sumi_all; 
            }
        }

        public List<PayTicketGrid> GetGridData(int p_ID, int nRYN, int nGRP)
        {
            string sql = @"select * from table(value_paper.populate_cpv_wnd(:p_ID, :nRYN ,:nGRP))";
            var p = new DynamicParameters();
            p.Add("p_ID", dbType: DbType.Int32, value: p_ID, direction: ParameterDirection.Input);
            p.Add("nGRP", dbType: DbType.Int32, value: nGRP, direction: ParameterDirection.Input);
            p.Add("nRYN", dbType: DbType.Int32, value: nRYN, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var data = connection.Query<PayTicketGrid>(sql, p).ToList();
                return data;
            }
        }

        
        public object GetModel(int p_ID, decimal? nGrp)
        {
            string sql = @"select * from table(value_paper.prepare_cpv_wnd(:p_ID, :nGRP))";
            var p = new DynamicParameters();
            p.Add("p_ID", dbType: DbType.String, size: 200, value: p_ID, direction: ParameterDirection.Input);
            p.Add("nGRP", dbType: DbType.Decimal, value: nGrp, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                var data = connection.Query<object>(sql, p).ToList();
                return data[0];
            }
        }

        public IList<DropDownModel> dataListFor_cbm_RYN(int kv)
        {
            string sqlText = @"select RYN as VAL, NAME as TEXT from CP_RYN
                                WHERE TIPD=2 and ( KV is null OR kv= :kv ) ORDER BY RYN";
            var p = new DynamicParameters();
            p.Add("kv", dbType: DbType.Int32, value: kv, direction: ParameterDirection.Input);

            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<DropDownModel>(sqlText, p).ToList();
            }
        }
    }
}
