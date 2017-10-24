using System;
using System.Data;
using System.Linq;
using BarsWeb.Areas.Acct.Models;
using Oracle.DataAccess.Client;

namespace BarsWeb.Areas.Acct.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for ReservedAccounts
    /// </summary>
    public class ReservedAccountsRepository : IReservedAccountsRepository
    {
        readonly AcctDbContext _entities;

        public ReservedAccountsRepository(IAcctModel model)
        {
            _entities = model.GetDbContext();
        }

        public IQueryable<ReservedAccount> GetAllReservedAccounts()
        {
            return _entities.ReservedAccounts;
        }

        public decimal UnreserveAccount(decimal accountId)
        {
            var sql = @"begin accreg.p_unreserve_acc(:p_acc); end;";
            int result;
            try
            {
                result = _entities.Database.ExecuteSqlCommand(sql,accountId); 
            }
            catch (Exception e)
            {
                if (e.Message.StartsWith("ORA-20000"))
                {
                    var mess = e.Message.Substring(10,e.Message.Length - 11);
                    var indexOra = mess.IndexOf("ORA", StringComparison.Ordinal);
                    int length;
                    if (indexOra != -1)
                    {
                        length = indexOra;
                    }
                    else
                    {
                        length = mess.Length;
                    }
                    mess = mess.Substring(0, length);
                    throw new Exception(mess);
                }
                throw;
            }

            return result;
        }

        public decimal Reserved(ReservedAccountRegister account)
        {
            //var newId = new ObjectParameter("p_acc", typeof(decimal));

            object[] parameters = {
                    new OracleParameter("p_acc", OracleDbType.Decimal, 38){Direction = ParameterDirection.ReturnValue},
                    new OracleParameter("p_rnk", OracleDbType.Decimal, account.CustomerId, ParameterDirection.Input),
                    new OracleParameter("p_nls", OracleDbType.Varchar2, account.Number, ParameterDirection.Input),
                    new OracleParameter("p_kv", OracleDbType.Decimal,  account.CurrencyId, ParameterDirection.Input),
                    new OracleParameter("p_nms", OracleDbType.Varchar2, account.Name, ParameterDirection.Input),
                    new OracleParameter("p_tip", OracleDbType.Char, account.Type, ParameterDirection.Input),
                    new OracleParameter("p_grp", OracleDbType.Decimal, account.Group, ParameterDirection.Input),
                    new OracleParameter("p_isp", OracleDbType.Decimal, account.UserId, ParameterDirection.Input),
                    new OracleParameter("p_pap", OracleDbType.Decimal, account.Pap, ParameterDirection.Input),
                    new OracleParameter("p_vid", OracleDbType.Decimal, account.Subspecies, ParameterDirection.Input),
                    new OracleParameter("p_pos", OracleDbType.Decimal, account.Pos, ParameterDirection.Input),
                    new OracleParameter("p_blkd", OracleDbType.Decimal,account.DebitBlockCode, ParameterDirection.Input),
                    new OracleParameter("p_blkk", OracleDbType.Decimal,account.CreditBlockCode, ParameterDirection.Input),
                    new OracleParameter("p_lim", OracleDbType.Decimal, account.Limit, ParameterDirection.Input),
                    new OracleParameter("p_ostx", OracleDbType.Decimal, account.MaxBalance, ParameterDirection.Input),
                    new OracleParameter("p_nlsalt", OracleDbType.Varchar2, account.AlternativeNumber, ParameterDirection.Input),
                    new OracleParameter("p_branch", OracleDbType.Varchar2, account.Branch, ParameterDirection.Input),
                    //new OracleParameter("p_acc", OracleDbType.Decimal, 4000){Direction = ParameterDirection.ReturnValue}
                };

            var sql = @"begin accreg.p_reserve_acc (
                            :p_acc,
                            :p_rnk,
                            :p_nls,     
                            :p_kv,       
                            :p_nms,      
                            :p_tip,      
                            :p_grp,      
                            :p_isp,      
                            :p_pap,      
                            :p_vid,      
                            :p_pos,      
                            :p_blkd,     
                            :p_blkk,     
                            :p_lim,     
                            :p_ostx,     
                            :p_nlsalt,          
                            :p_branch); end;";
            /*_entities.Database.ExecuteSqlCommand(sql,
                account.CustomerId,
                account.Number,
                account.CustomerId,
                account.Name,
                account.Type,
                account.Group,
                account.UserId,
                null,
                account.Vid,
                account.Pos,
                account.DebitBlockCode,
                account.CreditBlockCode,
                account.Limit,
                account.MaxBalance,
                account.AlternativeNumber,
                account.Branch,
                newId);*/
            _entities.Database.ExecuteSqlCommand(sql,parameters);
            return Convert.ToDecimal(((OracleParameter)parameters[0]).Value.ToString());
        }
    }

    public interface IReservedAccountsRepository
    {
        IQueryable<ReservedAccount> GetAllReservedAccounts();
        decimal Reserved(ReservedAccountRegister account);
        decimal UnreserveAccount(decimal accountId);
    }
}
