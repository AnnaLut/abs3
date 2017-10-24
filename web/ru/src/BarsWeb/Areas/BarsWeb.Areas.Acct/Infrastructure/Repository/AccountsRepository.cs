using System;
using System.Linq;
using BarsWeb.Areas.Acct.Models;

namespace BarsWeb.Areas.Acct.Infrastructure.Repository
{
    /// <summary>
    /// Summary description for Accounts
    /// </summary>
    public class AccountsRepository : IAccountsRepository
    {
        readonly AcctDbContext _dbContext;

        public AccountsRepository(IAcctModel model)
        {
            _dbContext = model.GetDbContext();
        }

        public IQueryable<Account> GetAllAccounts()
        {
            return _dbContext.Accounts;
        }

        public Account GetAccount(decimal id)
        {
            return _dbContext.Accounts.FirstOrDefault(i => i.Id == id);
        }
        public AccountSaldo GetAccount(decimal id, string type)
        {
            return _dbContext.AccountsSaldo.FirstOrDefault(i => i.Id == id);
        }
    }

    public interface IAccountsRepository
    {
        IQueryable<Account> GetAllAccounts();
        Account GetAccount(decimal id);
        AccountSaldo GetAccount(decimal id, string type);
    }

}
