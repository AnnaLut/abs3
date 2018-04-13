using Areas.Acct.Models;
using BarsWeb.Areas.Acct.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;

namespace BarsWeb.Areas.Acct.Infrastructure.Repository.DI.Implementation
{
    public class AcctModel : IAcctModel
    {
        private AcctEntities _entities;
        public AcctEntities AcctEntities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString("AcctModel","Acct");
                return _entities ?? new AcctEntities(connectionStr);
            }
        }
    }
}
