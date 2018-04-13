using BarsWeb.Areas.Cash.Infrastructure.DI.Abstract;
using Areas.Cash.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.Cash.Infrastructure.Repository.DI.Implementation
{
    public class CashModel : ICashModel
    {
        private CashEntities _entities;
        public CashEntities CashEntities
        {
            get
            {
                if (_entities == null)
                {
                    var connectionStr = EntitiesConnection.ConnectionString("CashModel", "Cash");
                    _entities = new CashEntities(connectionStr);
                }
                return _entities;
            }
        }
    }
}
