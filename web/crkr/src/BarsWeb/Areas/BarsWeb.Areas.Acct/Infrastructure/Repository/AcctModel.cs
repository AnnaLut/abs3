using BarsWeb.Areas.Acct.Models;
using BarsWeb.Core;

namespace BarsWeb.Areas.Acct.Infrastructure.Repository
{
    public class AcctModel : IAcctModel
    {
        private AcctDbContext _dbContext;
        public AcctDbContext GetDbContext()
        {
            if (_dbContext == null)
            {
                _dbContext = new AcctDbContext(Constants.AppConnectionStringName);
            }
            return _dbContext;
        }
    }
    public interface IAcctModel
    {
        AcctDbContext GetDbContext();
    }
}
