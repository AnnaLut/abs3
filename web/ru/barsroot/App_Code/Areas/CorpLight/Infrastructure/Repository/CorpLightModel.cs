using BarsWeb.Models;
using Models;

namespace BarsWeb.Areas.CorpLight.Infrastructure.Repository
{
    public class CorpLightModel : ICorpLightModel
    {
        private EntitiesBars _entities;

        public EntitiesBars CorpLightEntities
        {
            get
            {
                var connectionStr = EntitiesConnection.ConnectionString();
                return _entities ?? new EntitiesBars(connectionStr);
            }
        }
    }

    public interface ICorpLightModel
    {
        EntitiesBars CorpLightEntities { get; }
    }
}
