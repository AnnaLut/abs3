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
    public class CPToAnotherBagRepository : ICPToAnotherBagRepository
    {
        public CPToAnotherBagRepository()
        {
        }

        public List<Inputs> GetInputs(decimal id)
        {
            string sql = "SELECT EMI, DOX, CP_ID, KV, DATP, nvl(IR,0) as IR, DAT_EM,  cena FROM cp_kod  WHERE id = " + id;
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var data = connection.Query<Inputs>(sql).ToList();
                return data;
            }
        }
        public List<FirstComboBox> GetFirstComboBox(decimal id)
        {
            string sql = @"select * from table (value_paper.getPFcombo(:p_id))";
            var p = new DynamicParameters();
            p.Add("p_id", dbType: DbType.Decimal, value: id, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var data = connection.Query<FirstComboBox>(sql, p).ToList();
                return data;
            }
        }

        public List<SecondComboBox> GetSecondComboBox(decimal id, decimal vidd)
        {
            string sql = @"select * from table (value_paper.getRYNcombo(:p_vidd, :p_id))";
            var p = new DynamicParameters();
            p.Add("p_vidd", dbType: DbType.Decimal, value: vidd, direction: ParameterDirection.Input);
            p.Add("p_id", dbType: DbType.Decimal, value: id, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var data = connection.Query<SecondComboBox>(sql, p).ToList();
                return data;
            }
        }
        public List<SecondInputs> GetInputs(decimal id, decimal ryn, decimal emi, decimal pf, decimal vidd, decimal kv)
        {
            string sql = @"SELECT p.NLSA, -sum(OSTB)/100 as OSTB, -sum(OSTC)/100 as OSTC
                            FROM accounts a, cp_deal d, cp_accc p
                            WHERE d.id = :id and d.acc = a.acc and d.RYN = :ryn and p.RYN = :ryn
                              and p.EMI =:emi and p.PF =:pf and p.vidd =:vidd and a.kv =:kv
                            GROUP BY p.NLSA";
            var p = new DynamicParameters();
            p.Add("id", dbType: DbType.Decimal, value: id, direction: ParameterDirection.Input);
            p.Add("ryn", dbType: DbType.Decimal, value: ryn, direction: ParameterDirection.Input);
            p.Add("emi", dbType: DbType.Decimal, value: emi, direction: ParameterDirection.Input);
            p.Add("pf", dbType: DbType.Decimal, value: pf, direction: ParameterDirection.Input);
            p.Add("vidd", dbType: DbType.Decimal, value: vidd, direction: ParameterDirection.Input);
            p.Add("kv", dbType: DbType.Decimal, value: kv, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var data = connection.Query<SecondInputs>(sql, p).ToList();
                return data;
            }
        }

        public List<FirstComboBox> GetThirdComboBox(decimal emi, decimal dox, decimal pf)
        {
            string sql = @"select * from table (value_paper.getPFcomboEmi(:p_emi, :p_dox, :p_pf))";
            var p = new DynamicParameters();
            p.Add("p_emi", dbType: DbType.Decimal, value: emi, direction: ParameterDirection.Input);
            p.Add("p_dox", dbType: DbType.Decimal, value: dox, direction: ParameterDirection.Input);
            p.Add("p_pf", dbType: DbType.Decimal, value: pf, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var data = connection.Query<FirstComboBox>(sql, p).ToList();
                return data;
            }
        }

        public List<SecondComboBox> GetFourthComboBox(decimal emi, decimal dox, decimal vidd)
        {
            string sql = @"select * from table (value_paper.getRYNcomboEmi(:p_emi, :p_dox, :p_vidd))";
            var p = new DynamicParameters();
            p.Add("p_emi", dbType: DbType.Decimal, value: emi, direction: ParameterDirection.Input);
            p.Add("p_dox", dbType: DbType.Decimal, value: dox, direction: ParameterDirection.Input);
            p.Add("p_vidd", dbType: DbType.Decimal, value: vidd, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var data = connection.Query<SecondComboBox>(sql, p).ToList();
                return data;
            }
        }

        public string GetNlsa(decimal ryn, decimal emi, decimal pf, decimal vidd)
        {
            string sql = @"SELECT NLSA  FROM cp_accc  WHERE RYN=:ryn and EMI=:emi and PF=:pf and vidd=:vidd";
            var p = new DynamicParameters();
            p.Add("ryn", dbType: DbType.Decimal, value: ryn, direction: ParameterDirection.Input);
            p.Add("emi", dbType: DbType.Decimal, value: emi, direction: ParameterDirection.Input);
            p.Add("pf", dbType: DbType.Decimal, value: pf, direction: ParameterDirection.Input);
            p.Add("vidd", dbType: DbType.Decimal, value: vidd, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                var data = connection.Query<string>(sql, p).SingleOrDefault();
                return data;
            }
        }

        public void MakeMDTable(decimal id, decimal pf, decimal ryn)
        {
            string sql = @"begin
                        PUL.PUT('CP_ID', :id);
                        PUL.PUT('CP_PF', :pf);
                        PUL.PUT('CP_RYN', :ryn);
                       end;";
            var p = new DynamicParameters();
            p.Add("id", dbType: DbType.String, value: Convert.ToString(id), direction: ParameterDirection.Input);
            p.Add("pf", dbType: DbType.String, value: Convert.ToString(pf), direction: ParameterDirection.Input);
            p.Add("ryn", dbType: DbType.String, value: Convert.ToString(ryn), direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
        }

        public ResultInsert InsertValuePaper(decimal id, decimal pf_1, decimal ryn_1, decimal pf_2, decimal ryn_2,  decimal sum, decimal _ref, string nazn, bool kor)
        {
            var result = new ResultInsert();
            var VOB = 0;
            if (kor)
                VOB = 96;
            else
                VOB = 6;
            string sql = @"begin
                        CP.CP_MOVE
                           (22,
                            :VOB_,
                            :nID_,
                            :nRYN1_,
                            :nNBS1_,
                            :nRYN2_,
                            :nNBS2_,
                            :SUMN,
                            :nREF_,
                            :NAZN_,
                            '37392555',
                            :sREF,
                            :sErr,
                            :REF_MAIN);
                    end;";
            var p = new DynamicParameters();
            p.Add("VOB_", dbType: DbType.Int16, value: VOB, direction: ParameterDirection.Input);
            p.Add("nID_", dbType: DbType.Decimal, value: id, direction: ParameterDirection.Input);
            p.Add("nRYN1_", dbType: DbType.Decimal, value: ryn_1, direction: ParameterDirection.Input);
            p.Add("nNBS1_", dbType: DbType.Decimal, value: pf_1, direction: ParameterDirection.Input);
            p.Add("nRYN2_", dbType: DbType.Decimal, value: ryn_2, direction: ParameterDirection.Input);
            p.Add("nNBS2_", dbType: DbType.Decimal, value: pf_2, direction: ParameterDirection.Input);
            p.Add("SUMN", dbType: DbType.Decimal, value: sum, direction: ParameterDirection.Input);
            p.Add("nREF_", dbType: DbType.Decimal, value: _ref, direction: ParameterDirection.Input);
            p.Add("NAZN_", dbType: DbType.String, size:200, value: nazn, direction: ParameterDirection.Input);
            p.Add("sREF", dbType: DbType.String, size: 200, direction: ParameterDirection.Output);
            p.Add("sErr", dbType: DbType.String, size: 200, direction: ParameterDirection.Output);
            p.Add("REF_MAIN", dbType: DbType.Decimal, direction: ParameterDirection.Output);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
            result.sREF = p.Get<string>("sREF");
            result.sErr = p.Get<string>("sErr");
            result.REF_MAIN = p.Get<decimal?>("REF_MAIN");
            return result;
        }

        public void UpdateTicketNumber(int REF_MAIN, string ticket_number)
        {
            string sql = @"update oper set nd=:ticket_number where ref = :REF_MAIN";
            var p = new DynamicParameters();
            p.Add("REF_MAIN", dbType: DbType.Int32, value: REF_MAIN, direction: ParameterDirection.Input);
            p.Add("ticket_number", dbType: DbType.String, size: 200, value: ticket_number, direction: ParameterDirection.Input);
            using (var connection = OraConnector.Handler.UserConnection)
            {
                connection.Execute(sql, p);
            }
        }
    }
}