using BarsWeb.Areas.CreditFactory.Infrastructure.DI.Abstract;
using Areas.CreditFactory.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.CreditFactory.Infrastructure.Repository.DI.Implementation
{
    public class CreditFactoryModel : ICreditFactoryModel
    {
        private CreditFactoryEntities _entities;
        public CreditFactoryEntities CreditFactoryEntities
        {
            get
            {
                if (_entities == null)
                {
                    var connectionStr = EntitiesConnection.ConnectionString("CreditFactoryModel", "CreditFactory");
                    _entities = new CreditFactoryEntities(connectionStr);
                }
                return _entities;
            }
        }
    }
}
