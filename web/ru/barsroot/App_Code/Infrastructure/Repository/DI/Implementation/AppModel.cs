using BarsWeb.Infrastructure.Repository.DI.Abstract;
using BarsWeb.Models;
using Models;

namespace BarsWeb.Infrastructure.Repository.DI.Implementation
{
    public class AppModel : IAppModel
    {
        private readonly EntitiesBars _entities;

        public AppModel()
        {
            _entities = Entities;
        }

        public EntitiesBars Entities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString();
                return _entities ?? new EntitiesBars(connectionStr);
            }
        }
    }
}
