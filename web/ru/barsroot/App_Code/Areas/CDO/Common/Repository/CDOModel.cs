using BarsWeb.Models;
using Models;

namespace BarsWeb.Areas.CDO.Common.Repository
{
    public class CDOModel : ICDOModel
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

    public interface ICDOModel
    {
        EntitiesBars CorpLightEntities { get; }
    }
}
