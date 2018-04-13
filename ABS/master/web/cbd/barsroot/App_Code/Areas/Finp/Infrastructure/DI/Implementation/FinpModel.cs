using BarsWeb.Areas.Finp.Infrastructure.DI.Abstract;
using Areas.Finp.Models;
using BarsWeb.Models;

namespace BarsWeb.Areas.Finp.Infrastructure.Repository.DI.Implementation
{
    public class FinpModel : IFinpModel
    {
        private FinpEntities _entities;
        public FinpEntities FinpEntities
        {
            get
            {
                if (_entities == null)
                {
                    var connectionStr = EntitiesConnection.ConnectionString("FinpModel", "Finp");
                    _entities = new FinpEntities(connectionStr);
                }
                return _entities;
            }
        }
    }
}
