using Bars.Classes;
using BarsWeb.Areas.Way.Infrastructure.DI.Abstract;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
/// <summary>
/// Summary description for InstantCardsRepository
/// </summary>
/// 
namespace BarsWeb.Areas.Way.Infrastructure.DI.Implementation
{
    public class InstantCardsRepository : IInstantCardsRepository
    {
        public InstantCardsRepository()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public List<T> GetProduct<T>()
        {
            var sql = @"select code, name
                          from w4_product
                         where grp_code = 'INSTANT' and nvl(date_close, bankdate + 1) > bankdate
                         order by name";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql).ToList();
            }
        }
        public List<T> GetCardType<T>(dynamic code)
        {
            var p = new DynamicParameters();
            p.Add("code", dbType: DbType.String, size: 50, value: Convert.ToString(code), direction: ParameterDirection.Input);

            var sql = @"select code, sub_name
                  from v_w4_card
                 where product_code = :code
                 order by code";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<T>(sql, p).ToList();
            }
        }
        public string GetKV(dynamic sProductId)
        {
            var p = new DynamicParameters();
            p.Add("sProductId", dbType: DbType.String, size: 50, value: Convert.ToString(sProductId), direction: ParameterDirection.Input);

            var sql = @"SELECT t.name FROM w4_product p, tabval t WHERE p.code = :sProductId AND p.kv = t.kv";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                return connection.Query<string>(sql, p).FirstOrDefault();
            }
        }
        public string GetNB(dynamic sProductId)
        {
            var p = new DynamicParameters();
            p.Add("sProductId", dbType: DbType.String, size: 50, value: Convert.ToString(sProductId), direction: ParameterDirection.Input);

            var sql = @"select p.nbs from w4_product p where p.code = :sProductId";
            
            string result = "";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                result = connection.Query<string>(sql, p).FirstOrDefault();
                return result;
            }
        }
        public string GetBranch()
        {
            string sql = @"select branch_usr.get_branch from dual";
            string branch = "";

            using (var connection = OraConnector.Handler.UserConnection)
            {
                branch = connection.Query<string>(sql).SingleOrDefault();
            }
            return branch;
        }
        public void GetInstantCards(dynamic CARD_TYPE, dynamic CARD_AMOUNT)
        {
            var p = new DynamicParameters();
            String TYPE = Convert.ToString(CARD_TYPE);
            string branch = GetBranch();
            p.Add("p_cardcode", dbType: DbType.String, size: 150, value: TYPE, direction: ParameterDirection.Input);
            p.Add("p_branch", dbType: DbType.String, value: branch, direction: ParameterDirection.Input);
            p.Add("p_cardnum", dbType: DbType.Decimal, value: Convert.ToDecimal(CARD_AMOUNT), direction: ParameterDirection.Input);

            var sql = @"begin 
                          bars_ow.create_instant_cards(
                          :p_cardcode,
                          :p_branch,
                          :p_cardnum);
                        end;";
            using (var connection = OraConnector.Handler.UserConnection)
            {
                 connection.Execute(sql, p);
            }
        }
    }
}