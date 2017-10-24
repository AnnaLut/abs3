using Areas.Sep.Models;
using BarsWeb.Areas.Kernel.Models;
using BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Areas.Sep.Models;
using BarsWeb.Models;
using Oracle.DataAccess.Client;
using System;
using System.Linq;

namespace BarsWeb.Areas.Sep.Infrastructure.Repository.DI.Implementation
{
    public class BpRulesRepository : IBpRulesRepository 
    {
        private readonly SepFiles _entities;
	    public BpRulesRepository()
	    {
            var connectionStr = EntitiesConnection.ConnectionString("SepFiles", "Sep");
            _entities = new SepFiles(connectionStr);
	    }

        public IQueryable<SepRule> GetBpRules()
        {
            string query = "SELECT rowid ID, FA, RULE, rtrim(body) BODY, NAME FROM bp_rrp";
            return _entities.ExecuteStoreQuery<SepRule>(query, new object[0]).AsQueryable();
        }

        public bool DeleteBpRules(SepRule item)
        {
            try
            {
                var query = new BarsSql()
                {
                    SqlParams = new object[]{
                    new OracleParameter("ID", OracleDbType.Varchar2).Value =item.ID
                },
                    SqlText = "DELETE FROM Bp_rrp WHERE rowid=:ID"
                };

                _entities.ExecuteStoreCommand(query.SqlText, query.SqlParams);
            }
            catch (Exception ex)
            {
                Console.Write(ex);
                return false;
            }
            return true;
        }

        public bool UpdateBpRules(SepRule item)
        {
            try
            {
                var query = new BarsSql()
                {
                    SqlParams = new object[]{
                    new OracleParameter("RULE", OracleDbType.Int32).Value = item.RULE,
                    new OracleParameter("BODY", OracleDbType.Varchar2).Value =item.BODY,
                    new OracleParameter("FA", OracleDbType.Char).Value =item.FA,
                    new OracleParameter("NAME", OracleDbType.Varchar2).Value =item.NAME,
                    new OracleParameter("ID", OracleDbType.Varchar2).Value =item.ID
                },
                    SqlText = "UPDATE Bp_rrp SET rule=:RULE, body=:BODY, fa=:FA, name=:NAME WHERE rowid=:ID"
                };

                _entities.ExecuteStoreCommand(query.SqlText, query.SqlParams);
            }
            catch (Exception ex)
            {
                Console.Write(ex);
                return false;
            }
            return true; 
        }

        public bool CreateBpRules(SepRule item)
        {
            try
            {
                var query = new BarsSql()
                {
                    SqlParams = new object[]{
                    new OracleParameter("RULE", OracleDbType.Int32).Value = item.RULE,
                    new OracleParameter("BODY", OracleDbType.Varchar2).Value =item.BODY,
                    new OracleParameter("NAME", OracleDbType.Varchar2).Value =item.NAME,
                    new OracleParameter("FA", OracleDbType.Char).Value =item.FA
                },
                    SqlText = "INSERT INTO Bp_rrp (rule, body, name, fa) VALUES (:RULE, :BODY, :NAME, :FA)"
                };

                _entities.ExecuteStoreCommand(query.SqlText, query.SqlParams);
            }
            catch(Exception ex) {
                Console.Write(ex);
                return false;
            }
            return true;            
        }
    }
}