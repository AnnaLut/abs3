using BarsWeb.Areas.CRSOUR.Infrastructure.DI.Abstract;
using Areas.CRSOUR.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.CRSOUR.Infrastructure.Repository.DI.Implementation
{
    public class DealsModel : IDealsModel
    {
        private DealsEntities _entities;
        public DealsEntities DealsEntities
        {
            get
            {
                if (_entities == null)
                {
                    var connectionStr = EntitiesConnection.ConnectionString("DealsModel", "CRSOUR");
                    _entities = new DealsEntities(connectionStr);
                }
                return _entities;
            }
        }
    }
}
